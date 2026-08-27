import Redis from 'ioredis';

const redis = new Redis({
  host: process.env.REDIS_HOST || 'localhost',
  port: parseInt(process.env.REDIS_PORT || '6379', 10),
  retryStrategy(times) {
    return Math.min(times * 200, 5000);
  },
});

redis.on('error', (err) => console.error('[redis]', err.message));
redis.on('connect', () => console.log('[redis] connected'));

export default redis;
