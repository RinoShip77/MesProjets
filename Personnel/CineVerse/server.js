import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = process.env.PORT || 3000;

const cache = new Map();
const TTL_MS = 60 * 1000;
const API_BASE = 'https://imdb.iamidiotareyoutoo.com';

app.use(express.static(path.join(__dirname, 'public')));

function setCache(key, value) {
  cache.set(key, { value, expires: Date.now() + TTL_MS });
}
function getCache(key) {
  const entry = cache.get(key);
  if (!entry) return null;
  if (Date.now() > entry.expires) {
    cache.delete(key);
    return null;
  }
  return entry.value;
}

app.get('/api/search', async (req, res) => {
  try {
    const q = (req.query.q || '').trim();
    if (!q) return res.status(400).json({ ok: false, error: 'Missing query' });

    const cacheKey = `search:${q.toLowerCase()}`;
    const cached = getCache(cacheKey);
    if (cached) return res.json(cached);

    const upstream = await fetch(`${API_BASE}/search?q=${encodeURIComponent(q)}`);
    if (!upstream.ok) return res.status(upstream.status).json({ ok: false });

    const data = await upstream.json();
    setCache(cacheKey, data);
    res.json(data);
  } catch {
    res.status(500).json({ ok: false, error: 'Server error' });
  }
});

app.get('*', (_req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`CineVerse running at http://localhost:${PORT}`);
});
