#!/usr/bin/env bash

[[ $(pacmd list-sinks | grep "active port\:.*speaker") && \
   $(pacmd list-sinks | grep -e 'output.*headphones.* available\: yes') ]] && \
       pacmd set-sink-port 0 analog-output-headphones
