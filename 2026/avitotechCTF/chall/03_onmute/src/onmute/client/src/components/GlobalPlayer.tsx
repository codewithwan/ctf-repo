import { useCallback } from 'react';
import { Button } from '@/components/ui/button';
import { Slider } from '@/components/ui/slider';
import { usePlayer } from '@/context/PlayerContext';
import './volume-slider.css';

function formatTime(seconds: number): string {
  if (!isFinite(seconds) || seconds < 0) return '0:00';
  const m = Math.floor(seconds / 60);
  const s = Math.floor(seconds % 60);
  return `${m}:${s.toString().padStart(2, '0')}`;
}

function unwrap(val: number | readonly number[]): number {
  return typeof val === 'number' ? val : val[0];
}

export default function GlobalPlayer() {
  const {
    track,
    playing,
    currentTime,
    duration,
    volume,
    muted,
    togglePlay,
    seek,
    setVolume,
    toggleMute,
    playNext,
    playPrev,
  } = usePlayer();

  const handleSeek = useCallback(
    (val: number | readonly number[]) => seek(unwrap(val)),
    [seek],
  );

  if (!track) return null;

  return (
    <div className="fixed bottom-0 left-0 right-0 z-50 border-t bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/80">
      {/* Seek bar on top of the player */}
      <div className="px-4">
        <Slider
          value={[currentTime]}
          onValueChange={handleSeek}
          max={duration || 100}
          step={0.1}
          className="w-full"
        />
      </div>

      <div className="max-w-3xl mx-auto px-4 py-3 flex items-center gap-3">
        {/* Controls: prev, play/pause, next */}
        <div className="flex items-center gap-1">
          <Button
            variant="ghost"
            size="icon"
            className="h-8 w-8"
            onClick={playPrev}
          >
            <svg width="14" height="14" viewBox="0 0 16 16" fill="currentColor">
              <path d="M13 2.5v11l-7-5.5zm-9 0v11h-2v-11z" />
            </svg>
          </Button>

          <Button
            variant="outline"
            size="icon"
            className="h-10 w-10 rounded-full"
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

          <Button
            variant="ghost"
            size="icon"
            className="h-8 w-8"
            onClick={playNext}
          >
            <svg width="14" height="14" viewBox="0 0 16 16" fill="currentColor">
              <path d="M3 2.5v11l7-5.5zm9 0v11h2v-11z" />
            </svg>
          </Button>
        </div>

        {/* Track info + time */}
        <div className="flex-1 min-w-0">
          <p className="text-sm font-medium truncate">{track.title}</p>
          <p className="text-xs text-muted-foreground">
            {track.artist} &middot; {formatTime(currentTime)} / {formatTime(duration)}
          </p>
        </div>

        {/* Volume */}
        <div className="flex items-center gap-2 shrink-0">
          <Button
            variant="ghost"
            size="icon"
            className="h-8 w-8"
            onClick={toggleMute}
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
          <input
            type="range"
            min={0}
            max={100}
            step={1}
            value={muted ? 0 : volume}
            onChange={(e) => setVolume(Number(e.target.value))}
            className="volume-range w-24"
          />
        </div>
      </div>
    </div>
  );
}
