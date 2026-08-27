export function maskWord(word) {
  const keep = Math.ceil(word.length / 2);
  return word.slice(0, keep) + '*'.repeat(word.length - keep);
}
