#!/usr/bin/env bash
  dump ">> killing clockette..."
  kill -s KILL "$( cat $PID_FILE )"
  [[ -f "$PID_FILE" ]] && rm -f "$PID_FILE" || fatal "/tmp/clockette.pid not found"
  dump ">> /tmp/clockette.pid deleted."
