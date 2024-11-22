
INPUT_NO_BEEP="set bell-style none"
INPUTRC=~/.inputrc
if [[ $(cat $INPUTRC) == *"$INPUT_NO_BEEP"* ]]; then
  echo "Skip: $INPUTRC already contains \"$INPUT_NO_BEEP\""
else
  echo $INPUT_NO_BEEP >> $INPUTRC
  source $INPUTRC
fi

TMUX_ESCAPE_TIME=""
TMUX_CONF=~/.tmux/conf
