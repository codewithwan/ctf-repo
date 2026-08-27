import { useState, useRef, useEffect } from 'react';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';

interface Command {
  name: string;
  description: string;
  template: (trackId: number) => string;
}

const COMMANDS: Command[] = [
  {
    name: '/help',
    description: 'Показать доступные команды',
    template: () => '/help',
  },
  {
    name: '/censor',
    description: 'Зацензурить фрагмент (выделите текст)',
    template: () => `/censor 0 0`,
  },
  {
    name: '/report',
    description: 'Пожаловаться на трек',
    template: () => `/report `,
  },
  {
    name: '/status',
    description: 'Статус модерации трека',
    template: (id) => `/status ${id}`,
  },
  {
    name: '/original',
    description: 'Показать оригинальный текст',
    template: (id) => `/original ${id}`,
  },
];

interface Props {
  value: string;
  onChange: (value: string) => void;
  onSend: (text?: string) => void;
  trackId: number;
  disabled: boolean;
}

export default function CommandAutocomplete({ value, onChange, onSend, trackId, disabled }: Props) {
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [selectedIndex, setSelectedIndex] = useState(0);
  const inputRef = useRef<HTMLInputElement>(null);

  const filtered = value.startsWith('/')
    ? COMMANDS.filter((c) => c.name.startsWith(value.split(' ')[0].toLowerCase()))
    : [];

  const shouldShow = showSuggestions && filtered.length > 0 && !value.includes(' ');

  useEffect(() => {
    setSelectedIndex(0);
  }, [value]);

  function handleKeyDown(e: React.KeyboardEvent) {
    if (shouldShow) {
      if (e.key === 'ArrowDown') {
        e.preventDefault();
        setSelectedIndex((i) => Math.min(i + 1, filtered.length - 1));
        return;
      }
      if (e.key === 'ArrowUp') {
        e.preventDefault();
        setSelectedIndex((i) => Math.max(i - 1, 0));
        return;
      }
      if (e.key === 'Tab' || e.key === 'Enter') {
        if (filtered[selectedIndex]) {
          e.preventDefault();
          const cmd = filtered[selectedIndex];
          onChange(cmd.template(trackId));
          setShowSuggestions(false);
          return;
        }
      }
      if (e.key === 'Escape') {
        setShowSuggestions(false);
        return;
      }
    }

    if (e.key === 'Enter' && !shouldShow && !disabled) {
      onSend();
    }
  }

  function selectCommand(cmd: Command) {
    onChange(cmd.template(trackId));
    setShowSuggestions(false);
    inputRef.current?.focus();
  }

  return (
    <div className="relative">
      {shouldShow && (
        <div className="absolute bottom-full left-0 right-0 mb-1 bg-popover border rounded-md shadow-md z-10 overflow-hidden">
          {filtered.map((cmd, i) => (
            <button
              key={cmd.name}
              type="button"
              className={`w-full text-left px-3 py-2 text-sm flex justify-between items-center hover:bg-accent ${
                i === selectedIndex ? 'bg-accent' : ''
              }`}
              onMouseDown={(e) => {
                e.preventDefault();
                selectCommand(cmd);
              }}
            >
              <span className="font-mono font-semibold">{cmd.name}</span>
              <span className="text-muted-foreground text-xs ml-4">{cmd.description}</span>
            </button>
          ))}
        </div>
      )}

      <div className="flex gap-2">
        <Input
          ref={inputRef}
          value={value}
          onChange={(e) => {
            onChange(e.target.value);
            setShowSuggestions(true);
          }}
          onFocus={() => setShowSuggestions(true)}
          onBlur={() => setTimeout(() => setShowSuggestions(false), 150)}
          onKeyDown={handleKeyDown}
          placeholder="Комментарий или /help для команд..."
          disabled={disabled}
        />
        <Button onClick={() => onSend()} disabled={disabled || !value.trim()}>
          Отправить
        </Button>
      </div>
    </div>
  );
}
