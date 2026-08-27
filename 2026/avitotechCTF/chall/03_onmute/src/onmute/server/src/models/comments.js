import redis from '../db/redis.js';

const COMMENTS_TTL = 60 * 60 * 24;

function commentKey(sessionId, trackId) {
  return `comments:${sessionId}:${trackId}`;
}

export async function addComment(sessionId, trackId, comment) {
  const key = commentKey(sessionId, trackId);
  const entry = JSON.stringify({ ...comment, timestamp: Date.now() });
  await redis.rpush(key, entry);
  await redis.expire(key, COMMENTS_TTL);
}

export async function getComments(sessionId, trackId) {
  const raw = await redis.lrange(commentKey(sessionId, trackId), 0, -1);
  return raw.map((r) => JSON.parse(r));
}
