import { createContext, useContext, useState, useRef, useCallback, useEffect } from 'react';
import type { Track } from '@/lib/api';
import { streamUrl } from '@/lib/api';

interface PlayerState {
  track: Track | null;
  playing: boolean;
  currentTime: number;
  duration: number;
  volume: number;
  muted: boolean;
}

interface PlayerContextValue extends PlayerState {
  play: (track: Track) => void;
  togglePlay: () => void;
  pause: () => void;
  seek: (time: number) => void;
  setVolume: (v: number) => void;
  toggleMute: () => void;
  playNext: () => void;
  playPrev: () => void;
  setPlaylist: (tracks: Track[]) => void;
}

const PlayerContext = createContext<PlayerContextValue | null>(null);

export function usePlayer() {
  const ctx = useContext(PlayerContext);
  if (!ctx) throw new Error('usePlayer must be used within PlayerProvider');
  return ctx;
}

export function PlayerProvider({ children }: { children: React.ReactNode }) {
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const playlistRef = useRef<Track[]>([]);
  const [state, setState] = useState<PlayerState>({
    track: null,
    playing: false,
    currentTime: 0,
    duration: 0,
    volume: 80,
    muted: false,
  });

  useEffect(() => {
    const audio = new Audio();
    audio.preload = 'metadata';
    audioRef.current = audio;

    audio.addEventListener('timeupdate', () =>
      setState((s) => ({ ...s, currentTime: audio.currentTime })),
    );
    audio.addEventListener('durationchange', () =>
      setState((s) => ({ ...s, duration: audio.duration })),
    );
    audio.addEventListener('ended', () => {
      setState((s) => ({ ...s, playing: false }));
      // auto-next with loop
      const playlist = playlistRef.current;
      const current = stateRef.current.track;
      if (playlist.length > 0 && current) {
        const idx = playlist.findIndex((t) => t.id === current.id);
        const len = playlist.length;
        for (let offset = 1; offset < len; offset++) {
          const next = playlist[(idx + offset) % len];
          if (next.hasAudio) {
            playTrack(next);
            return;
          }
        }
      }
    });

    return () => {
      audio.pause();
      audio.src = '';
    };
  }, []);

  const stateRef = useRef(state);
  stateRef.current = state;

  useEffect(() => {
    const audio = audioRef.current;
    if (!audio) return;
    audio.volume = state.muted ? 0 : state.volume / 100;
  }, [state.volume, state.muted]);

  const playTrack = useCallback((track: Track) => {
    const audio = audioRef.current;
    if (!audio) return;
    const current = stateRef.current.track;
    if (current?.id !== track.id) {
      audio.src = streamUrl(track.id);
      audio.load();
    }
    audio.play();
    setState((s) => ({ ...s, track, playing: true, currentTime: 0, duration: 0 }));
  }, []);

  const togglePlay = useCallback(() => {
    const audio = audioRef.current;
    if (!audio || !stateRef.current.track) return;
    if (stateRef.current.playing) {
      audio.pause();
      setState((s) => ({ ...s, playing: false }));
    } else {
      audio.play();
      setState((s) => ({ ...s, playing: true }));
    }
  }, []);

  const pause = useCallback(() => {
    audioRef.current?.pause();
    setState((s) => ({ ...s, playing: false }));
  }, []);

  const seek = useCallback((time: number) => {
    const audio = audioRef.current;
    if (!audio) return;
    audio.currentTime = time;
    setState((s) => ({ ...s, currentTime: time }));
  }, []);

  const setVolume = useCallback((v: number) => {
    setState((s) => ({ ...s, volume: v, muted: false }));
  }, []);

  const toggleMute = useCallback(() => {
    setState((s) => ({ ...s, muted: !s.muted }));
  }, []);

  const setPlaylist = useCallback((tracks: Track[]) => {
    playlistRef.current = tracks;
  }, []);

  const playNext = useCallback(() => {
    const playlist = playlistRef.current;
    const current = stateRef.current.track;
    if (!current || playlist.length === 0) return;
    const idx = playlist.findIndex((t) => t.id === current.id);
    const len = playlist.length;
    for (let offset = 1; offset < len; offset++) {
      const next = playlist[(idx + offset) % len];
      if (next.hasAudio) {
        playTrack(next);
        return;
      }
    }
  }, [playTrack]);

  const playPrev = useCallback(() => {
    const playlist = playlistRef.current;
    const current = stateRef.current.track;
    if (!current || playlist.length === 0) return;
    const idx = playlist.findIndex((t) => t.id === current.id);
    const len = playlist.length;
    for (let offset = 1; offset < len; offset++) {
      const prev = playlist[(idx - offset + len) % len];
      if (prev.hasAudio) {
        playTrack(prev);
        return;
      }
    }
  }, [playTrack]);

  return (
    <PlayerContext.Provider
      value={{
        ...state,
        play: playTrack,
        togglePlay,
        pause,
        seek,
        setVolume,
        toggleMute,
        playNext,
        playPrev,
        setPlaylist,
      }}
    >
      {children}
    </PlayerContext.Provider>
  );
}
