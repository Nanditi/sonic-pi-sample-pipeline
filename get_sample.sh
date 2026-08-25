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
OUT_DIR="$HOME/sonic_pi_samples"

echo "🚀 Step 1: Downloading raw audio from YouTube..."
yt-dlp -x --audio-format wav --audio-quality 0 -o "temp_raw.wav" "$URL"

echo "🪄 Step 2: Isolating speech & stripping background music/noise..."
demucs --two-stems=vocals temp_raw.wav

echo "✂️ Step 3: Trimming speech sample and saving to $OUT_DIR..."
mkdir -p "$OUT_DIR"
ffmpeg -ss $START -i separated/htdemucs/temp_raw/vocals.wav -t $DURATION -c copy "$OUT_DIR/${FILENAME}.wav"

echo "🧹 Step 4: Cleaning up temporary files..."
rm -rf temp_raw.wav separated/

echo "✅ SUCCESS! Your clean sample is ready at: $OUT_DIR/${FILENAME}.wav"