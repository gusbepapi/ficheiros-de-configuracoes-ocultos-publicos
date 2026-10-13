# Sourcing the numbered modules of the modular shell configuration, in alphabetical order
# Only the files whose names start with two digits are modules, because the folder also holds the fish files
# Fish globs do not support character classes, so the names are filtered with `string match`
if status is-interactive
  for module in (path sort (string match -r -- '.*/[0-9][0-9]-[^/]*$' $HOME/.config/shells/fish/*))
    if test -f $module
      source $module
    end
  end
end
