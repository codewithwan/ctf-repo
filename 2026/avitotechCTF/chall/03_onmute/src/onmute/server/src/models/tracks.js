import redis from '../db/redis.js';

const TRACKS_KEY = 'tracks:meta';
const CENSORS_PREFIX = 'track:censors';
const REPORTS_PREFIX = 'track:reports';
const HISTORY_LIMIT = 100;

export async function listTracks() {
  const raw = await redis.get(TRACKS_KEY);
  if (!raw) return [];

  return JSON.parse(raw).map(({ id, title, artist, censored, hasAudio }) => ({
    id, title, artist, text: censored, hasAudio: !!hasAudio,
  }));
}

export async function getTrack(id) {
  const raw = await redis.get(TRACKS_KEY);
  if (!raw) return null;

  const track = JSON.parse(raw).find((t) => t.id === id);
  if (!track) return null;

  return {
    id: track.id,
    title: track.title,
    artist: track.artist,
    text: track.censored,
    hasAudio: !!track.hasAudio,
  };
}

export async function getOriginalText(id) {
  const raw = await redis.get(TRACKS_KEY);
  if (!raw) return null;

  const track = JSON.parse(raw).find((t) => t.id === id);
  return track?.original ?? null;
}

export async function addCensorRequest(trackId, { start, end, fragment, sessionId }) {
  const key = `${CENSORS_PREFIX}:${trackId}`;
  const entry = JSON.stringify({ start, end, fragment, sessionId, timestamp: Date.now() });
  await redis.lpush(key, entry);
  await redis.ltrim(key, 0, HISTORY_LIMIT - 1);
  return redis.llen(key);
}

export async function getCensorCount(trackId) {
  return redis.llen(`${CENSORS_PREFIX}:${trackId}`);
}

export async function getCensorHistory(trackId, limit = 10) {
  const raw = await redis.lrange(`${CENSORS_PREFIX}:${trackId}`, 0, limit - 1);
  return raw.map((r) => JSON.parse(r));
}

export async function addReport(trackId, { reason, sessionId }) {
  const key = `${REPORTS_PREFIX}:${trackId}`;
  const entry = JSON.stringify({ reason, sessionId, timestamp: Date.now() });
  await redis.lpush(key, entry);
  await redis.ltrim(key, 0, HISTORY_LIMIT - 1);
  return redis.llen(key);
}

export async function getReportCount(trackId) {
  return redis.llen(`${REPORTS_PREFIX}:${trackId}`);
}

export async function getReportHistory(trackId, limit = 10) {
  const raw = await redis.lrange(`${REPORTS_PREFIX}:${trackId}`, 0, limit - 1);
  return raw.map((r) => JSON.parse(r));
}
