# 🎙️ Speech Sample Pipeline

An automated, single-command CLI tool to download, isolate speech (via local AI), trim, and organize clean audio samples from YouTube for live-coding setup in any tool (e.g. Sonic Pi).

---

## 📌 Overview

Preparing speech samples from copyright-free archival footage, news broadcasts, speeches etc., from YouTube often involves a tedious multi-step process: downloading videos, stripping background music/broadcast stings, trimming audio in a bulky DAW, and manually converting files.

This lightweight shell utility collapses that entire workflow into a **single terminal command**. It handles downloading, runs Meta's open-source **Demucs AI** model locally to isolate clean vocals/speech, cuts precise timestamps via **FFmpeg**, and exports a Sonic Pi-ready `.wav` file into your sample library.

---

## 🛠️ Requirements & Installation

### 1. Install System Dependencies
Ensure you have [Homebrew](https://brew.sh/) installed on your Mac, then run:

```bash
# Install ffmpeg, yt-dlp, and python via Homebrew
brew install ffmpeg yt-dlp python

# Install Python audio dependencies & Demucs AI
pip3 install demucs soundfile
```
Demucs AI (Music Source Separation): [https://github.com/adefossez/demucs](https://github.com/adefossez/demucs)

### 2. Ensure Python Scripts are in your PATH
If your terminal cannot locate demucs after installation, add your local Python binaries to your Zsh configuration:

```bash
echo 'export PATH="$HOME/Library/Python/3.9/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

### 3. Setup the Script
1. Clone or download this repository into your project directory.

2. Make the script executable:

```bash
chmod +x get_sample.sh
```

3. Create your default output sample directory:

```bash
mkdir -p ~/sonic_pi_samples
```

## 🚀 Usage
Run the script by providing the YouTube URL, the start timestamp, the duration, and your preferred sample filename:

```bash
./get_sample.sh "<YOUTUBE_URL>" <START_TIME> <DURATION_SECONDS> <OUTPUT_FILENAME>
```
### 💡 Global Terminal Shortcut (Optional)
To run this command from anywhere on your Mac without navigating to a specific folder:
```bash
echo 'alias get-sample="$HOME/Documents/AG Code/sonic-pi-sample-pipeline/get_sample.sh"' >> ~/.zshrc && source ~/.zshrc
```
Then simply run:
```bash
get-sample "<YOUTUBE_URL>" <START_TIME> <DURATION_SECONDS> <OUTPUT_FILENAME>
```

### Parameters
**YOUTUBE_URL**: The link to the source YouTube video (wrap in quotes).

**START_TIME**: Timestamp to start cutting from (HH:MM:SS or MM:SS).

**DURATION_SECONDS**: Length of the output sample in seconds.

**OUTPUT_FILENAME**: Name of the final .wav file (use underscores, avoid spaces).

### Example

```bash
get_sample "https://www.youtube.com/watch?v=EXAMPLE" 00:01:15 10 parl_speaker_order
```
Gives a clean version of the speech sample from the youtube URL starting from 1min15sec for a duration of 10sec and stores the final sample as parl_speaker_order.wav in sonic_pi_samples folder

## ⚡ What Happens Behind the Scenes
**1. Audio Extraction:** yt-dlp fetches the highest quality lossless/uncompressed audio stream directly from YouTube.

**2. AI Vocal Separation:** demucs runs locally using Meta's HTDemucs neural network model to isolate speech and completely strip background music, news themes, and ambient noise into a dedicated vocals stem.

**3. Precision Trimming:** ffmpeg cuts the clean speech stem based on your exact start time and duration parameters.

**4. Library Export:** The processed .wav file is saved to ~/sonic_pi_samples/ while temporary raw source files are automatically purged.

## 📄 License
MIT License. Free for creative coding, live performances, and research projects.

