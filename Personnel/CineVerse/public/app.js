// ===============================
// CineVerse – Complete App JS
// ===============================

// Theme segmented control
const themeButtons = document.querySelectorAll('.theme-toggle button');
const mql = window.matchMedia('(prefers-color-scheme: dark)');

function applyTheme(theme) {
  // theme can be: 'system', 'light', 'dark', 'neon'
  document.documentElement.setAttribute('data-theme', theme);
  themeButtons.forEach(btn => btn.classList.toggle('active', btn.dataset.theme === theme));
}

function storeTheme(theme) {
  localStorage.setItem('cineverse:theme', theme);
}

function loadTheme() {
  const stored = localStorage.getItem('cineverse:theme') || 'system';
  applyTheme(stored);
}

themeButtons.forEach(btn => {
  btn.addEventListener('click', () => {
    const t = btn.dataset.theme;
    storeTheme(t);
    applyTheme(t);
  });
});

// Update if system theme changes and current selection is 'system'
mql.addEventListener('change', () => {
  if ((localStorage.getItem('cineverse:theme') || 'system') === 'system') {
    applyTheme('system');
  }
});

// DOM elements
const form = document.getElementById('search-form');
const input = document.getElementById('search-input');
const resultsEl = document.getElementById('results');
const toastEl = document.getElementById('toast');
const hero = document.getElementById('hero');
const yearEl = document.getElementById('year');
if (yearEl) yearEl.textContent = new Date().getFullYear();

// Toasts
function toast(msg, timeout = 2400) {
  toastEl.textContent = msg;
  toastEl.classList.add('show');
  const t = setTimeout(() => {
    toastEl.classList.remove('show');
    clearTimeout(t);
  }, timeout);
}

// Utilities
function escapeHtml(str) {
  return String(str ?? '').replace(/[&<>"']/g, s => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;'
  }[s]));
}
function escapeAttr(str) {
  return escapeHtml(str).replace(/"/g, '&quot;');
}
function placeholderSvg() {
  const fg = encodeURIComponent('#999');
  const bg = encodeURIComponent('#222');
  const txt = encodeURIComponent('No Image');
  return `<svg xmlns='http://www.w3.org/2000/svg' width='600' height='900'>
    <rect width='100%' height='100%' fill='${bg}'/>
    <text x='50%' y='50%' dy='.3em' text-anchor='middle' fill='${fg}' font-family='sans-serif' font-size='40'>${txt}</text>
  </svg>`;
}
function setBusy(isBusy) {
  resultsEl?.setAttribute('aria-busy', isBusy ? 'true' : 'false');
}

// Animated placeholder suggestions
const examples = [
  'Search Spiderman…',
  'Search Inception…',
  'Search Barbie…',
  'Search The Godfather…',
  'Search Dune…',
  'Search Oppenheimer…'
];
let exampleIdx = 0;
let exampleTimer = null;

function startPlaceholderRotation() {
  stopPlaceholderRotation();
  if (!input) return;
  if (document.activeElement === input) return; // don't change while typing
  input.setAttribute('placeholder', examples[exampleIdx % examples.length]);
  exampleTimer = setInterval(() => {
    if (document.activeElement === input || input.value.trim()) return;
    exampleIdx = (exampleIdx + 1) % examples.length;
    input.setAttribute('placeholder', examples[exampleIdx]);
  }, 2500);
}
function stopPlaceholderRotation() {
  if (exampleTimer) {
    clearInterval(exampleTimer);
    exampleTimer = null;
  }
}

input.addEventListener('focus', stopPlaceholderRotation);
input.addEventListener('blur', startPlaceholderRotation);

// Skeleton grid
function skeleton(count = 8) {
  resultsEl.innerHTML = '';
  const frag = document.createDocumentFragment();
  for (let i = 0; i < count; i++) {
    const s = document.createElement('div');
    s.className = 'skel';
    s.innerHTML = `
      <div class="ph poster"></div>
      <div class="ph line w80"></div>
      <div class="ph line w60"></div>
      <div class="ph line w40"></div>
    `;
    frag.appendChild(s);
  }
  resultsEl.appendChild(frag);
}

// Rendering
function render(items = []) {
  resultsEl.innerHTML = '';
  if (!items.length) {
    resultsEl.innerHTML = `<p style="color:var(--text-2); text-align:center; grid-column:1/-1; margin:20px 0;">No results. Try another search.</p>`;
    return;
  }

  const frag = document.createDocumentFragment();

  for (const it of items) {
    const title = it['#TITLE'] ?? 'Untitled';
    const year = it['#YEAR'] ?? '';
    const actors = it['#ACTORS'] ?? '';
    const poster = it['#IMG_POSTER'] || '';
    const imdbUrl = it['#IMDB_URL'] || '#';

    const card = document.createElement('article');
    card.className = 'card';
    card.innerHTML = `
      <div class="poster-wrap">
        <img class="poster" alt="${escapeHtml(title)} poster" loading="lazy" src="${escapeAttr(poster)}" />
        ${year ? `<div class="badge-year">${escapeHtml(year)}</div>` : ''}
      </div>
      <div class="card-body">
        <h3 class="card-title">${escapeHtml(title)}</h3>
        ${actors ? `<div class="card-meta">Starring: ${escapeHtml(actors)}</div>` : ''}
        <div class="card-actions">
          <a class="button" href="${escapeAttr(imdbUrl)}" target="_blank" rel="noopener noreferrer">Open on IMDb</a>
        </div>
      </div>
    `;

    const img = card.querySelector('.poster');
    img.addEventListener('load', () => img.classList.add('loaded'));
    img.addEventListener('error', () => {
      img.src = `data:image/svg+xml,${placeholderSvg()}`;
      img.style.objectFit = 'contain';
      img.style.padding = '12px';
      img.classList.add('loaded');
    });

    frag.appendChild(card);
  }

  resultsEl.appendChild(frag);
}

// Network
async function search(q) {
  if (!q) return;

  setBusy(true);
  skeleton(10);

  try {
    const res = await fetch(`/api/search?q=${encodeURIComponent(q)}`);
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    const data = await res.json();
    const items = Array.isArray(data?.description) ? data.description : [];
    render(items);
    if (!items.length) toast('No results found');
  } catch (err) {
    console.error(err);
    toast('Something went wrong. Please try again.');
    resultsEl.innerHTML = `<p style="color:var(--text-2); text-align:center; grid-column:1/-1; margin:20px 0;">Error loading results.</p>`;
  } finally {
    setBusy(false);
  }
}

// Events
form.addEventListener('submit', e => {
  e.preventDefault();
  const q = input.value.trim();
  if (!q) return toast('Please type something to search 🎯');
  sessionStorage.setItem('cineverse:lastq', q);
  search(q);
});

// Init
loadTheme();
startPlaceholderRotation();

// Initial search behavior: restore last query or show hero
const lastQ = sessionStorage.getItem('cineverse:lastq');
if (lastQ) {
  input.value = lastQ;
  search(lastQ);
} else {
  // keep hero visible; prefill a friendly suggestion
  input.value = '';
}
