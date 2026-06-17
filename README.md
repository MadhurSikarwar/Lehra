# Lehra Studio Web

A premium, interactive web application designed for Indian Classical music practice (Riyaz). This project brings the functionality of the mobile Lehra Studio app into the browser, complete with real-time pitch shifting, tempo adjustments, a practice tracker, and a beautiful, distraction-free UI.

> [!IMPORTANT]
> **Educational Use Only**
> This project was built strictly for **educational purposes** to explore advanced Web Audio API and digital signal processing techniques in Python. It utilizes some copyrighted audio assets which are included under fair use for educational demonstration only. 

## How the Background Audio Engineering Works

Achieving high-fidelity audio manipulation in a web browser is incredibly challenging. Traditional client-side approaches (like the Web Audio API's `playbackRate` or JavaScript Phase Vocoders) introduce robotic "buzzing" artifacts when attempting to independently change pitch and tempo. This ruins the rich, complex harmonics of classical Indian instruments like the Sarangi and Sitar.

To solve this, Lehra Studio Web uses a **Hybrid Client-Server Audio Architecture**:

### 1. The Python Backend (Digital Signal Processing)
When you select a combination of Instrument, Pitch, and Tempo, the frontend sends a request to the Python Flask backend. The backend uses **Librosa**, an advanced audio analysis library, to process the raw audio files dynamically:
*   **Segment Slicing:** The original recordings are long tracks containing multiple tempo variations. The backend calculates the exact timestamp (`start` and `end`) for the closest recorded tempo segment.
*   **Time-Stretching:** If the requested BPM isn't an exact match to the recording, Librosa stretches the audio perfectly in time using PSOLA without changing its pitch.
*   **Pitch-Shifting:** It then shifts the audio to your target scale (e.g., C# at 138.59 Hz) using a high-quality `kaiser_best` resampling algorithm, avoiding all robotic artifacts.
*   **Caching:** Processing audio takes heavy CPU power. To make the app instantaneous, the server caches the resulting `.wav` file on the hard drive using a unique hash. If you request that exact pitch and tempo again, the server serves the cached file instantly.

### 2. The Javascript Frontend (Playback & Scheduling)
Because the server handles the heavy lifting, the browser receives a pristine, perfectly pitched, and perfectly stretched audio file.
*   **Zero-Drift Synchronization:** The frontend plays the audio at `playbackRate=1.0`. To ensure the metronome and visualizers stay perfectly in sync with the Lehra without "drifting" out of time over long practice sessions, we use a Web Audio lookahead `nextNoteTime` loop instead of a standard JavaScript `setInterval`.
*   **Real-time FX:** We then use the Web Audio API to route this pristine audio through a custom FX chain (`BiquadFilterNode` for Bass/Treble EQ, and a `ConvolverNode` for a dynamically synthesized Reverb).

## Advanced Features
- **Riyaz Tracker:** Automatically tracks your daily practice sessions and visualizes your progress over a 7-day period using browser `localStorage`.
- **Studio Effects:** Built-in Bass and Treble EQ, along with a dynamically synthesized Reverb effect to simulate concert halls.
- **Visualizer & Fullscreen:** An audio-reactive, pulsing mandala syncs to the music. Enter distraction-free fullscreen mode to hide controls during practice.
- **Programmable Metronome:** Synthesized tick-tock options including classic clicks, digital beeps, and woodblocks, scheduled accurately using lookahead timers.

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
