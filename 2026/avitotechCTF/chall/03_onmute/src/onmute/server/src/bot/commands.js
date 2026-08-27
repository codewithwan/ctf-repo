import {
  getTrack, getOriginalText,
  addCensorRequest, getCensorCount,
  addReport, getReportCount,
} from '../models/tracks.js';
import { matchesPolicy } from '../moderation/filter.js';

const HELP_TEXT = `Доступные команды:
  /help                 — показать это сообщение
  /censor <start> <end> — предложить зацензурить фрагмент текста (по позициям символов)
  /report <причина>     — пожаловаться на трек
  /status <track_id>    — статус модерации трека
  /original <track_id>  — показать оригинальный текст без цензуры`;

export function parseCommand(text) {
  const trimmed = text.trim();

  if (/^\/help\s*$/i.test(trimmed)) return { cmd: 'help' };

  const censorMatch = trimmed.match(/^\/censor\s+(\d+)\s+(\d+)\s*$/i);
  if (censorMatch) {
    return {
      cmd: 'censor',
      start: parseInt(censorMatch[1], 10),
      end: parseInt(censorMatch[2], 10),
    };
  }

  const reportMatch = trimmed.match(/^\/report\s+(.+)$/i);
  if (reportMatch) return { cmd: 'report', reason: reportMatch[1].trim() };

  const statusMatch = trimmed.match(/^\/status\s+(\d+)\s*$/i);
  if (statusMatch) return { cmd: 'status', trackId: parseInt(statusMatch[1], 10) };

  const originalMatch = trimmed.match(/^\/original\s+(\d+)\s*$/i);
  if (originalMatch) return { cmd: 'original', trackId: parseInt(originalMatch[1], 10) };

  return null;
}

export async function handleCommand(cmd, ctx) {
  const { trackId, req } = ctx;

  switch (cmd.cmd) {
    case 'help':
      return { type: 'bot', message: HELP_TEXT };

    case 'censor': {
      const track = await getTrack(trackId);
      if (!track) return { type: 'bot', message: 'Трек не найден.' };

      if (cmd.start < 0 || cmd.end <= cmd.start || cmd.end > track.text.length) {
        return {
          type: 'bot',
          message: `Некорректные позиции. Текст трека содержит ${track.text.length} символов.`,
        };
      }

      if (cmd.end - cmd.start > 10) {
        return {
          type: 'bot',
          message: 'Слишком длинный фрагмент. Выберите конкретное слово.',
        };
      }

      const fragment = track.text.slice(cmd.start, cmd.end);
      const flagged = matchesPolicy(fragment, req.sessionId);
      const count = await addCensorRequest(trackId, {
        start: cmd.start,
        end: cmd.end,
        fragment,
        sessionId: req.sessionId,
      });
      return {
        type: 'bot',
        message: flagged
          ? `Фрагмент «${fragment}» распознан как нарушающий правила и отправлен на приоритетную цензуру. Всего запросов на этот трек: ${count}.`
          : `Запрос на цензуру «${fragment}» принят. Всего запросов на этот трек: ${count}.`,
      };
    }

    case 'report': {
      const track = await getTrack(trackId);
      if (!track) return { type: 'bot', message: 'Трек не найден.' };

      const count = await addReport(trackId, {
        reason: cmd.reason,
        sessionId: req.sessionId,
      });
      return {
        type: 'bot',
        message: `Жалоба #${count} на трек «${track.title}» принята: «${cmd.reason}». Модераторы рассмотрят её.`,
      };
    }

    case 'status': {
      const track = await getTrack(cmd.trackId);
      if (!track) return { type: 'bot', message: `Трек #${cmd.trackId} не найден.` };

      const censors = await getCensorCount(cmd.trackId);
      const reports = await getReportCount(cmd.trackId);

      let status = 'одобрен';
      if (reports >= 3) status = 'на рассмотрении модераторами';
      else if (censors >= 5) status = 'частично зацензурен';
      else if (censors > 0) status = 'есть запросы на цензуру';

      return {
        type: 'bot',
        message: `Трек #${cmd.trackId} «${track.title}» — статус: ${status}. Запросов на цензуру: ${censors}, жалоб: ${reports}.`,
      };
    }

    case 'original': {
      const original = await getOriginalText(cmd.trackId);
      if (!original) return { type: 'bot', message: `Трек #${cmd.trackId} не найден.` };

      return { type: 'bot', command: '/original', message: original };
    }

    default:
      return null;
  }
}
