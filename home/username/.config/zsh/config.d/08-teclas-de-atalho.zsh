#!/usr/bin/env zsh

##========================================================================================
##                                                                                      ##
##                                   Keybindings                                        ##
##                                   Teclas de atalho                                   ##
##                                   Atajos de teclado                                  ##
##                                                                                      ##
##========================================================================================

# 🇬🇧 Fixing the home and end keys killed in a brutal, savage, unprincipled, uncivilised and treacherous form by Emacs or Vim
# 🇵🇹 Corrigir as teclas «Home» e «End» assassinadas «brutalmente, selvagemente, sem princípios, incivilizadamente, traiçoeiramente pelo Emacs/Vim
# 🇪🇸 Corregir las teclas «Home» y «End» asesinadas «brutalmente, salvajemente, sin principios, incivilizadamente, traicioneramente por Emacs/Vim
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

bindkey '^[[1;4D' insert-cycledleft
bindkey '^[[1;4C' insert-cycledright

# 🇬🇧 Key timeout and strings
# 🇵🇹 Tempo de limite da tecla e sequências de caracteres
# 🇪🇸 Tiempo de límite de la tecla y secuencias de caracteres
KEYTIMEOUT=1
WORDCHARS='*?_-[]~=./&;!#$%^(){}<>'