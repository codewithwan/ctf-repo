import { useEffect, useState, useRef, useCallback } from 'react';
import { useParams, Link } from 'react-router-dom';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Separator } from '@/components/ui/separator';
import { ScrollArea } from '@/components/ui/scroll-area';
import CommandAutocomplete from '@/components/CommandAutocomplete';
import type { Track, Comment } from '@/lib/api';
import { fetchTrack, fetchComments, postComment } from '@/lib/api';
import { usePlayer } from '@/context/PlayerContext';

export default function TrackPage() {
  const { id } = useParams<{ id: string }>();
  const trackId = Number(id);

  const [track, setTrack] = useState<Track | null>(null);
  const [comments, setComments] = useState<Comment[]>([]);
  const [input, setInput] = useState('');
  const [sending, setSending] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    fetchTrack(trackId).then(setTrack);
    fetchComments(trackId).then(setComments);
  }, [trackId]);

  useEffect(() => {
    scrollRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [comments]);

  const handleSend = useCallback(async (text?: string) => {
    const msg = (text ?? input).trim();
    if (!msg) return;

    setSending(true);
    setInput('');

    await postComment(trackId, msg);

    const updated = await fetchComments(trackId);
    setComments(updated);
    setSending(false);
  }, [input, trackId]);

  const lyricsRef = useRef<HTMLPreElement>(null);
  const handleLyricsMouseUp = useCallback(() => {
    const selection = window.getSelection();
    if (!selection || selection.isCollapsed || !lyricsRef.current) return;

    const range = selection.getRangeAt(0);

    if (!lyricsRef.current.contains(range.startContainer)) return;

    const preRange = document.createRange();
    preRange.selectNodeContents(lyricsRef.current);
    preRange.setEnd(range.startContainer, range.startOffset);
    const startIdx = preRange.toString().length;

    const text = selection.toString();
    if (!text || text.trim().length < 2) return;

    const endIdx = startIdx + text.length;
    setInput(`/censor ${startIdx} ${endIdx}`);
  }, []);

  if (!track) {
    return (
      <div className="max-w-3xl mx-auto p-6">
        <p className="text-muted-foreground">Загрузка...</p>
      </div>
    );
  }

  return (
    <div className="max-w-3xl mx-auto p-6">
      <Link to="/" className="text-sm text-muted-foreground hover:text-foreground mb-4 inline-block">
        &larr; Назад к трекам
      </Link>

      <h1 className="text-2xl font-bold">{track.title}</h1>
      <p className="text-muted-foreground mb-4">{track.artist}</p>

      {/* Audio play/pause */}
      {track.hasAudio ? (
        <TrackPlayButton track={track} />
      ) : (
        <Card className="mb-6 bg-muted/50">
          <CardContent className="py-4 text-center text-sm text-muted-foreground">
            Воспроизведение временно недоступно по запросу правообладателя
          </CardContent>
        </Card>
      )}

      {/* Lyrics */}
      <Card className="mb-6">
        <CardHeader className="pb-2">
          <CardTitle className="text-base">Текст</CardTitle>
        </CardHeader>
        <CardContent>
          <pre
            ref={lyricsRef}
            className="text-sm whitespace-pre-wrap font-mono leading-relaxed select-text cursor-text"
            onMouseUp={handleLyricsMouseUp}
          >
            {track.text}
          </pre>
          <p className="text-xs text-muted-foreground mt-3">
            Выделите слова в тексте, чтобы предложить цензуру
          </p>
        </CardContent>
      </Card>

      <Separator className="mb-6" />

      {/* Comments */}
      <h2 className="text-lg font-semibold mb-3">Комментарии</h2>

      <ScrollArea className="h-64 mb-4 rounded-md border p-4">
        {comments.length === 0 && (
          <p className="text-sm text-muted-foreground">
            Пока нет комментариев. Попробуйте команду /help
          </p>
        )}
        {comments.map((c, i) => (
          <div
            key={i}
            className={`mb-3 text-sm ${c.type === 'bot' ? 'font-mono text-blue-600 dark:text-blue-400' : ''}`}
          >
            <span className="font-semibold">
              {c.type === 'bot' ? '@bot' : 'вы'}:
            </span>{' '}
            <span className="whitespace-pre-wrap">{c.text}</span>
          </div>
        ))}
        <div ref={scrollRef} />
      </ScrollArea>

      {/* Input with autocomplete */}
      <CommandAutocomplete
        value={input}
        onChange={setInput}
        onSend={handleSend}
        trackId={trackId}
        disabled={sending}
      />
    </div>
  );
}

function TrackPlayButton({ track }: { track: Track }) {
  const { play, togglePlay, track: currentTrack, playing } = usePlayer();
  const isCurrentTrack = currentTrack?.id === track.id;
  const isPlaying = isCurrentTrack && playing;

  return (
    <div className="mb-6 flex items-center gap-3">
      <Button
        variant="outline"
        size="icon"
        className="h-12 w-12 rounded-full"
        onClick={() => {
          if (isCurrentTrack) {
            togglePlay();
          } else {
            play(track);
          }
        }}
      >
        {isPlaying ? (
          <svg width="20" height="20" viewBox="0 0 16 16" fill="currentColor">
            <rect x="3" y="2" width="4" height="12" rx="1" />
            <rect x="9" y="2" width="4" height="12" rx="1" />
          </svg>
        ) : (
          <svg width="20" height="20" viewBox="0 0 16 16" fill="currentColor">
            <path d="M4 2.5v11l9-5.5z" />
          </svg>
        )}
      </Button>
      <span className="text-sm text-muted-foreground">
        {isPlaying ? 'Воспроизводится' : 'Слушать'}
      </span>
    </div>
  );
}
