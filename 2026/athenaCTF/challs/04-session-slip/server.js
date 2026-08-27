const crypto = require('crypto');
const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();

app.use(express.static(__dirname));

const SESSION_KEY = 'orchid';
const sessionFixtures = require('./sessions.json');
const NOTES_DIR = path.join(__dirname, 'notes');

function sign(payload) {
  return crypto.createHmac('sha256', SESSION_KEY).update(payload).digest('hex');
}

function parseSession(rawToken) {
  if (!rawToken) {
    return { role: 'guest' };
  }

  if (rawToken.startsWith('dbg.')) {
    const body = Buffer.from(rawToken.slice(4), 'base64').toString('utf8');
    return JSON.parse(body);
  }

  const [payload, digest] = rawToken.split('.');
  if (!payload || !digest || sign(payload) !== digest) {
    return { role: 'guest' };
  }

  return JSON.parse(Buffer.from(payload, 'base64').toString('utf8'));
}

app.get('/', (req, res) => {
  const session = parseSession(req.headers['x-session']);
  res.json({
    banner: 'session gateway',
    user: session.user || 'anonymous',
    role: session.role || 'guest'
  });
});

app.get('/admin', (req, res) => {
  const session = parseSession(req.headers['x-session']);
  if (session.role !== 'admin') {
    return res.status(403).json({ error: 'forbidden' });
  }

  res.json({
    message: 'welcome back',
    note: sessionFixtures.admin_note
  });
});

app.get('/export', (req, res) => {
  const session = parseSession(req.headers['x-session']);
  if (session.role !== 'admin') {
    return res.status(403).json({ error: 'forbidden' });
  }

  const name = req.query.file || 'admin.txt';
  const target = path.join(NOTES_DIR, name);

  fs.readFile(target, 'utf8', (err, data) => {
    if (err) {
      return res.status(404).json({ error: 'not found' });
    }

    res.json({ file: name, content: data });
  });
});

app.listen(1337);
