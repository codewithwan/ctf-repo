import { Router } from 'express';
import redis from '../db/redis.js';
import tracksRouter from './tracks.js';
import commentsRouter from './comments.js';

const router = Router();

router.get('/health', async (req, res) => {
  try {
    await redis.ping();
    res.json({ status: 'up', checks: { app: 'up', redis: 'up' } });
  } catch {
    res.status(503).json({ status: 'down', checks: { app: 'up', redis: 'down' } });
  }
});

router.use('/tracks', tracksRouter);
router.use('/tracks', commentsRouter);

export default router;
