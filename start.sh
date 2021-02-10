#!/usr/bin/env bash

# Do an inline sync first, then start the background job
echo "Starting sync..."
back/sync
if [ "$READ_ONLY" != "true" ]; then
  eval "while true; do sleep ${AWS_SYNC_INTERVAL:-60}; back/sync; done &"
  sync_pid=$!
fi

echo "Iniciando bot"
eval "screen -L -h 2048 -dmS bot npm start"
main_pid=$!

# Flush the logfile every second, and ensure that the logfile exists
screen -X "logfile 1" && sleep 1

echo "Tailing log"
eval "tail -f screenlog.0 &"
tail_pid=$!