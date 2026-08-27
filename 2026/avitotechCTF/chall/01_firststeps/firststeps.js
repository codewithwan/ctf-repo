function cellKey(c, r, cols){ return r * cols + c; }

function neighborsOf(c, r, cols, rows){
  var deltas = (r % 2 === 1)
    ? [[1,0],[-1,0],[0,-1],[1,-1],[0,1],[1,1]]
    : [[1,0],[-1,0],[-1,-1],[0,-1],[-1,1],[0,1]];
  var res = [];
  for (var i = 0; i < deltas.length; i++){
    var nc = c + deltas[i][0], nr = r + deltas[i][1];
    if (nc >= 0 && nc < cols && nr >= 0 && nr < rows) res.push([nc, nr]);
  }
  return res;
}

function shuffleArr(a, rnd){
  rnd = rnd || Math.random;
  for (var i = a.length - 1; i > 0; i--){
    var j = Math.floor(rnd() * (i + 1));
    var t = a[i]; a[i] = a[j]; a[j] = t;
  }
  return a;
}

function isReachable(cols, rows, traps, start, goal){
  var sk = cellKey(start[0], start[1], cols);
  var gk = cellKey(goal[0], goal[1], cols);
  if (traps.has(sk) || traps.has(gk)) return false;
  var seen = new Set([sk]);
  var stack = [start];
  while (stack.length){
    var cur = stack.pop();
    if (cur[0] === goal[0] && cur[1] === goal[1]) return true;
    var nb = neighborsOf(cur[0], cur[1], cols, rows);
    for (var i = 0; i < nb.length; i++){
      var k = cellKey(nb[i][0], nb[i][1], cols);
      if (seen.has(k) || traps.has(k)) continue;
      seen.add(k);
      stack.push(nb[i]);
    }
  }
  return false;
}

function generateGame(cols, rows, density, rnd){
  rnd = rnd || Math.random;
  var start = [0, 0];
  var goal = [cols - 1, rows - 1];
  var forbidden = new Set([cellKey(0, 0, cols), cellKey(goal[0], goal[1], cols)]);
  var cells = [];
  for (var r = 0; r < rows; r++)
    for (var c = 0; c < cols; c++){
      var k = cellKey(c, r, cols);
      if (!forbidden.has(k)) cells.push(k);
    }
  shuffleArr(cells, rnd);
  var traps = new Set();
  var want = Math.round(cells.length * density);
  for (var i = 0; i < want; i++) traps.add(cells[i]);
  if (!isReachable(cols, rows, traps, start, goal)){
    var list = shuffleArr(Array.from(traps), rnd);
    for (var j = 0; j < list.length; j++){
      traps.delete(list[j]);
      if (isReachable(cols, rows, traps, start, goal)) break;
    }
  }
  return { start: start, goal: goal, traps: traps };
}

var BADGER_RATIO = 0.488;
var $ = function(s){ return document.querySelector(s); };
var boardSvg = $('#board');
var defaultOverlaySrc = $('#overlayImg').src;
var state = null;
var timers = [];

function clearTimers(){ timers.forEach(clearTimeout); timers = []; }
function later(fn, ms){ timers.push(setTimeout(fn, ms)); }
function clamp(v, lo, hi){ return Math.min(hi, Math.max(lo, v)); }

function layoutFor(cols, rows){
  var S = 26, GAP = 2.6, PAD = 14;
  var W = Math.sqrt(3) * S, H = 2 * S;
  return {
    S: S, GAP: GAP, PAD: PAD, W: W, H: H,
    width:  PAD * 2 + W * cols + W / 2,
    height: PAD * 2 + H + 0.75 * H * (rows - 1)
  };
}
function centerOf(c, r, L){
  return [
    L.PAD + L.W * (c + 0.5 * (r % 2)) + L.W / 2,
    L.PAD + L.H / 2 + 0.75 * L.H * r
  ];
}
function hexPoints(cx, cy, rad){
  var pts = [];
  for (var i = 0; i < 6; i++){
    var a = Math.PI / 180 * (60 * i - 90);
    pts.push((cx + rad * Math.cos(a)).toFixed(2) + ',' + (cy + rad * Math.sin(a)).toFixed(2));
  }
  return pts.join(' ');
}
function flagSvg(cx, cy){
  return '<g class="deco flag" transform="translate(' + cx.toFixed(1) + ',' + cy.toFixed(1) + ')">' +
    '<line x1="-6" y1="15" x2="-6" y2="-15" stroke="#7c5222" stroke-width="3.4" stroke-linecap="round"/>' +
    '<path class="pennant" d="M -4.3 -15 L 17 -8.6 L -4.3 -2.2 Z" fill="#7b5cfa"/></g>';
}

function renderBoard(){
  var cols = state.cols, rows = state.rows, L = layoutFor(cols, rows);
  state.L = L;
  boardSvg.setAttribute('viewBox', '0 0 ' + L.width.toFixed(1) + ' ' + L.height.toFixed(1));
  boardSvg.setAttribute('class', '');
  var rad = L.S - L.GAP - 3.5;
  var cellsHtml = '', decoHtml = '';
  for (var r = 0; r < rows; r++){
    for (var c = 0; c < cols; c++){
      var p = centerOf(c, r, L), cx = p[0], cy = p[1];
      var isGoal = (c === state.goal[0] && r === state.goal[1]);
      cellsHtml += '<polygon class="cell' + (isGoal ? ' goal' : '') + '" data-c="' + c + '" data-r="' + r + '" points="' + hexPoints(cx, cy, rad) + '"/>';
      if (state.traps.has(cellKey(c, r, cols))){
        var len = (L.S * 0.46).toFixed(1), sw = (L.S * 0.2).toFixed(1);
        decoHtml += '<g class="star deco" transform="translate(' + cx.toFixed(1) + ',' + cy.toFixed(1) + ')">' +
          '<line y1="-' + len + '" y2="' + len + '" stroke-width="' + sw + '"/>' +
          '<line y1="-' + len + '" y2="' + len + '" stroke-width="' + sw + '" transform="rotate(60)"/>' +
          '<line y1="-' + len + '" y2="' + len + '" stroke-width="' + sw + '" transform="rotate(120)"/></g>';
      }
      if (isGoal) decoHtml += flagSvg(cx, cy);
    }
  }
  var bh = L.H * 1.18, bw = bh * BADGER_RATIO;
  boardSvg.innerHTML = cellsHtml + decoHtml +
    '<g id="badger" class="deco"><image href="assets/badger-board.webp" width="' + bw.toFixed(1) + '" height="' + bh.toFixed(1) + '"/></g>';
  fitBoard();
  updateBadger(true);
}

function updateBadger(instant){
  var g = document.getElementById('badger');
  var img = g.querySelector('image');
  var bw = +img.getAttribute('width'), bh = +img.getAttribute('height');
  var p = centerOf(state.badger[0], state.badger[1], state.L);
  var x = p[0] - bw / 2, y = p[1] + state.L.S * 0.72 - bh;
  if (instant) g.style.transition = 'none';
  g.style.transform = 'translate(' + x + 'px,' + y + 'px)';
  if (instant){ g.getBoundingClientRect(); g.style.transition = ''; }
  if ($('#main').classList.contains('scrolling')){
    try { g.scrollIntoView({ block: 'center', inline: 'center', behavior: instant ? 'auto' : 'smooth' }); } catch (e) {}
  }
}

var FIXED_ROWS = 10;
var FIXED_COLS = 15;
var LEVEL_ORDER = ['easy', 'medium', 'hard'];
var LEVELS = {
  easy:   { name: 'Лёгкий', density: 0.19 },
  medium: { name: 'Средний', density: 0.36 },
  hard:   { name: 'Сложный', maze: true }
};
var FLAG_PART_NAMES = {
  easy: 'Первая часть флага',
  medium: 'Вторая часть флага',
  hard: 'Третья часть флага'
};
var FIXED_HOLE_COORDS = [[2,1],[7,1],[11,1],[4,2],[9,3],[13,3],[1,4],[6,5],[11,5],[3,7],[8,8],[12,8]];
var LEVEL_REWARD_LENGTHS = [10, 9, 9];
var LEVEL_REWARD_DATA = [99,179,125,189,59,220,227,52,178,148,156,34,201,91,248,251,14,73,54,212,178,230,102,64,45,182,145,14,3,160];
var progress = loadProgress();

function levelReward(level){
  var index = LEVEL_ORDER.indexOf(level);
  if (index < 0) return '';

  var stream = (0x6d2b79f5 ^ Math.imul(index + 1, 0x9e3779b1) ^ (FIXED_COLS << 24) ^ (FIXED_ROWS << 16)) >>> 0;
  FIXED_HOLE_COORDS.forEach(function(pos, holeIndex){
    stream ^= Math.imul(cellKey(pos[0], pos[1], FIXED_COLS) + holeIndex + 1, 0x045d9f3b);
    stream = ((stream << 11) | (stream >>> 21)) >>> 0;
  });

  var reward = '';
  var lane = (index * 2 + 1) % LEVEL_ORDER.length;
  for (var i = 0; i < LEVEL_REWARD_LENGTHS[index]; i++){
    stream ^= stream << 13;
    stream ^= stream >>> 17;
    stream ^= stream << 5;
    stream >>>= 0;
    reward += String.fromCharCode(LEVEL_REWARD_DATA[i * LEVEL_ORDER.length + lane] ^ (stream & 255));
  }
  return reward;
}

function loadProgress(){
  try {
    var saved = JSON.parse(localStorage.getItem('medohunter-flag-v2') || '{}');
    return { easy: !!saved.easy, medium: !!saved.medium, hard: !!saved.hard };
  } catch (e) {
    return { easy: false, medium: false, hard: false };
  }
}

function saveProgress(){
  try { localStorage.setItem('medohunter-flag-v2', JSON.stringify(progress)); } catch (e) {}
}

function resetProgress(){
  progress = { easy: false, medium: false, hard: false };
  try { localStorage.removeItem('medohunter-flag-v2'); } catch (e) {}
  $('#newGameBtn').textContent = 'Новая игра';
  delete $('#newGameBtn').dataset.resetProgress;
  updateFlagUI();
  $('#diffInput').value = 'easy';
}

function flagText(){
  var assembled = '';
  for (var i = 0; i < LEVEL_ORDER.length; i++){
    var level = LEVEL_ORDER[i];
    if (!progress[level]) break;
    assembled += levelReward(level);
  }
  return 'avito{' + assembled + (progress.hard ? '' : '...') + '}';
}

function updateFlagUI(){
  var done = LEVEL_ORDER.filter(function(level){ return progress[level]; }).length;
  $('#flagValue').textContent = flagText();
  $('#flagValue').title = 'The early bee gets the honey';
  document.querySelectorAll('.flag-part').forEach(function(part){
    part.classList.toggle('done', !!progress[part.dataset.level]);
  });
  $('.flag-progress').setAttribute('aria-label', 'Пройдено уровней: ' + done + ' из 3');
  var select = $('#diffInput');
  select.querySelector('option[value="medium"]').disabled = !progress.easy;
  select.querySelector('option[value="hard"]').disabled = !progress.medium;
  LEVEL_ORDER.forEach(function(level){
    var option = select.querySelector('option[value="' + level + '"]');
    option.textContent = LEVELS[level].name + (progress[level] ? ' ✓' : '');
  });
  $('#copyFlagBtn').disabled = !progress.hard;
}

function completeLevel(level){
  var index = LEVEL_ORDER.indexOf(level);
  for (var i = 0; i <= index; i++){
    if (i < index && !progress[LEVEL_ORDER[i]]) return false;
  }
  var wasNew = !progress[level];
  progress[level] = true;
  saveProgress();
  updateFlagUI();
  return wasNew;
}

function nextUnsolvedLevel(level){
  var start = LEVEL_ORDER.indexOf(level) + 1;
  for (var i = start; i < LEVEL_ORDER.length; i++){
    if (!progress[LEVEL_ORDER[i]]) return LEVEL_ORDER[i];
  }
  return null;
}

var HARD_MAZE_TRIALS = 384;

function coordsForKey(key, cols){
  return [key % cols, Math.floor(key / cols)];
}

function shortestRouteWithin(cols, rows, allowed, startKey, goalKey){
  var queue = [startKey];
  var seen = new Set([startKey]);
  var previous = new Map();
  for (var qi = 0; qi < queue.length && !seen.has(goalKey); qi++){
    var currentKey = queue[qi];
    var current = coordsForKey(currentKey, cols);
    var nextCells = neighborsOf(current[0], current[1], cols, rows);
    for (var n = 0; n < nextCells.length; n++){
      var nextKey = cellKey(nextCells[n][0], nextCells[n][1], cols);
      if (!allowed.has(nextKey) || seen.has(nextKey)) continue;
      seen.add(nextKey);
      previous.set(nextKey, currentKey);
      queue.push(nextKey);
    }
  }
  if (!seen.has(goalKey)) return null;
  var route = [];
  for (var key = goalKey; key !== undefined; key = previous.get(key)){
    route.push(key);
    if (key === startKey) break;
  }
  route.reverse();
  return route;
}

function randomDepthFirstRoute(cols, rows, holes, startKey, goalKey, rnd){
  var seen = new Set([startKey]);
  var previous = new Map();
  var start = coordsForKey(startKey, cols);
  var startOptions = neighborsOf(start[0], start[1], cols, rows).map(function(pos){
    return cellKey(pos[0], pos[1], cols);
  });
  var stack = [{ key: startKey, options: shuffleArr(startOptions, rnd) }];

  while (stack.length && !seen.has(goalKey)){
    var frame = stack[stack.length - 1];
    if (!frame.options.length){
      stack.pop();
      continue;
    }
    var nextKey = frame.options.pop();
    if (holes.has(nextKey) || seen.has(nextKey)) continue;
    seen.add(nextKey);
    previous.set(nextKey, frame.key);
    var next = coordsForKey(nextKey, cols);
    var options = neighborsOf(next[0], next[1], cols, rows).map(function(pos){
      return cellKey(pos[0], pos[1], cols);
    });
    stack.push({ key: nextKey, options: shuffleArr(options, rnd) });
  }
  if (!seen.has(goalKey)) return null;

  var route = [];
  for (var key = goalKey; key !== undefined; key = previous.get(key)){
    route.push(key);
    if (key === startKey) break;
  }
  route.reverse();
  return route;
}

function routeTurnCount(route, cols, rows){
  var turns = 0, lastDirection = -1;
  for (var i = 1; i < route.length; i++){
    var from = coordsForKey(route[i - 1], cols);
    var to = coordsForKey(route[i], cols);
    var nextCells = neighborsOf(from[0], from[1], cols, rows);
    var direction = nextCells.findIndex(function(pos){ return pos[0] === to[0] && pos[1] === to[1]; });
    if (lastDirection !== -1 && direction !== lastDirection) turns++;
    lastDirection = direction;
  }
  return turns;
}

function generateHardSafeRoute(cols, rows, holes, startKey, goalKey, rnd){
  var openCells = new Set();
  for (var r = 0; r < rows; r++){
    for (var c = 0; c < cols; c++){
      var key = cellKey(c, r, cols);
      if (!holes.has(key)) openCells.add(key);
    }
  }
  var bestRoute = shortestRouteWithin(cols, rows, openCells, startKey, goalKey);
  var bestTurns = routeTurnCount(bestRoute, cols, rows);

  for (var attempt = 0; attempt < HARD_MAZE_TRIALS; attempt++){
    var dfsRoute = randomDepthFirstRoute(cols, rows, holes, startKey, goalKey, rnd);
    if (!dfsRoute) continue;
    var candidate = shortestRouteWithin(cols, rows, new Set(dfsRoute), startKey, goalKey);
    if (!candidate) continue;
    var turns = routeTurnCount(candidate, cols, rows);
    if (candidate.length > bestRoute.length || (candidate.length === bestRoute.length && turns > bestTurns)){
      bestRoute = candidate;
      bestTurns = turns;
    }
  }
  return bestRoute;
}

function generateGame(cols, rows, config, rnd){
  rnd = rnd || Math.random;
  if (typeof config === 'number') config = { density: config };
  var start = [0, 0];
  var goal = [cols - 1, rows - 1];
  var holes = new Set();
  FIXED_HOLE_COORDS.forEach(function(pos){ holes.add(cellKey(pos[0], pos[1], cols)); });

  var startKey = cellKey(start[0], start[1], cols);
  var goalKey = cellKey(goal[0], goal[1], cols);
  if (config.maze){
    var mazeRoute = generateHardSafeRoute(cols, rows, holes, startKey, goalKey, rnd);
    var mazeSafe = new Set(mazeRoute);
    var mazeTraps = new Set();
    for (var mr = 0; mr < rows; mr++){
      for (var mc = 0; mc < cols; mc++){
        var mazeKey = cellKey(mc, mr, cols);
        if (!holes.has(mazeKey) && !mazeSafe.has(mazeKey)) mazeTraps.add(mazeKey);
      }
    }
    return { start: start, goal: goal, traps: mazeTraps, holes: holes, routeLength: mazeRoute.length };
  }

  var queue = [start];
  var seen = new Set([startKey]);
  var previous = new Map();
  while (queue.length && !seen.has(goalKey)){
    var current = queue.shift();
    var currentKey = cellKey(current[0], current[1], cols);
    var nextCells = shuffleArr(neighborsOf(current[0], current[1], cols, rows), rnd);
    for (var n = 0; n < nextCells.length; n++){
      var next = nextCells[n];
      var nextKey = cellKey(next[0], next[1], cols);
      if (holes.has(nextKey) || seen.has(nextKey)) continue;
      seen.add(nextKey);
      previous.set(nextKey, currentKey);
      queue.push(next);
    }
  }
  var safeRoute = new Set();
  for (var routeKey = goalKey; routeKey !== undefined; routeKey = previous.get(routeKey)){
    safeRoute.add(routeKey);
    if (routeKey === startKey) break;
  }

  var forbidden = new Set(holes);
  safeRoute.forEach(function(k){ forbidden.add(k); });
  var cells = [];
  for (var r = 0; r < rows; r++){
    for (var c = 0; c < cols; c++){
      var k = cellKey(c, r, cols);
      if (!forbidden.has(k)) cells.push(k);
    }
  }
  shuffleArr(cells, rnd);
  var traps = new Set(cells.slice(0, Math.round(cells.length * config.density)));
  return { start: start, goal: goal, traps: traps, holes: holes };
}

function holeBeeSvg(cx, cy, index){
  var dx = (Math.random() * 12 - 6);
  var dy = (Math.random() * 9 - 3);
  var angle = (Math.random() * 44 - 22);
  var size = 17 + Math.random() * 9;
  var delay = Math.random() * 9;
  var duration = 5.6 + Math.random() * 5.2;
  return '<g transform="translate(' + (cx + dx).toFixed(1) + ',' + (cy + dy).toFixed(1) + ') rotate(' + angle.toFixed(1) + ')">' +
    '<text class="hole-peeker" x="0" y="1" text-anchor="middle" dominant-baseline="middle" font-size="' + size.toFixed(1) + '" style="animation-delay:-' + delay.toFixed(2) + 's;animation-duration:' + duration.toFixed(2) + 's">🐝</text>' +
    '</g>';
}

function badgerSvg(){
  return '<g id="badger" class="deco" aria-label="Медоед"><g class="badger-character">' +
    '<ellipse cx="0" cy="21" rx="12" ry="3.4" fill="rgba(0,0,0,.48)"/>' +
    '<image href="' + $('.logo').src + '" x="-15.5" y="-28.5" width="31" height="55.3" preserveAspectRatio="xMidYMid slice"/>' +
  '</g></g>';
}

function renderBoard(){
  var cols = state.cols, rows = state.rows, L = layoutFor(cols, rows);
  state.L = L;
  boardSvg.setAttribute('viewBox', '0 0 ' + L.width.toFixed(1) + ' ' + L.height.toFixed(1));
  boardSvg.setAttribute('class', '');
  var rad = L.S - L.GAP - 3.5;
  var cellsHtml = '', holesHtml = '', decoHtml = '';
  var beeCandidates = [];
  for (var bi = 0; bi < state.holes.size; bi++) beeCandidates.push(bi);
  shuffleArr(beeCandidates);
  var beeCount = Math.min(state.holes.size, 6 + Math.floor(Math.random() * 5));
  var beeSlots = new Set(beeCandidates.slice(0, beeCount));
  var holeIndex = 0;
  for (var r = 0; r < rows; r++){
    for (var c = 0; c < cols; c++){
      var p = centerOf(c, r, L), cx = p[0], cy = p[1];
      var key = cellKey(c, r, cols);
      var isGoal = (c === state.goal[0] && r === state.goal[1]);
      if (state.holes.has(key)){
        holesHtml += '<polygon class="hole" points="' + hexPoints(cx, cy, rad) + '"/>' +
          '<polygon class="hole-inner" points="' + hexPoints(cx, cy, rad * 0.72) + '"/>';
        if (beeSlots.has(holeIndex)) decoHtml += holeBeeSvg(cx, cy, holeIndex);
        holeIndex++;
        continue;
      }
      cellsHtml += '<polygon class="cell' + (isGoal ? ' goal' : '') + '" data-c="' + c + '" data-r="' + r + '" data-key="' + key + '" points="' + hexPoints(cx, cy, rad) + '"/>';
      if (state.traps.has(key)){
        var markBox = L.S * 1.55;
        decoHtml += '<foreignObject class="trap-host" data-key="' + key + '" x="' + (cx - markBox / 2).toFixed(1) + '" y="' + (cy - markBox / 2).toFixed(1) + '" width="' + markBox.toFixed(1) + '" height="' + markBox.toFixed(1) + '">' +
          '<div xmlns="http://www.w3.org/1999/xhtml" class="trap-mark" style="font-size:' + (L.S * 1.35).toFixed(1) + 'px">*</div></foreignObject>';
      }
      if (isGoal) decoHtml += flagSvg(cx, cy);
    }
  }
  boardSvg.innerHTML = cellsHtml + holesHtml + decoHtml + badgerSvg();
  fitBoard();
  updateBadger(true);
}

function updateBadger(instant){
  var g = document.getElementById('badger');
  if (!g) return;
  var p = centerOf(state.badger[0], state.badger[1], state.L);
  if (instant) g.style.transition = 'none';
  g.style.transform = 'translate(' + p[0].toFixed(1) + 'px,' + (p[1] - 1).toFixed(1) + 'px)';
  if (instant){ g.getBoundingClientRect(); g.style.transition = ''; }
  else {
    g.classList.remove('stepping');
    g.getBoundingClientRect();
    g.classList.add('stepping');
    setTimeout(function(){ if (g) g.classList.remove('stepping'); }, 300);
  }
  if ($('#main').classList.contains('scrolling')){
    try { g.scrollIntoView({ block: 'center', inline: 'center', behavior: instant ? 'auto' : 'smooth' }); } catch (e) {}
  }
}

function fitBoard(){
  if (!state || !state.L) return;
  var wrap = $('#main');
  var availW = Math.max(wrap.clientWidth - 28, 50);
  var availH = Math.max(wrap.clientHeight - 20, 50);
  var fit = Math.min(availW / state.L.width, availH / state.L.height);
  var minScale = 32 / state.L.W;
  if (fit < minScale){
    boardSvg.style.width = (state.L.width * minScale) + 'px';
    boardSvg.style.height = (state.L.height * minScale) + 'px';
    boardSvg.style.maxWidth = 'none';
    wrap.classList.add('scrolling');
  } else {
    boardSvg.style.width = '100%';
    boardSvg.style.height = '100%';
    boardSvg.style.maxWidth = '';
    wrap.classList.remove('scrolling');
  }
}
window.addEventListener('resize', fitBoard);

function setStatus(text, cls){
  var el = $('#statusText');
  if (!el) return;
  el.textContent = text;
  el.className = cls || '';
}
function markReachable(){
  boardSvg.querySelectorAll('.reach').forEach(function(p){ p.classList.remove('reach'); });
  if (!state || state.phase !== 'play') return;
  neighborsOf(state.badger[0], state.badger[1], state.cols, state.rows).forEach(function(n){
    var p = boardSvg.querySelector('polygon[data-c="' + n[0] + '"][data-r="' + n[1] + '"]');
    if (p){
      p.classList.add('reach');
      var trapHost = boardSvg.querySelector('.trap-host[data-key="' + p.dataset.key + '"]');
      if (trapHost) trapHost.classList.add('reach');
    }
  });
}

function startMemoPhase(){
  setStatus('');
  var cl = boardSvg.classList;
  later(function(){ cl.add('flash1'); }, 120);
  later(function(){ cl.remove('flash1'); cl.add('flash2'); }, 820);
  later(function(){ cl.remove('flash2'); cl.add('flash3'); }, 1520);
  later(function(){ cl.remove('flash3'); cl.add('merged'); }, 2220);
  later(function(){
    cl.add('gone', 'play');
    state.phase = 'play';
    setStatus('');
    markReachable();
  }, 2960);
}

function tryMove(c, r){
  if (!state || state.phase !== 'play') return;
  var b = state.badger;
  var ok = neighborsOf(b[0], b[1], state.cols, state.rows).some(function(n){ return n[0] === c && n[1] === r; });
  if (!ok) return;
  if (state.holes.has(cellKey(c, r, state.cols))) return;
  state.badger = [c, r];
  updateBadger();
  if (state.traps.has(cellKey(c, r, state.cols))) return lose(c, r);
  if (c === state.goal[0] && r === state.goal[1]) return win();
  markReachable();
}

function lose(c, r){
  state.phase = 'over';
  markReachable();
  boardSvg.classList.remove('play');
  boardSvg.classList.add('reveal');
  var p = boardSvg.querySelector('polygon[data-c="' + c + '"][data-r="' + r + '"]');
  if (p) p.classList.add('boom');
  setStatus('💥 Ой! Это была ловушка…', 'lose');
  $('#main').classList.add('shake');
  later(function(){ $('#main').classList.remove('shake'); }, 600);
  later(function(){ showOverlay(false); }, 1000);
}

function win(){
  state.phase = 'over';
  markReachable();
  boardSvg.classList.remove('play');
  state.newFlagPart = completeLevel(state.level);
  state.nextLevel = nextUnsolvedLevel(state.level);
  if (state.nextLevel) $('#diffInput').value = state.nextLevel;
  setStatus('Уровень пройден!', 'win');
  later(function(){ showOverlay(true); }, 650);
}

function showOverlay(won){
  var finalWin = won && state.level === 'hard';
  $('#overlayImg').src = finalWin ? $('#finalOverlayAsset').src : defaultOverlaySrc;
  $('#overlayImg').classList.toggle('final-art', finalWin);
  $('#overlayImg').style.display = won ? '' : 'none';
  $('#overlayEmoji').style.display = won ? 'none' : '';
  $('#overlayTitle').textContent = won ? 'Уровень пройден!' : 'Ловушка сработала!';
  if (won){
    if (finalWin){
      $('#overlayText').textContent = 'Третья часть флага добавлена, флаг ваш! Удачи на HoneyBadger CTF!';
    } else if (state.newFlagPart){
      $('#overlayText').textContent = FLAG_PART_NAMES[state.level] + ' добавлена. Следующий уровень уже открыт';
    } else {
      $('#overlayText').textContent = FLAG_PART_NAMES[state.level] + ' уже была собрана.';
    }
    $('#againBtn').textContent = finalWin ? 'Ура!' : 'Следующий уровень';
  } else {
    $('#overlayText').textContent = 'Медоед наступил на спрятанную ловушку. Обходи их аккуратно!';
    $('#againBtn').textContent = 'Попробовать снова';
  }
  $('#overlay').classList.remove('hidden');
}
function hideOverlay(){ $('#overlay').classList.add('hidden'); }

function launchCelebration(){
  var layer = $('#celebration');
  var colors = ['#ffc700','#ff5b8d','#7b5cff','#5ce1e6','#ffffff','#ff8a3d'];
  layer.innerHTML = '';
  layer.hidden = false;
  for (var i = 0; i < 18; i++){
    var bee = document.createElement('span');
    bee.className = 'party-bee';
    bee.textContent = '🐝';
    var angle = (Math.PI * 2 * i / 18) + (Math.random() - .5) * .45;
    var distance = 42 + Math.random() * 55;
    bee.style.setProperty('--dx', (Math.cos(angle) * distance).toFixed(1) + 'vw');
    bee.style.setProperty('--dy', (Math.sin(angle) * distance).toFixed(1) + 'vh');
    bee.style.setProperty('--rot', ((Math.random() - .5) * 760).toFixed(0) + 'deg');
    bee.style.animationDelay = (Math.random() * .22).toFixed(2) + 's';
    layer.appendChild(bee);
  }
  for (var c = 0; c < 110; c++){
    var bit = document.createElement('i');
    bit.className = 'confetti';
    bit.style.left = (Math.random() * 100).toFixed(1) + 'vw';
    bit.style.setProperty('--color', colors[c % colors.length]);
    bit.style.setProperty('--drift', ((Math.random() - .5) * 34).toFixed(1) + 'vw');
    bit.style.setProperty('--duration', (2.5 + Math.random() * 2).toFixed(2) + 's');
    bit.style.setProperty('--delay', (Math.random() * .8).toFixed(2) + 's');
    layer.appendChild(bit);
  }
  var burstCount = 8 + Math.floor(Math.random() * 4);
  for (var burst = 0; burst < burstCount; burst++){
    var origin = [8 + Math.random() * 84, 10 + Math.random() * 52];
    var rayCount = 24 + Math.floor(Math.random() * 13);
    var burstColor = colors[Math.floor(Math.random() * colors.length)];
    var burstDelay = .05 + Math.random() * 1.65;
    var baseRadius = 70 + Math.random() * 85;
    for (var ray = 0; ray < rayCount; ray++){
      var spark = document.createElement('i');
      var a = Math.PI * 2 * ray / rayCount + (Math.random() - .5) * .1;
      var radius = baseRadius * (.72 + Math.random() * .45);
      spark.className = 'firework';
      spark.style.left = origin[0].toFixed(1) + 'vw';
      spark.style.top = origin[1].toFixed(1) + 'vh';
      spark.style.setProperty('--color', Math.random() < .78 ? burstColor : colors[Math.floor(Math.random() * colors.length)]);
      spark.style.setProperty('--fx', (Math.cos(a) * radius).toFixed(1) + 'px');
      spark.style.setProperty('--fy', (Math.sin(a) * radius).toFixed(1) + 'px');
      spark.style.setProperty('--delay', (burstDelay + Math.random() * .16).toFixed(2) + 's');
      spark.style.setProperty('--size', (5 + Math.random() * 6).toFixed(1) + 'px');
      spark.style.setProperty('--fw-duration', (1.1 + Math.random() * .75).toFixed(2) + 's');
      layer.appendChild(spark);
    }
  }
  setTimeout(function(){ layer.hidden = true; layer.innerHTML = ''; }, 4800);
}

function newGame(){
  clearTimers();
  hideOverlay();
  var level = $('#diffInput').value;
  if (!LEVELS[level] || (level === 'medium' && !progress.easy) || (level === 'hard' && !progress.medium)){
    level = 'easy';
    $('#diffInput').value = level;
  }
  var g = generateGame(FIXED_COLS, FIXED_ROWS, LEVELS[level]);
  state = { cols: FIXED_COLS, rows: FIXED_ROWS, traps: g.traps, holes: g.holes, goal: g.goal, badger: g.start.slice(), level: level, phase: 'memo', routeLength: g.routeLength || null, nextLevel: null, newFlagPart: false };
  renderBoard();
  startMemoPhase();
}

boardSvg.addEventListener('click', function(e){
  var poly = e.target.closest ? e.target.closest('polygon.cell') : null;
  if (!poly) return;
  tryMove(+poly.dataset.c, +poly.dataset.r);
});
$('#newGameBtn').addEventListener('click', function(){
  if (this.dataset.resetProgress === 'true') resetProgress();
  newGame();
});
$('#againBtn').addEventListener('click', function(){
  if (state && state.phase === 'over' && state.level === 'hard' && progress.hard){
    hideOverlay();
    launchCelebration();
    return;
  } else if (state && state.nextLevel){
    $('#diffInput').value = state.nextLevel;
  }
  newGame();
});
$('#diffInput').addEventListener('change', newGame);

$('#copyFlagBtn').addEventListener('click', function(){
  var button = this;
  if (button.disabled) return;
  var value = flagText();
  function copied(){
    button.textContent = 'Скопировано';
    button.classList.add('copied');
    if (progress.hard){
      $('#newGameBtn').textContent = 'Сыграть заново';
      $('#newGameBtn').dataset.resetProgress = 'true';
    }
    setTimeout(function(){ button.textContent = 'Скопировать'; button.classList.remove('copied'); }, 1500);
  }
  if (navigator.clipboard && navigator.clipboard.writeText){
    navigator.clipboard.writeText(value).then(copied).catch(function(){
      var range = document.createRange();
      range.selectNodeContents($('#flagValue'));
      var selection = window.getSelection();
      selection.removeAllRanges(); selection.addRange(range);
      try { if (document.execCommand('copy')) copied(); } catch (e) {}
    });
  } else {
    var range = document.createRange();
    range.selectNodeContents($('#flagValue'));
    var selection = window.getSelection();
    selection.removeAllRanges(); selection.addRange(range);
    try { document.execCommand('copy'); copied(); } catch (e) {}
  }
});
$('#diffInput').value = 'easy';
updateFlagUI();
newGame();
