import { Router } from 'express';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { listTracks, getTrack } from '../models/tracks.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const MEDIA_DIR = path.resolve(__dirname, '../../media');

const MIME_TYPES = {
  '.mp3': 'audio/mpeg',
  '.ogg': 'audio/ogg',
  '.wav': 'audio/wav',
};

const router = Router();

router.get('/', async (req, res) => {
  try {
    const tracks = await listTracks();
    res.json({ ok: true, tracks });
  } catch (err) {
    res.status(500).json({ ok: false, error: err.message });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const track = await getTrack(parseInt(req.params.id, 10));
    if (!track) return res.status(404).json({ ok: false, error: 'Трек не найден' });
    res.json({ ok: true, track });
  } catch (err) {
    res.status(500).json({ ok: false, error: err.message });
  }
});

router.get('/:id/stream', (req, res) => {
  const trackId = req.params.id;

  let filePath = null;
  let mimeType = null;
  for (const [ext, mime] of Object.entries(MIME_TYPES)) {
    const candidate = path.join(MEDIA_DIR, `${trackId}${ext}`);
    if (fs.existsSync(candidate)) {
      filePath = candidate;
      mimeType = mime;
      break;
    }
  }

  if (!filePath) {
    return res.status(404).json({ ok: false, error: 'Аудио не найдено' });
  }

  const { size } = fs.statSync(filePath);
  const range = req.headers.range;

  if (range) {
    const parts = range.replace(/bytes=/, '').split('-');
    const start = parseInt(parts[0], 10);
    const end = parts[1] ? parseInt(parts[1], 10) : size - 1;

    res.writeHead(206, {
      'Content-Range': `bytes ${start}-${end}/${size}`,
      'Accept-Ranges': 'bytes',
      'Content-Length': end - start + 1,
      'Content-Type': mimeType,
    });

    fs.createReadStream(filePath, { start, end }).pipe(res);
  } else {
    res.writeHead(200, {
      'Content-Length': size,
      'Content-Type': mimeType,
      'Accept-Ranges': 'bytes',
    });

    fs.createReadStream(filePath).pipe(res);
  }
});

export default router;
