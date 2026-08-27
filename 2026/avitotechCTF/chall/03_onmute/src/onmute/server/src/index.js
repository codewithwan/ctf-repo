import express from 'express';
import cookieParser from 'cookie-parser';
import path from 'path';
import { fileURLToPath } from 'url';
import { sessionMiddleware } from './middleware/session.js';
import apiRouter from './routes/index.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const app = express();
const PORT = parseInt(process.env.PORT || '3000', 10);

app.use(express.json());
app.use(cookieParser());
app.use(sessionMiddleware);

app.use('/api', apiRouter);

const clientDist = process.env.CLIENT_DIST || path.resolve(__dirname, '../../client/dist');
app.use(express.static(clientDist));
app.get('*', (req, res) => {
  res.sendFile(path.join(clientDist, 'index.html'));
});

app.listen(PORT, () => {
  console.log(`[onmute] listening on :${PORT}`);
});
