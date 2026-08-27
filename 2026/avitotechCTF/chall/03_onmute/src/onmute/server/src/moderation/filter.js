import { BLOCKED_WORDS } from './blocklist.js';

const policies = new Map();

function getPolicy(sessionId) {
  if (!policies.has(sessionId)) {
    policies.set(sessionId, {
      id: sessionId,
      re: new RegExp(
        `(?:${BLOCKED_WORDS.join('|')})(?=[\\s.,!?;:)}\\]"'»]|$)`,
        'gi',
      ),
    });
  }
  return policies.get(sessionId);
}

export function checkContent(text, sessionId) {
  const { re } = getPolicy(sessionId);
  const violations = [];
  let m;

  while ((m = re.exec(text)) !== null) {
    violations.push({ match: m[0], index: m.index });
  }

  return { blocked: violations.length > 0, violations };
}

export function matchesPolicy(fragment, sessionId) {
  const { re } = getPolicy(sessionId);
  return re.test(fragment);
}

export function removeFilter(sessionId) {
  policies.delete(sessionId);
}
