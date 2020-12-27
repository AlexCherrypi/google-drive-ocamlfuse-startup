#!/bin/bash
mkdir -p ~/Google\ Drive/
cd ~
if [ -d "~/.gdfuse" ]; then
  exit 1
fi
for file in ~/.gdfuse/*/  ; do
  local LABEL
  LABEL="$(basename $file)"
  local DIR
  DIR="~/Google\ Drive/Google\ Drive\ $LABEL"
  local SERVICE
  SERVICE="google-drive-ocamlfuse-instance-$LABEL.service"
  unset file
  if [ ! -f "~/.config/systemd/user/$SERVICE" ]; then
    echo "Creating a new systemd service for label $LABEL"
    mkdir -p ~/.config/systemd/user/
    mkdir -p "$DIR"
    cd ~/.config/systemd/user/
    wget https://raw.githubusercontent.com/Knallbertlp/google-drive-ocamlfuse-startup/master/google-drive-ocamlfuse-instance.service -O "$SERVICE"
    chmod 0700 "$SERVICE"
    sed -i "s~LABEL~$LABEL~g" "$SERVICE"
    sed -i "s~DIR~$DIR~g" "$SERVICE"
    systemctl --user enable "$SERVICE"
    systemctl --user start "$SERVICE"
  fi
done

