const BASE = '/api';

export interface Track {
  id: number;
  title: string;
  artist: string;
  text: string;
  hasAudio: boolean;
}

export interface Comment {
  type: 'user' | 'bot';
  text: string;
  status?: string;
  timestamp: number;
}

export interface CommentResponse {
  ok: boolean;
  type?: string;
  command?: string;
  message?: string;
  reason?: string;
  violations?: { match: string; index: number }[];
}

export async function fetchTracks(): Promise<Track[]> {
  const res = await fetch(`${BASE}/tracks`);
  const data = await res.json();
  return data.tracks ?? [];
}

export async function fetchTrack(id: number): Promise<Track | null> {
  const res = await fetch(`${BASE}/tracks/${id}`);
  const data = await res.json();
  return data.ok ? data.track : null;
}

export async function fetchComments(trackId: number): Promise<Comment[]> {
  const res = await fetch(`${BASE}/tracks/${trackId}/comments`);
  const data = await res.json();
  return data.comments ?? [];
}

export async function postComment(
  trackId: number,
  text: string,
): Promise<CommentResponse> {
  const res = await fetch(`${BASE}/tracks/${trackId}/comment`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ text }),
  });
  return res.json();
}

export function streamUrl(trackId: number): string {
  return `${BASE}/tracks/${trackId}/stream`;
}
