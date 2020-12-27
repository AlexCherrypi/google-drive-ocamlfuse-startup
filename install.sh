#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
  echo "Sorry, you need to run this as root"
  exit
fi

sudo apt update && \
sudo apt install software-properties-common wget && \
sudo add-apt-repository ppa:alessandro-strada/ppa -y && \
sudo apt update && \
sudo apt install google-drive-ocamlfuse && \
sudo mkdir -p /usr/local/bin && \
cd /usr/local/bin && \
sudo wget https://raw.githubusercontent.com/Knallbertlp/google-drive-ocamlfuse-startup/master/google-drive-ocamlfuse-startup.sh -O google-drive-ocamlfuse-startup.sh && \
sudo chmod 0755 google-drive-ocamlfuse-startup.sh && \
sudo mkdir -p /etc/systemd/user/ && \
cd /etc/systemd/user/ && \
sudo wget https://raw.githubusercontent.com/Knallbertlp/google-drive-ocamlfuse-startup/master/google-drive-ocamlfuse-startup.service -O google-drive-ocamlfuse-startup.service && \
sudo chmod 0644 google-drive-ocamlfuse-startup.service && \
sudo systemctl --global enable google-drive-ocamlfuse-startup.service && \
sudo systemctl --user start google-drive-ocamlfuse-startup.service
