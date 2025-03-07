#!/bin/bash
source libsetup.sh || exit 1

arg=$1
if [[ $arg == "uninstall" ]]; then
  lazyuninstall no_cd
else
  lazyupdate
fi
