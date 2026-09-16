#!/bin/bash
# Usage: ./get_sample.sh "YOUTUBE_URL" START_TIME DURATION "CATEGORY_NAME_PHRASE"
# Example: ./get_sample.sh "https://youtube.com/watch?v=123" 00:00:30 10 parl_pm_order
# Check if all required arguments are provided

if [ "$#" -ne 4 ]; then
    echo "❌ Error: Missing parameters!"
    echo "Usage: ./get_sample.sh <YOUTUBE_URL> <START_TIME> <DURATION> <FILENAME>"
    echo "Example: ./get_sample.sh 'https://youtube.com/watch?v=123' 00:01:15 10 parl_speaker_order"
    exit 1
fi

URL=$1
START=$2
DURATION=$3
FILENAME=$4
OUT_DIR="$HOME/Documents/Music/SFX/sonic_pi_samples"

echo "🚀 Step 1: Downloading full raw audio..."
yt-dlp -x --audio-format wav --audio-quality 0 -o "temp_full.wav" "$URL"

echo "✂️ Step 2: Trimming $DURATION-second clip..."
ffmpeg -y -ss "$START" -i temp_full.wav -t "$DURATION" -c:a pcm_s16le temp_clip.wav

echo "🪄 Step 3: Isolating speech from clip with Demucs AI..."
demucs --two-stems=vocals temp_clip.wav

echo "💾 Step 4: Exporting clean sample..."
mkdir -p "$OUT_DIR"
ffmpeg -y -i separated/htdemucs/temp_clip/vocals.wav -ar 44100 -ac 2 -c:a pcm_s16le "$OUT_DIR/${FILENAME}.wav"

echo "🧹 Step 5: Cleaning up..."
rm -rf temp_full.wav temp_clip.wav separated/

echo "✅ SUCCESS! Your clean sample is ready at: $OUT_DIR/${FILENAME}.wav"