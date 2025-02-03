#!/bin/bash
source fn.sh || exit 1

## Uninstallation
# UNINSTALL is to be used in some functions
UNINSTALL=1
bash configure/init.sh
bash configure/git.sh
rm -rf "$(installdir)"
