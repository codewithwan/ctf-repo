import { v4 as uuidv4 } from 'uuid';
import redis from '../db/redis.js';

const COOKIE_NAME = 'onmute_sid';
const SESSION_TTL = 60 * 60 * 24;

export function sessionMiddleware(req, res, next) {
  let sid = req.cookies?.[COOKIE_NAME];

  if (!sid) {
    sid = uuidv4();
    res.cookie(COOKIE_NAME, sid, {
      httpOnly: true,
      sameSite: 'lax',
      maxAge: SESSION_TTL * 1000,
    });
  }

  req.sessionId = sid;

  redis
    .set(`session:${sid}`, JSON.stringify({ created: Date.now() }), 'EX', SESSION_TTL)
    .then(() => next())
    .catch(next);
}
