#!/usr/bin/env zsh

##================##
##                
## 🇬🇧 Variables  
## 🇵🇹 Variáveis    
## 🇪🇸 Variables  
##                
##================##

# 🇬🇧 Commands history
# 🇵🇹 Histórico de comandos
# 🇪🇸 Historial de comandos
HIST_STAMPS="dd/mm/yyyy"
HISTFILE=$HOME/.zshrc_history
HISTSIZE=2000
SAVEHIST=2000
export HIST_STAMPS="dd/mm/yyyy"
export HISTFILE=$HOME/.zshrc_history
export HISTSIZE=2000
export SAVEHIST=2000

# 🇬🇧 ZSH settings
# 🇵🇹 Configurações do ZSH
# 🇪🇸 Configuraciones de ZSH
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="false"
HYPHEN_INSENSITIVE="true"
export CASE_SENSITIVE="true"
export COMPLETION_WAITING_DOTS="true"
export DISABLE_AUTO_UPDATE="true"
export DISABLE_UPDATE_PROMPT="true"
export ENABLE_CORRECTION="false"
export HYPHEN_INSENSITIVE="true"

# 🇬🇧 User-defined common ENV variables 
# 🇵🇹 Variáveis ENV comuns definidos pelo utilizador
# 🇪🇸 Variables ENV comunes definidas por el usuario

# Editor
PREFERRED_EDITOR="micro"

case $PREFERRED_EDITOR in
"nvim")
  export EDITOR="nvim"
  ;;
"vim")
  export EDITOR="vim"
  ;;
"micro")
  export EDITOR="micro"
  ;;
*)
  export EDITOR="nano"
  ;;
esac

# 🇬🇧 Less, for example, to view git log page
# 🇵🇹 Less, por exmeplo, visualizar a página de git log
# 🇪🇸 Less, por ejemplo, para ver la página de git log
PREFERRED_PAGER="grc less"

case $PREFERRED_PAGER in
"nvimpage")
  export PAGER="nvimpager -p"
  ;;
"grc less")
  export PAGER="grc less"
  ;;
*)
  export PAGER="less"
  ;;
esac

export COLORTERM="truecolor"
export SHELL="$(which zsh)"
export TERM="xterm-256color"

export LANG="pt_PT.utf8"
export LANGUAGE="pt_PT:pt_BR:en"
export LC_ALL="pt_PT.UTF-8"

vscode=$(command -v code)

if [[ -x "$vscode" ]]; then
    export VISUAL="code"
else
    export VISUAL="code-insiders"
fi

##========================================================================================
##                                                                                      ##
##                         Scripts folders exports                                      ##
##                         Exportações de pastas de executáveis                         ##
##                         Exportaciones de carpetas de ejecutables                     ##
##                                                                                      ##
##========================================================================================

#.NET
if [ -d $HOME/.dotnet ]; then
  export PATH="$HOME/.dotnet:$PATH"
fi

# Cargo
if [ -d $HOME/.cargo ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Go
if [ -d $HOME/.go ]; then
  export GOPATH=~/.go
  export PATH="$HOME/.go/bin:$PATH"
fi

# Homebrew
if [ -d /home/linuxbrew ]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Java
homebrew=$(command -v brew)

if [[ -x $homebrew ]]; then
  java08() { export PATH="/home/linuxbrew/.linuxbrew/opt/openjdk@8/bin:$PATH" }
  java11() { export PATH="/home/linuxbrew/.linuxbrew/opt/openjdk@11/bin:$PATH" }
  java17() { export PATH="/home/linuxbrew/.linuxbrew/opt/openjdk@17/bin:$PATH" }
  java18() { export PATH="/home/linuxbrew/.linuxbrew/opt/openjdk@18/bin:$PATH" }
else
  java08() { export PATH="$HOME/.adoptium/jdk/jdk-08/bin:$PATH" }
  java11() { export PATH="$HOME/.adoptium/jdk/jdk-11/bin:$PATH" }
  java17() { export PATH="$HOME/.adoptium/jdk/jdk-17/bin:$PATH" }
  java18() { export PATH="$HOME/.adoptium/jdk/jdk-18/bin:$PATH" }
fi

java18

# Julia
if [ -d $HOME/.julia-bin/bin ]; then
    export PATH="$HOME/.julia-bin/bin:$PATH"
fi

# Kotlin
if [ -d $HOME/.sdkman ]; then
  export PATH="$HOME/.sdkman/bin:$PATH"
  export PATH="$HOME/.sdkman/candidates/kotlin/current/bin:$PATH"
fi

# MikTeX
if [ -d /opt/miktex ]; then
    export PATH="/opt/miktex/bin:$PATH"
fi

export MIKTEX_USERCONFIG=$HOME/.miktex/texmfs/config
export MIKTEX_USERDATA=$HOME/.miktex/texmfs/data
export MIKTEX_USERINSTALL=$HOME/.miktex/texmfs/install

# NPM
if [ -d "$HOME/node_modules/.bin" ]; then
  export PATH="$HOME/node_modules/.bin:$PATH"
else
  export PATH="$HOME/.node_modules/.bin:$PATH"
fi

# NVM
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# Ruby
if [ -d "$HOME/.rbenv/bin" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
  eval "$(rbenv init -)"

  # 🇬🇧 Indexing Colorls
  # 🇵🇹 Indexação do Colorls
  # 🇪🇸 Indexación del Colorls
  if [[ -x $(command -v colorls) ]]; then
    source $(dirname $(gem which colorls))/tab_complete.sh
  else
    echo "Inexistente" &>/dev/null;
  fi
elif [ -d "$HOME/.rvm/scripts/rvm" ]; then
  source $HOME/.rvm/scripts/rvm
else
  if [ -d "$HOME/.local/share/gem/ruby" ]; then
    export PATH="$HOME/.rvm/rubies/default/bin:$PATH"
    export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
    export PATH="$PATH:$GEM_HOME/bin"

    # 🇬🇧 Indexing Colorls
    # 🇵🇹 Indexação do Colorls
    # 🇪🇸 Indexación del Colorls
    if [[ -x $(command -v colorls) ]]; then
      source $(dirname $(gem which colorls))/tab_complete.sh
    else
      echo "Inexistente" &>/dev/null;
    fi
  fi
fi

# Yarn
if [ -d $HOME/.yarn/bin ]; then
    export PATH="$HOME/.yarn/bin:$PATH"
fi

# 🇬🇧 Main local executables
# 🇵🇹 Executáveis locais principais
# 🇪🇸 Ejecutables locales principales
if [[ $OSTYPE = (darwin|freebsd)* ]]; then
    [ -d "/opt/local/bin" ] && export PATH="/opt/local/bin:$PATH"
fi

if [[ $OSTYPE = (linux)* ]]; then
    if [ -d "$HOME/.local/bin" ]; then
      export PATH="$HOME/.local/bin:$PATH"
    fi

    # Linuxbrew (Homebrew)
    if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
      eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    fi

    if [ -d "/usr/local/bin" ]; then
      export PATH="/usr/local/sbin:$PATH"
    fi
fi

# 🇬🇧 ls colours options variables
# 🇵🇹 Variáveis de opções de cores de ls
# 🇪🇸 Variables de opciones de colores de ls
if [[ $OSTYPE = (darwin|freebsd)* ]]; then
    export CLICOLOR=true
    export LSCOLORS='exfxcxdxbxGxDxabagacad'
fi

if [[ $OSTYPE = (linux)* ]]; then
    export LS_OPTIONS='--color=auto'
fi

# FZF
## 🇬🇧 Searching the plugins and sourcing them
## 🇵🇹 A localizar os complementos e obtê-los
## 🇪🇸 Buscando los complementos y obteniéndolos
[ -f $HOME/.asdf/asdf.sh ] && . $HOME/.asdf/asdf.sh
[ -f $HOME/.asdf/completions/asdf.bash ] && . $HOME/.asdf/completions/asdf.bash
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

## 🇬🇧 FZF user-redefined settings
## 🇵🇹 Configurações do FZF redefinidas pelo utilizador
## 🇪🇸 Configuraciones del FZF redefinidas por el usuario
export FZF_ALT_C_COMMAND='rg --hidden --files --null --sort path 2>/dev/null | xargs -0 dirname | uniq'
export FZF_COMPLETION_TRIGGER='**'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "/usr/bin/cat {} | nvimpager -c "'
export FZF_DEFAULT_COMMAND='rg --files --hidden 2>/dev/null'
export FZF_DEFAULT_OPTS='-m --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all'

# 🇬🇧 Using lesspipe with less
# 🇵🇹 Utilizar lesspipe com less
# 🇪🇸 Usar lesspipe con less
lesspipe=$(command -v lesspipe.sh)

if [[ -x $lesspipe ]]; then
  export LESSOPEN="|lesspipe.sh %s"
fi

thf=$(command -v thefuck)

if [[ -x $thf ]]; then
  eval $(thefuck --alias)
fi

drc=$(command -v dircolors)

if [[ -x $drc ]]; then
  eval `dircolors ~/.dircolors`
fi