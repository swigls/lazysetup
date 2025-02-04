#!/bin/bash
source libsetup.sh || exit 1

arg=$1
if [[ $arg == "uninstall" ]]; then
  lazyuninstall
else
  lazyupdate
fi
