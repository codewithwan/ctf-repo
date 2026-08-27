import { BrowserRouter, Routes, Route } from 'react-router-dom';
import TrackList from '@/pages/TrackList';
import TrackPage from '@/pages/TrackPage';
import GlobalPlayer from '@/components/GlobalPlayer';
import { PlayerProvider } from '@/context/PlayerContext';

function App() {
  return (
    <PlayerProvider>
      <BrowserRouter>
        <div className="pb-20">
          <Routes>
            <Route path="/" element={<TrackList />} />
            <Route path="/tracks/:id" element={<TrackPage />} />
          </Routes>
        </div>
        <GlobalPlayer />
      </BrowserRouter>
    </PlayerProvider>
  );
}

export default App;
