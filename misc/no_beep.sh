INPUT_NO_BEEP="set bell-style none"
INPUTRC=~/.inputrc
if [[ $(cat $INPUTRC) == *"$INPUT_NO_BEEP"* ]]; then
  echo "Skip: $INPUTRC already contains \"$INPUT_NO_BEEP\""
else
  echo $INPUT_NO_BEEP >> $INPUTRC
  source $INPUTRC
fi

VIM_VISUALBELL="set visualbell"
VIM_T_VB="set t_vb="
VIMRC=~/.vimrc
if [[ $(cat $VIMRC) == *"$VIM_VISUALBELL"* ]]; then
  echo "Skip: $VIMRC already contains \"$VIM_VISUALBELL\""
else
  echo $VIM_VISUALBELL >> $VIMRC
  source $VIMRC
fi
if [[ $(cat $VIMRC) == *"$VIM_T_VB"* ]]; then
  echo "Skip: $VIMRC already contains \"$VIM_T_VB\""
else
  echo $VIM_T_VB >> $VIMRC
  source $VIMRC
fi
