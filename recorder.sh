#!/bin/bash
# Live FFmpeg recording with essential stats in terminal

OUTDIR=~/Videos #outpud dir for the recorded videos
mkdir -p "$OUTDIR"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
VIDEO_INPUT=:0.0
#audio input souce
#use 
#AUDIO_INPUT=alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_6__source #audio input source
OUTFILE="$OUTDIR/walkthrough_$TIMESTAMP.mkv"

ffmpeg \
  -thread_queue_size 1024 -f x11grab -framerate 30 -video_size 1366x768 -i "$VIDEO_INPUT" \
  -thread_queue_size 512 -f pulse -i "$AUDIO_INPUT" \
  -vaapi_device /dev/dri/renderD128 \
  -vf 'format=nv12,hwupload' \
  -c:v h264_vaapi -qp 8 -profile:v high \
  -c:a aac -b:a 128k \
  -stats \
  "$OUTFILE"
