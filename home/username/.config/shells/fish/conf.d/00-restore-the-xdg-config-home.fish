# Restoring the XDG_CONFIG_HOME that the fish wrapper replaced, so that programs started from fish keep reading ~/.config
if set -q FISH_WRAPPER_XDG_CONFIG_HOME
  if test -n "$FISH_WRAPPER_XDG_CONFIG_HOME"
    set -gx XDG_CONFIG_HOME $FISH_WRAPPER_XDG_CONFIG_HOME
  else
    set -e XDG_CONFIG_HOME
  end

  set -e FISH_WRAPPER_XDG_CONFIG_HOME
else if test "$XDG_CONFIG_HOME" = "$HOME/.config/shells"
  set -gx XDG_CONFIG_HOME $HOME/.config
end
