#!/usr/bin/env zsh

##========================================================================================
##                                                                                      ##
##                                        Options                                       ##
##                                        Opções                                        ##
##                                        Opciones                                      ##
##                                                                                      ##
##========================================================================================

autoload -Uz add-zsh-hook               # 🇬🇧 required by some plugins, including ‘zsh-autosuggestions’
#                                         🇵🇹 requerido por alguns plugins, inclusive «zsh-autosuggestions»
#                                         🇪🇸 requerido por algunos plugins, inclusive «zsh-autosuggestions»
autoload -Uz colors && colors           # 🇬🇧 enabling the support for colours hexadecimal codes
#                                         🇵🇹 habilitar o suporte aos códigos hexadecimais de cores
#                                         🇪🇸 habilitar el soporte a los códigos hexadecimales de colores
autoload -Uz vcs_info                   # 🇬🇧 required by icons varied by git status info, or in the case of printing %
#                                         🇵🇹 requerido pelos ícones variados pelas informações do git status, ou no caso de imprimir %
#                                         🇪🇸 requerido por los íconos variados por las informaciones del git status, o en el caso de imprimir %

# 🇬🇧 These six options help your questions when you have difficulties to understand
# 🇵🇹 Estas seis opções ajudam tua dúvida em caso de tua dificuldade de compreender
# 🇪🇸 Estas seis opciones ayudan tu duda en caso de tu dificultad de comprender
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-ip
autoload -Uz run-help-openssl
autoload -Uz run-help-sudo
autoload -Uz run-help-svn

setopt autocd                           # 🇬🇧 Alllowing to change the directories without ‘cd’
#                                         🇵🇹 Permitindo mudar os directórios sem «cd»
#                                         🇪🇸 Permitiendo cambiar los directorios sin «cd»
setopt append_history                   # 🇬🇧 Not overwriting the history file
#                                         🇵🇹 Não sobreescrever o histórico
#                                         🇪🇸 No sobreescribir el historial
setopt auto_menu                        # 🇬🇧 Using automatically the menu completion after the 2nd completion consecutive demand, for example, pressing the tab key repeatedly
#                                         🇵🇹 Utilizar automaticamente a completação do menu após a 2ª solicitação consecutiva de completação, por exemplo, pressionando a tecla «Tab» repetidamente.
#                                         🇪🇸 Utilizar automáticamente la completación del menú después de la 2ª solicitud consecutiva de completación, por ejemplo, presionando la tecla «Tab» repetidamente.
setopt extended_history                 # 🇬🇧 Also recording time and duration of each command
#                                         🇵🇹 Também gravar o tempo e a duração de comandos
#                                         🇪🇸 También grabar el tiempo y la duración de comandos
setopt hist_expire_dups_first           # 🇬🇧 Removing duplicates when mounting the internal history
#                                         🇵🇹 Limpar os duplicados quando montando o «hist» interno
#                                         🇪🇸 Limpiar los duplicados cuando montando el «hist» interno
setopt hist_find_no_dups                # 🇬🇧 Not showing duplicates when searching in the history
#                                         🇵🇹 Não exibir os duplicados durante as pesquisas
#                                         🇪🇸 No exibir los duplicados durante las búsquedas
setopt hist_ignore_dups                 # 🇬🇧 Ignoring consecutive duplicates
#                                         🇵🇹 Ignorar duplicatas consecutiva
#                                         🇪🇸 Ignorar duplicatas consecutiva
setopt hist_ignore_all_dups             # 🇬🇧 Remembering only the only command copy
#                                         🇵🇹 Lembrar-se de apenas uma cópia única do comando
#                                         🇪🇸 Recordar-se de apenas una copia única del comando
setopt hist_reduce_blanks               # 🇬🇧 Removing blank lines from the history
#                                         🇵🇹 Remover espaços em branco supérfluos
#                                         🇪🇸 Remover espacios en blanco supérfluos
setopt hist_save_no_dups                # 🇬🇧 Ommiting the old commands in favour of the new ones
#                                         🇵🇹 Omitir os comandos antigos em favor dos mais novos
#                                         🇪🇸 Omitir los comandos antiguos en favor de los más nuevos
setopt hist_ignore_space                # 🇬🇧 Ignoring the commands that begin with a space
#                                         🇵🇹 Ignorar os comandos que começam com espaço
#                                         🇪🇸 Ignorar los comandos que comienzan con espacio
setopt inc_append_history               # 🇬🇧 To save all the commanda before being executed. Required by history plugins
#                                         🇵🇹 Para salvar todos os comandos antes de serem executados. Requeridos pelos plugins de histórico
#                                         🇪🇸 Para salvar todos los comandos antes de serem ejecutados. Requeridos por los plugins de historial
setopt interactive_comments             # 🇬🇧 Allowing comments in the interactive shells
#                                         🇵🇹 Permitir comentários em shells interativos
#                                         🇪🇸 Permitir comentarios en shells interactivos
setopt no_beep                          # 🇬🇧 No noises or music or beeps
#                                         🇵🇹 Sem barulhos ou música ou bipes
#                                         🇪🇸 Sin ruidos o música o bipes
setopt no_hist_beep                     # 🇬🇧 No noises or music or beeps in the history
#                                         🇵🇹 Sem barulhos ou música ou bipes no histórico
#                                         🇪🇸 Sin ruidos o música o bipes en el historial
setopt no_list_beep                     # 🇬🇧 No noises or music or beeps in the list
#                                         🇵🇹 Sem barulhos ou música ou bipes na lista
#                                         🇪🇸 Sin ruidos o música o bipes en la lista
setopt magic_equal_subst                # 🇬🇧 Expanding the path with style arguments, for example, «foo --bar=/tmp/ba<tab>»
#                                         🇵🇹 Expandindo o caminho com argumentos de estilo, por exemplo, «foo --bar=/tmp/ba<tab>»
#                                         🇪🇸 Expandiendo el camino con argumentos de estilo, por ejemplo, «foo --bar=/tmp/ba<tab>»
setopt notify                           # 🇬🇧 Notifying the status of the background jobs immediately instead of waiting a bit before printing a prize
#                                         🇵🇹 Relatar o estado dos trabalhos em segundo plano imediatamente, em vez de esperar um pouco antes de imprimir um prazo
#                                         🇪🇸 Relatar el estado de los trabajos en segundo plano inmediatamente, en vez de esperar un poco antes de imprimir un plazo
setopt print_eight_bit                  # 🇬🇧 Printing the 8-bit characters litterally in completion lists, etc.
#                                         🇵🇹 Imprimir os caracteres de oito bits literalmente em listas de completação, etc.
#                                         🇪🇸 Imprimir los caracteres de ocho bits literalmente en listas de completación, etc.
setopt print_exit_value                 # 🇬🇧 Printing the programs exit value with an exit status different from zero in the command line in interactive shells.
#                                         🇵🇹 Imprimir o valor de saída dos programas com estado de saída diferente de zero na linha de comando em shells interativos.
#                                         🇪🇸 Imprimir el valor de salida de los programas con estado de salida diferente de cero en la línea de comando en shells interactivos.
setopt prompt_subst                     # 🇬🇧 If defined, the expansion parameter, command substitution and arithmetic expansion are performed in the prompts.
#                                         🇵🇹 Se definido, a expansão do parâmetro, a substituição de comando e a expansão aritmética são executadas nos prompts.
#                                         🇪🇸 Si definido, la expansión del parámetro, la sustitución de comando y la expansión aritmética son ejecutadas en los prompts.
setopt pushd_ignore_dups                # 🇬🇧 Not inseriing many copies of the same directory for directory stack
#                                         🇵🇹 Não inserir várias cópias do mesmo directório para a pilha de directório
#                                         🇪🇸 No insertar muchas copias del mismo directorio para la pila de directorio
setopt share_history                    # 🇬🇧 Sharing the history between multiple shells
#                                         🇵🇹 Partilhar o históirco entre múltiplos shells
#                                         🇪🇸 Compartir el historial entre múltiples shells
setopt transient_rprompt