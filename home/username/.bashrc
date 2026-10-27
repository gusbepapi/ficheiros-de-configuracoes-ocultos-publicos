#
# ~/.bashrc
#

# If not running interactively, doing nothing
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Sourcing the modular shell configuration
if [ -d "$HOME/.config/shells/bash" ];
then
  for module in "$HOME/.config/shells/bash"/*;
  do
    if [ -f "$module" ];
    then
      source "$module"
    fi
  done
  unset module
fi

