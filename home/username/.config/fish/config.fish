# Bridging the default fish location to ~/.config/shells/fish, for a fish started without the wrapper
# The wrapper sets XDG_CONFIG_HOME to ~/.config/shells, and then fish reads ~/.config/shells/fish by itself
if test "$XDG_CONFIG_HOME" != "$HOME/.config/shells"; and test -d $HOME/.config/shells/fish
  set -l shells_fish $HOME/.config/shells/fish

  set -a fish_function_path $shells_fish/functions
  set -a fish_complete_path $shells_fish/completions

  for snippet in $shells_fish/conf.d/*.fish
    source $snippet
  end

  if test -f $shells_fish/config.fish
    source $shells_fish/config.fish
  end
end
