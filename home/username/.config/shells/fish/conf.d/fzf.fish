set -q FZF_TMUX_HEIGHT; or set -U FZF_TMUX_HEIGHT "40%"
set -q FZF_DEFAULT_OPTS; or set -U FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT"
set -q FZF_LEGACY_KEYBINDINGS; or set -U FZF_LEGACY_KEYBINDINGS 1
set -q FZF_DISABLE_KEYBINDINGS; or set -U FZF_DISABLE_KEYBINDINGS 0
set -q FZF_PREVIEW_FILE_CMD; or set -U FZF_PREVIEW_FILE_CMD "head -n 10"
set -q FZF_PREVIEW_DIR_CMD; or set -U FZF_PREVIEW_DIR_CMD "ls"

function fzf_uninstall -e fzf_uninstall
    # 🇬🇧 Disabled until we figure out a sensible way to ensure user overrides are not erased
    # 🇵🇹 Desativado até que encontremos uma maneira sensata de garantir que as sobrescritas do utilizador não sejam apagadas
    # 🇪🇸 Desactivado hasta que encontremos una manera sensata de garantir que las sobrescritas del usuario no se borren
    
    # set -l _vars (set | command grep -E "^FZF.*\$" | command awk '{print $1;}')
    # for var in $_vars
    #     eval (set -e $var)
    # end
end
