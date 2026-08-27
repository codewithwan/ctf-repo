import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import type { Track } from '@/lib/api';
import { fetchTracks } from '@/lib/api';
import { usePlayer } from '@/context/PlayerContext';

export default function TrackList() {
  const [tracks, setTracks] = useState<Track[]>([]);
  const { play, track: currentTrack, playing, togglePlay, setPlaylist } = usePlayer();

  useEffect(() => {
    fetchTracks().then((data) => {
      setTracks(data);
      setPlaylist(data);
    });
  }, [setPlaylist]);

  return (
    <div className="max-w-3xl mx-auto p-6">
      <h1 className="text-3xl font-bold mb-2">На мьюте</h1>
      <p className="text-muted-foreground mb-8">
        Дерзкие треки для бесстрашных. Модерация - беспощадная.
      </p>

      <div className="space-y-4">
        {tracks.map((track) => {
          const isCurrentTrack = currentTrack?.id === track.id;
          const isPlaying = isCurrentTrack && playing;
          return (
            <Link key={track.id} to={`/tracks/${track.id}`} className="block no-underline">
              <Card className="hover:bg-accent/50 transition-colors">
                <CardHeader className="pb-2">
                  <div className="flex items-center justify-between gap-3">
                    <div className="min-w-0">
                      <CardTitle className="text-lg">{track.title}</CardTitle>
                      <CardDescription>{track.artist}</CardDescription>
                    </div>
                    {track.hasAudio && (
                      <Button
                        variant="outline"
                        size="icon"
                        className="h-10 w-10 shrink-0 rounded-full"
                        onClick={(e) => {
                          e.preventDefault();
                          e.stopPropagation();
                          if (isPlaying) {
                            togglePlay();
                          } else {
                            play(track);
                          }
                        }}
                      >
                        {isPlaying ? (
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
                    )}
                  </div>
                </CardHeader>
                <CardContent>
                  <pre className="text-sm text-muted-foreground whitespace-pre-wrap font-mono leading-relaxed">
                    {track.text.slice(0, 120)}
                    {track.text.length > 120 ? '...' : ''}
                  </pre>
                </CardContent>
              </Card>
            </Link>
          );
        })}
      </div>
    </div>
  );
}
