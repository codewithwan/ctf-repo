import { useState, useRef, useEffect, useCallback } from 'react';
import { Button } from '@/components/ui/button';
import { Slider } from '@/components/ui/slider';

function formatTime(seconds: number): string {
  if (!isFinite(seconds) || seconds < 0) return '0:00';
  const m = Math.floor(seconds / 60);
  const s = Math.floor(seconds % 60);
  return `${m}:${s.toString().padStart(2, '0')}`;
}

interface Props {
  src: string;
  title: string;
}

export default function AudioPlayer({ src, title }: Props) {
  const audioRef = useRef<HTMLAudioElement>(null);
  const [playing, setPlaying] = useState(false);
  const [currentTime, setCurrentTime] = useState(0);
  const [duration, setDuration] = useState(0);
  const [volume, setVolume] = useState(80);
  const [muted, setMuted] = useState(false);

  useEffect(() => {
    const audio = audioRef.current;
    if (!audio) return;

    const onTimeUpdate = () => setCurrentTime(audio.currentTime);
    const onDurationChange = () => setDuration(audio.duration);
    const onEnded = () => setPlaying(false);

    audio.addEventListener('timeupdate', onTimeUpdate);
    audio.addEventListener('durationchange', onDurationChange);
    audio.addEventListener('ended', onEnded);

    return () => {
      audio.removeEventListener('timeupdate', onTimeUpdate);
      audio.removeEventListener('durationchange', onDurationChange);
      audio.removeEventListener('ended', onEnded);
    };
  }, []);

  useEffect(() => {
    const audio = audioRef.current;
    if (!audio) return;
    audio.volume = muted ? 0 : volume / 100;
  }, [volume, muted]);

  const togglePlay = useCallback(() => {
    const audio = audioRef.current;
    if (!audio) return;
    if (playing) {
      audio.pause();
    } else {
      audio.play();
    }
    setPlaying(!playing);
  }, [playing]);

  const handleSeek = useCallback((val: number | readonly number[]) => {
    if (typeof val === 'number') return;
    const audio = audioRef.current;
    if (!audio) return;
    audio.currentTime = val[0];
    setCurrentTime(val[0]);
  }, []);

  const handleVolume = useCallback((val: number | readonly number[]) => {
    if (typeof val === 'number') return;
    setVolume(val[0]);
    setMuted(false);
  }, []);

  return (
    <div className="mb-6 rounded-lg border bg-card p-4">
      <audio ref={audioRef} src={src} preload="metadata" />

      {/* Top row: play + title + time */}
      <div className="flex items-center gap-3 mb-3">
        <Button
          variant="outline"
          size="icon"
          className="h-10 w-10 shrink-0 rounded-full"
          onClick={togglePlay}
        >
          {playing ? (
            <svg width="16" height="16" viewBox="0 0 16 16" fill="currentColor">
              <rect x="3" y="2" width="4" height="12" rx="1" />
              <rect x="9" y="2" width="4" height="12" rx="1" />
            </svg>
          ) : (
            <svg width="16" height="16" viewBox="0 0 16 16" fill="currentColor">
              <path d="M4 2.5v11l9-5.5z" />
            </svg>
          )}
        </Button>

        <div className="flex-1 min-w-0">
          <p className="text-sm font-medium truncate">{title}</p>
          <p className="text-xs text-muted-foreground">
            {formatTime(currentTime)} / {formatTime(duration)}
          </p>
        </div>

        {/* Volume */}
        <div className="flex items-center gap-2 shrink-0">
          <Button
            variant="ghost"
            size="icon"
            className="h-8 w-8"
            onClick={() => setMuted(!muted)}
          >
            {muted || volume === 0 ? (
              <svg width="14" height="14" viewBox="0 0 16 16" fill="currentColor">
                <path d="M8 2L4 5.5H1v5h3L8 14V2zM13.5 5.5l-3 3m0-3l3 3" stroke="currentColor" strokeWidth="1.5" fill="none" />
              </svg>
            ) : (
              <svg width="14" height="14" viewBox="0 0 16 16" fill="currentColor">
                <path d="M8 2L4 5.5H1v5h3L8 14V2z" />
                <path d="M11 5.5a3.5 3.5 0 010 5" stroke="currentColor" strokeWidth="1.5" fill="none" />
              </svg>
            )}
          </Button>
          <Slider
            value={[muted ? 0 : volume]}
            onValueChange={handleVolume}
            max={100}
            step={1}
            className="w-20"
          />
        </div>
      </div>

      {/* Seek bar */}
      <Slider
        value={[currentTime]}
        onValueChange={handleSeek}
        max={duration || 100}
        step={0.1}
        className="w-full"
      />
    </div>
  );
}
