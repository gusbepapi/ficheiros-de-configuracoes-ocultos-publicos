#!/usr/bin/env zsh

##================##
##                
## 🇬🇧 Aliases  
## 🇵🇹 Aliáses    
## 🇪🇸 Alias  
##                
##================##

# 🇬🇧 Git shorthands
# 🇵🇹 Taquigrafias do git
# 🇪🇸 Taquigrafías de git
alias ga='git add .'
alias gc='git commit'
alias gac='ga && gc'
alias gpl='git pull'
alias gps='git push'

# 🇬🇧 Excellent common list aliases
# 🇵🇹 Óptimos aliáses comuns da lista
# 🇪🇸 Óptimos alias comunes de la lista
alias ls='ls --color=auto'
alias lse='ls_extended -Ih'
alias la='ls -a'
alias ll='ls -la'
alias l='ls'
alias l.="ls -A | egrep '^\.'"
alias llc='colorls -lA --sd'
alias lls="ls $LS_OPTIONS -hFtr"
alias lll="ls $LS_OPTIONS -lAhFtr"

# 🇬🇧 Quick cd aliases
# 🇵🇹 Aliáses rápidos de cd
# 🇪🇸 Alias rápidos de cd
alias cd..='cd ..'
alias pdw="pwd"

# 🇬🇧 Quick aliases of zshmarks
# 🇵🇹 Aliáses rápidos de «zshmarks»
# 🇪🇸 Alias rápidos de «zshmarks»
alias j="jump"
alias b="bookmark"
alias d="deletemark"
alias s="showmarks"

# 🇬🇧 Colouring the grep command output for easy use (great for log files)
# 🇵🇹 Colorizar a saída de comando de grep para a utilização fácil (óptimo para os ficheiros de log)
# 🇪🇸 Colorizar la salida de comando de grep para la utilización fácil (óptimo para los archivos de log)
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# 🇬🇧 Reading output
# 🇵🇹 Saída de leitura
# 🇪🇸 Salida de lectura
alias df='df -h'

# 🇬🇧 Releasing the memory
# 🇵🇹 Liberar a memória
# 🇪🇸 Liberar la memoria
alias livre="free -mt"

# 🇬🇧 Users list
# 🇵🇹 Lista de utilizadores
# 🇪🇸 Lista de usuarios
alias userlist="cut -d: -f1 /etc/passwd"

# 🇬🇧 Unifying the new Xresources settings
# 🇵🇹 Unificar novas configurações de Xresources
# 🇪🇸 Unificar nuevas configuraciones de Xresources
alias merge="xrdb -merge $HOME/.Xresources"

# 🇬🇧 Processors list
# 🇵🇹 Lista de processos
# 🇪🇸 Lista de procesos
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

# 🇬🇧 Adding and updating the new fonts
# 🇵🇹 Aderir e actualizar as novas fontes
# 🇪🇸 Aderir y actualizar las nuevas fuentes
alias fc-update='sudo fc-cache -fv'

# 🇬🇧 Switching between Bash, Fish, Ksh and Zsh
# 🇵🇹 Trocar-se entre Bash, Fish, Ksh e Zsh
# 🇪🇸 Cambiarse entre Bash, Fish, Ksh y Zsh
alias parabash="sudo chsh $USER -s /bin/bash && echo 'Encerre a sessão.'"
alias parafish="sudo chsh $USER -s /bin/fish && echo 'Encerre a sessão.'"
alias paraksh="sudo chsh $USER -s /bin/ksh && echo 'Encerre a sessão.'"
alias parazsh="sudo chsh $USER -s /bin/zsh && echo 'Encerre a sessão.'"

# 🇬🇧 Short Hardware info
# 🇵🇹 Informação curta do hardware
# 🇪🇸 Información corta del hardware
alias hw="hwinfo --short"

# 🇬🇧 Recursively deleting `.DS_Store` files in a selected folder
# 🇵🇹 Excluir recursivamente os ficheiros `.DS_Store` numa pasta seleccionada
# 🇪🇸 Excluir recursivamente los archivos `.DS_Store` en una carpeta seleccionada
alias cleands="find . -type f -name '*.DS_Store' -ls -delete"

# 🇬🇧 Converting with Pygments
# 🇵🇹 Converter com Pygments
# 🇪🇸 Convertir con Pygments
alias ccate="pygmentize -O style=monokai -f 256 -g"

# 🇬🇧 Compiling via XeLaTeX installed by MikTeX
# 🇵🇹 Compilar via XeLaTeX instalado pelo MikTeX
# 🇪🇸 Compilar via XeLaTeX instalado por MikTeX
alias xex="xelatex -synctex=1 -halt-on-error -interaction=nonstopmode -file-line-error --shell-escape"
alias bib="bibtex"

# 🇬🇧 Generate qr code in terminal
# 🇵🇹 Gerar código qr no terminal
# 🇪🇸 Generar código qr en el terminal
alias qrencode='qrencode -t ansiutf8'

# 🇬🇧 zbar output only data
# 🇵🇹 zbar gera apenas dados
# 🇪🇸 zbar genera solo datos
alias zbarimg='zbarimg -q --raw'
alias zbarcam='zbarcam -q --raw'

# 🇬🇧 Colorise useful commands output
# 🇵🇹 Colorir a saída de comandos úteis
# 🇪🇸 Colorir la salida de comandos útiles
alias gbk='grc blkid'
alias gdc='grc docker-compose'
alias gdm='grc docker-machine'
alias gdnf='grc dnf'
alias gdocker='grc docker'
alias gdu='grc du'
alias genv='grc env'
alias gfd='grc fdisk'
alias gfm='grc findmnt'
alias gfree='grc free'
alias gg++='grc g++'
alias ggcc='grc gcc'
alias gid='grc id'
alias giostat=' grc iostat'
alias gip='grc ip'
alias gipconf='{ grc ifconfig'
alias glast='grc last'
alias glsattr='grc lsattr'
alias glsbk='grc lsblk'
alias glsmod='grc lsmod'
alias glspci='grc lspci'
alias gmake='grc make'
alias gmount='grc mount'
alias gmtr='grc mtr'
alias gping='grc ping'
alias gps='grc ps'
alias groute='grc traceroute'
alias gtail='grc tail'
alias gtune='grc tune2fs'
alias gupt='grc uptime'
alias gwdiff='grc wdiff'

##========================================================================================
##                                                                                      ##
##                                         macOS                                        ##
##                                                                                      ##
##========================================================================================

if [[ $OSTYPE = (darwin|freebsd)* ]]; then
  # 🇬🇧 Hiding or showing all desktop icons (useful for the presentations)
  # 🇵🇹 Ocultar ou mostrar todos os ícones da área de trabalho (útil na apresentação)
  # 🇪🇸 Ocultar o mostrar todos los iconos del escritorio (útil en la presentación)
  alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
  alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

  # 🇬🇧 Hiding or showing the hidden files on Finder
  # 🇵🇹 Mostrar ou ocultar ficheiros ocultos no Finder
  # 🇪🇸 Mostrar u ocultar archivos ocultos en Finder
  alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
  alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

  # 🇬🇧 Blocking the screen (when you are away from the computer)
  # 🇵🇹 Bloquear o ecrã (quando estiver ausente do computador)
  # 🇪🇸 Bloquear la pantalla (cuando esté ausente del ordenador)
  alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
fi

##========================================================================================
##                                                                                      ##
##                                       Neofetch                                       ##
##                                                                                      ##
##========================================================================================

