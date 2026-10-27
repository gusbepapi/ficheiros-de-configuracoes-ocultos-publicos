#!/usr/bin/env zsh

##========================================================================================
##                                                                                      ##
##                                        Plugins                                       ##
##                                                                                      ##
##========================================================================================

# ----------------------------------------------------------------------------------------
# 🇬🇧 Plugins for all the platforms
# 🇵🇹 Plugins para todas as plataformas
# 🇪🇸 Plugins para todas las plataformas
# ----------------------------------------------------------------------------------------

##──── 🇬🇧 Personalisation
##──── 🇵🇹 Personalização
##──── 🇪🇸 Personalización

## 🇬🇧 Theme
## 🇵🇹 Tema
## 🇪🇸 Tema
znap source powerlevel10k

znap prompt &>/dev/null
znap source zpm-zsh/colors colors.plugin.zsh

# 🇬🇧 Enabling the highlighting syntax on the terminal
# 🇵🇹 Activar o realce de sintaxe no terminal
# 🇪🇸 Activar el resaltado de sintaxis en el terminal
znap source zsh-users/zsh-syntax-highlighting
znap source zdharma-continuum/fast-syntax-highlighting

# 🇬🇧 Beautiful files difference highlighting syntax on the terminal
# 🇵🇹 Bonito realce de sintaxe de diferenças de ficheiros no terminal
# 🇪🇸 Bonito resaltado de sintaxis de diferencias de archivos en el terminal
znap source zdharma-continuum/zsh-diff-so-fancy

# 🇬🇧 Graphic user interface
# 🇵🇹 Interface gráfica de utilizador
# 🇪🇸 Interfaz gráfica de usuario
znap source zdharma-continuum/zui

# 🇬🇧 Autocompletations
# 🇵🇹 Autocompletações
# 🇪🇸 Autocompletaciones
# znap source marlonrichert/zsh-autocomplete (not recommended / não recomendado)
znap source zsh-users/zsh-autosuggestions

##──── 🇬🇧 History
##──── 🇵🇹 Histórico
##──── 🇪🇸 Histórico

## 🇬🇧 Listing the history through the wanted word indication
## 🇵🇹 Listar o histórico por meio da indicação da palavra desjada
## 🇪🇸 Listar el histórico por medio de la indicación de la palabra deseada
znap source larkery/zsh-histdb

### 🇬🇧 Listing the wanted word to find quickly in the directories history, for example, ‘z -l adwaita’, and to jump quickly to the directory, ‘z adwaita’
### 🇵🇹 Listar a palavra desejada para achar rapidamente no histórico de directórios, por exemplo, «z -l adwaita», e para pular rapidamente para o directório, «z adwaita»
### 🇪🇸 Listar la palabra deseada para encontrar rápidamente en el histórico de directorios, por ejemplo, «z -l adwaita», y para saltar rápidamente al directorio, «z adwaita»
znap source ohmyzsh/ohmyzsh plugins/z

## 🇬🇧 Pressing Ctrl + R to show up the quick historic list of commands with enabled highlighting syntax
## 🇵🇹 Primir Ctrl + R para exibir a lista histórica rápida de comandos com realce de sintaxe activado
## 🇪🇸 Pulsar Ctrl + R para mostrar la lista histórica rápida de comandos con resaltado de sintaxis activado
znap source zdharma-continuum/history-search-multi-word

## 🇬🇧 Search history
## 🇵🇹 Histórico de pesquisa
znap source zsh-users/zsh-history-substring-search

## 🇬🇧 Invoking all the admin- and user-defined environment variables, pressing Ctrl + B
## 🇵🇹 Invocar todas as variáveis do ambiente do administrator e do utilizador, primindo Ctrl + B
## 🇪🇸 Invocar todas las variables del ambiente del administrador y del usuario, pulsando Ctrl + B
znap source zdharma-continuum/zbrowse

##──── 🇬🇧 Directories
##──── 🇵🇹 Directórios
##──── 🇪🇸 Directorios

## 🇬🇧 Favourites list to save and jump quickly
## 🇵🇹 Lista de favoritos para marcar e pular de forma rápida
## 🇪🇸 Lista de favoritos para marcar y saltar de forma rápida
znap source jocelynmallon/zshmarks

## 🇬🇧 Returning to the previous directory or advcancing to the next directory with the quick command Ctrl + Shift + Left/Right
## 🇵🇹 Retornar para o directório precendente ou prosseguir para o próximo directório por comando rápido do Ctrl + Shift + Left/Right
## 🇪🇸 Retornar al directorio anterior o avanzar al siguiente directorio por comando rápido del Ctrl + Shift + Left/Right
znap source ohmyzsh/ohmyzsh plugins/dircycle

## 🇬🇧 Listing quickly by alphabetical order, or by date or size, more efficiently than the default ‘ls’ command
## 🇵🇹 Listar rapidamente por ordem alfabética, ou da data ou do tamanho, mais eficiente que o comando padrão «ls»
## 🇪🇸 Listar rápidamente por orden alfabético, o por fecha o tamaño, más eficiente que el comando por defecto «ls»
znap source supercrabtree/k

## 🇬🇧 Returning quickly to the previous directory with the command ‘bd’ + number of previous directories or with the tab key
## 🇵🇹 Retornar rapidamente ao directório anterior ao executar «bd» + números de directórios anteriores ou com o botão tab
## 🇪🇸 Retornar rápidamente al directorio anterior al ejecutar «bd» + números de directorios anteriores o con la tecla tab
znap source tarrasch/zsh-bd

##──── 🇬🇧 Mfzf e peco wonders
##──── 🇵🇹 Maravilhas de fzf e peco
##──── 🇪🇸 Maravillas de fzf y peco

# znap source junegunn/fz
# znap source peco/peco

## 🇬🇧 Viewingthe git graphic user interface as if it were fzf
## 🇵🇹 Visualizar a interface gráfica do git como se fosse fzf
## 🇪🇸 Visualizar la interfaz gráfica del git como si fuera fzf
znap source wfxr/forgit

## 🇬🇧 Using the tab key to run the command ‘fzf’
## 🇵🇹 Utilizar o botão «tab» para executar o comando «fzf»
## 🇪🇸 Utilizar la tecla «tab» para ejecutar el comando «fzf»
znap source Aloxaf/fzf-tab

##──── 🇬🇧 Aliases
##──── 🇵🇹 Aliáses
##──── 🇪🇸 Alias
znap prompt

znap source ohmyzsh/ohmyzsh lib/functions.zsh

## 🇬🇧 Copying automatically and quickly the absolute path of the directory when running the command ‘copydir’
## 🇵🇹 Copiar automática e rapidamente o caminho absoluto do directório ao executar o «copydir»
## 🇪🇸 Copiar automáticamente y rápidamente la ruta absoluta del directorio al ejecutar el «copydir»
znap source ohmyzsh/ohmyzsh lib/clipboard.zsh
znap source ohmyzsh/ohmyzsh plugins/copydir

## 🇬🇧 Setting rsunc quickly, preservating the permissions when running the command ‘cpv’
## 🇵🇹 Aplicar o rysnc rapidamente, preservando as permissões ao executar «cpv»
## 🇪🇸 Aplicar el rysnc rápidamente, preservando los permisos al ejecutar «cpv»
znap source ohmyzsh/ohmyzsh plugins/cp

## 🇬🇧 Encrypting and decrypting the text or files in base64
## 🇵🇹 Codificar e decodificar o texto ou o ficheiro em base64
## 🇪🇸 Codificar y decodificar el texto o el fichero en base64
znap source ohmyzsh/ohmyzsh plugins/encode64

## 🇬🇧 The only alias “extract” to extract quickly the file regardless of the format
## 🇵🇹 O único aliás «extract» para extrair rapidamente o ficheiro independentemente do formato
## 🇪🇸 El único alias «extract» para extraer rápidamente el fichero independientemente del formato
znap source ohmyzsh/ohmyzsh plugins/extract

## 🇬🇧 Quick git commands aliases
## 🇵🇹 Aliáses rápidos dos comandos do git
## 🇪🇸 Alias rápidos de los comandos del git
znap source ohmyzsh/ohmyzsh plugins/git

## 🇬🇧 Quick go commands aliases
## 🇵🇹 Aliáses rápidos dos comandos do go
## 🇪🇸 Alias rápidos de los comandos del go
znap source ohmyzsh/ohmyzsh plugins/golang

## 🇬🇧 Quick npm commands aliases
## 🇵🇹 Aliáses rápidos dos comandos do npm
## 🇪🇸 Alias rápidos de los comandos del npm
znap source ohmyzsh/ohmyzsh plugins/npm

## 🇬🇧 Preffixing easily your current or previous commands with sudo, pressing ‘esc’ twice
## 🇵🇹 Prefixar facilmente seus comandos atuais ou anteriores com sudo pressionando «esc» duas vezes
## 🇪🇸 Prefijar fácilmente sus comandos actuales o anteriores con sudo presionando «esc» dos veces
znap source ohmyzsh/ohmyzsh plugins/sudo

## 🇬🇧 Quick systemctl commands aliases
## 🇵🇹 Aliáses rápidos dos comandos do systemctl 
## 🇪🇸 Alias rápidos de los comandos del systemctl
znap source ohmyzsh/ohmyzsh plugins/systemd

## 🇬🇧 Quick URLs encoding and decoding conversion aliases
## 🇵🇹 Aliáses rápidos de conversão de codificação e descodificação dos URLs
## 🇪🇸 Alias rápidos de conversión de codificación y descodificación de los URLs
znap source ohmyzsh/ohmyzsh plugins/urltools

## 🇬🇧 Aliases for searching quickly any word with your favourite dictionarie, encyclopaedias or search engines while opening the browser. 
## 🇵🇹 Aliáses para pesquisar rapidamente qualquer palavra com teus dicionários favoritos, tuas enciclopeedias favoritas ou teus mecanismos de busca, ao abrir o navegador. 
## 🇪🇸 Alias para buscar rápidamente cualquier palabra con tus diccionarios favoritos, tus enciclopedias favoritas o tus mecanismos de búsqueda, al abrir el navegador.
znap source ohmyzsh/ohmyzsh plugins/web-search

## 🇬🇧 Quick Docker commands aliases
## 🇵🇹 Aliáses rápidos dos comandos do Docker
znap source tcnksm/docker-alias zshrc

# ----------------------------------------------------------------------------------------
# 🇬🇧 Plugins only for Linux
# 🇵🇹 Plugins apenas para Linux
# 🇪🇸 Plugins solo para Linux
# ----------------------------------------------------------------------------------------

if [[ $OSTYPE = (linux)* ]]; then
  znap prompt &>/dev/null
  () 
  {
    local -a plugins=( 
        ${commands[apt]:+debian} 
        ${commands[apt]:+ubuntu} 
        ${commands[dnf]:+dnf} 
        ${commands[pacman]:+archlinux} 
        ${commands[suse]:+suse} 
        ${commands[systemd]:+systemd} 
    )
    znap source ohmyzsh/ohmyzsh plugins/$^plugins
  }
fi

# ----------------------------------------------------------------------------------------
# 🇬🇧 Plugins only for macOS
# 🇵🇹 Plugins apenas para macOS
# 🇪🇸 Plugins solo para macOS
# ----------------------------------------------------------------------------------------

if [[ $OSTYPE = (darwin)* ]]; then
  znap prompt &>/dev/null
  () 
  {
    local -a plugins=( 
        ${commands[brew]:+brew} 
        ${commands[port]:+macports}
        ${commands[swift]:+swiftpm}
        macos
        xcode
    )
    znap source ohmyzsh/ohmyzsh plugins/$^plugins
  }
fi

