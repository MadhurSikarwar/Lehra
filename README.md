# Lehra Studio Web

A premium, interactive web application designed for Indian Classical music practice (Riyaz). This project brings the functionality of the mobile Lehra Studio app into the browser, complete with real-time pitch shifting, tempo adjustments, a practice tracker, and a beautiful, distraction-free UI.

> [!IMPORTANT]
> **Educational Use Only**
> This project was built strictly for **educational purposes** to explore advanced Web Audio API and digital signal processing techniques in Python. It utilizes some copyrighted audio assets which are included under fair use for educational demonstration only. 

## Features
- **High-Quality Pitch Shifting:** Change the pitch to match your instrument flawlessly, driven by a Python backend using `librosa`.
- **Dynamic Tempo:** Time-stretch the audio playback speed without affecting the pitch.
- **Riyaz Tracker:** Automatically tracks your daily practice sessions and visualizes your progress over a 7-day period using browser `localStorage`.
- **Studio Effects:** Built-in Bass and Treble EQ, along with a dynamically synthesized Reverb effect to simulate concert halls.
- **Visualizer & Fullscreen:** An audio-reactive, pulsing mandala syncs to the music. Enter distraction-free fullscreen mode to hide controls during practice.
- **Programmable Metronome:** Synthesized tick-tock options including classic clicks, digital beeps, and woodblocks, scheduled accurately using lookahead timers.

## Architecture

The project consists of a lightweight Vanilla JS frontend and a robust Python Flask backend.

### Frontend (Vanilla JS + HTML5 + CSS3)
- **Web Audio API:** Uses a pure `AudioContext` to route audio through `GainNode`, `BiquadFilterNode` (for EQ), `ConvolverNode` (for Reverb), and `AnalyserNode` (for the audio-reactive visualizer).
- **Zero-Drift Synchronization:** Metronome clicks are scheduled perfectly in time with the backing track using a Web Audio lookahead `nextNoteTime` loop, avoiding the drift common with `setInterval`.
- **UI & State Management:** A responsive dark-themed UI built with Vanilla CSS. Uses `localStorage` to persist Riyaz (practice) statistics and state.

### Backend (Python Flask + Librosa)
- **Audio Processing Engine:** Real-time, artifact-free pitch shifting and time stretching using `librosa` (PSOLA algorithms).
- **Concurrent Cache System:** To ensure snappy playback, processed `.wav` files are cached on disk. Thread-safe locking prevents race conditions when multiple concurrent requests ask for the same pitch/tempo combination.
- **Auto-Cleanup:** A background thread periodically scans and cleans the `audio_cache` directory to ensure it doesn't exceed 500MB, preventing disk bloat.

## Getting Started

1. Install Python dependencies:
   ```bash
   pip install flask librosa soundfile numpy
   ```
2. Run the server:
   ```bash
   python server.py
   ```
3. Open `http://localhost:3000` in your web browser.
