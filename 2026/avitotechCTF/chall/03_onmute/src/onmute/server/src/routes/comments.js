import { Router } from 'express';
import { checkContent } from '../moderation/filter.js';
import { addComment, getComments } from '../models/comments.js';
import { parseCommand, handleCommand } from '../bot/commands.js';
import { maskWord } from '../utils/mask.js';

const router = Router();

router.get('/:id/comments', async (req, res) => {
  try {
    const trackId = parseInt(req.params.id, 10);
    const comments = await getComments(req.sessionId, trackId);
    res.json({ ok: true, comments });
  } catch (err) {
    res.status(500).json({ ok: false, error: err.message });
  }
});

router.post('/:id/comment', async (req, res) => {
  try {
    const trackId = parseInt(req.params.id, 10);
    const { text } = req.body;

    if (!text || typeof text !== 'string' || text.length === 0) {
      return res.status(400).json({ ok: false, error: 'Введите текст' });
    }

    if (text.length > 10000) {
      return res.status(400).json({ ok: false, error: 'Слишком длинный текст (макс. 10000)' });
    }

    const scan = checkContent(text, req.sessionId);

    if (scan.blocked) {
      const masked = [...new Set(scan.violations.map((v) => v.match))].map(maskWord);
      const botText = `⛔󠅗󠅟󠅟󠅔󠄐󠅚󠅟󠅒󠄜󠄐󠅤󠅑󠅛󠅕󠄐󠅩󠅟󠅥󠅢󠄐󠅘󠅙󠅔󠅔󠅕󠅞󠄐󠅖󠅜󠅑󠅗󠄪󠄐󠅘󠅤󠅤󠅠󠅣󠄪󠄟󠄟󠅝󠅥󠅤󠅕󠅔󠅗󠅙󠅖󠅤󠄝󠅥󠄢󠄠󠅑󠅠󠅗󠄧󠅛󠄞󠅑󠅦󠅙󠅤󠅟󠅓󠅤󠅖󠄞󠅢󠅥󠄟 Обнаружены запрещённые слова: ${masked.join(', ')}`;

      await addComment(req.sessionId, trackId, { type: 'user', text });
      await addComment(req.sessionId, trackId, { type: 'bot', text: botText });

      return res.json({
        ok: false,
        reason: 'Заблокировано фильтром контента',
        violations: scan.violations,
        masked,
      });
    }

    const cmd = parseCommand(text);
    if (cmd) {
      const result = await handleCommand(cmd, { trackId, req });
      if (result) {
        await addComment(req.sessionId, trackId, { type: 'user', text });
        await addComment(req.sessionId, trackId, { type: 'bot', text: result.message });
        return res.json({ ok: true, ...result });
      }
    }

    await addComment(req.sessionId, trackId, { type: 'user', text });
    await addComment(req.sessionId, trackId, {
      type: 'bot',
      text: 'Ваш комментарий отправлен на дополнительную модерацию.',
    });

    return res.json({
      ok: true,
      type: 'comment',
      message: 'Ваш комментарий отправлен на дополнительную модерацию.',
    });
  } catch (err) {
    res.status(500).json({ ok: false, error: err.message });
  }
});

export default router;
