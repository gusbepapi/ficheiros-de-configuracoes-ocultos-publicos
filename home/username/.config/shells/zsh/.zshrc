#
# ~/.zshrc
#

# If not running interactively, doing nothing
[[ $- != *i* ]] && return

# Sourcing the modular shell configuration, in alphabetical order
if [ -d "$HOME/.config/shells/zsh" ];
then
  for module in "$HOME/.config/shells/zsh"/*(N.);
  do
    source "$module"
  done
  unset module
fi
