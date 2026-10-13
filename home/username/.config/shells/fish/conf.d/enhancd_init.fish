# 🇬🇧 enhancd-fish initialization hook
# 🇵🇹 Inicialização do enhancd-fish
# 🇪🇸 Inicialización de enhancd-fish

# 🇬🇧 You can use the following variables in this file:
# 🇵🇹 Você pode usar as seguintes variáveis neste arquivo:
# 🇪🇸 Puede usar las siguientes variables en este archivo:

## 🇬🇧 package name
## 🇵🇹 nome do pacote
## 🇪🇸 nombre del paquete
# * $package

## 🇬🇧 package path
## 🇵🇹 caminho do pacote
## 🇪🇸 ruta del paquete
# * $path

## 🇬🇧 package dependencies
## 🇵🇹 dependências do pacote
## 🇪🇸 dependencias del paquete
# * $dependencies

# 🇬🇧 Setting the variables
# 🇵🇹 A definir as variáveis
# 🇪🇸 Definiendo las variables
set -gx ENHANCD_FILTER

if ! set -q ENHANCD_COMMAND; set -gx ENHANCD_COMMAND "cd"; end
if ! set -q ENHANCD_ROOT; set -gx ENHANCD_ROOT $path; end
if ! set -q ENHANCD_DIR; set -gx ENHANCD_DIR $HOME/.enhancd; end
if ! set -q ENHANCD_DISABLE_DOT; set -gx ENHANCD_DISABLE_DOT 0; end
if ! set -q ENHANCD_DISABLE_HYPHEN; set -gx ENHANCD_DISABLE_HYPHEN 0; end
if ! set -q ENHANCD_DISABLE_HOME; set -gx ENHANCD_DISABLE_HOME 0; end

if ! set -q ENHANCD_DOT_ARG; set -gx ENHANCD_DOT_ARG ".."; end
if ! set -q ENHANCD_HYPHEN_ARG; set -gx ENHANCD_HYPHEN_ARG "-"; end
if ! set -q ENHANCD_HYPHEN_NUM; set -gx ENHANCD_HYPHEN_NUM 10; end
if ! set -q ENHANCD_HOME_ARG; set -gx ENHANCD_HOME_ARG ""; end
if ! set -q ENHANCD_USE_FUZZY_MATCH; set -gx ENHANCD_USE_FUZZY_MATCH 1; end

if ! set -q ENHANCD_COMPLETION_DEFAULT; set -gx ENHANCD_COMPLETION_DEFAULT 1; end
if ! set -q ENHANCD_COMPLETION_BEHAVIOUR; set -gx ENHANCD_COMPLETION_BEHAVIOUR "default"; end

set -gx ENHANCD_COMPLETION_KEYBIND "^I";

set -gx _ENHANCD_VERSION "2.2.4"
set -gx _ENHANCD_SUCCESS 0
set -gx _ENHANCD_FAILURE 60

# 🇬🇧 Setting the filters if empty
# 🇵🇹 Definir os filtros se estiverem vazios
# 🇪🇸 Definir los filtros si están vacíos
if [ -z "$ENHANCD_FILTER" ]
    set -gx ENHANCD_FILTER "fzy:fzf-tmux:fzf:peco:percol:gof:pick:icepick:sentaku:selecta"
end

# 🇬🇧 Making a log file and a root directory
# 🇵🇹 Criar um ficheiro de registo e um diretório raiz
# 🇪🇸 Crear un archivo de registro y un directorio raíz
if ! [ -d "$ENHANCD_DIR" ]
    mkdir -p "$ENHANCD_DIR"
end

if ! [ -f "$ENHANCD_DIR/enhancd.log" ]
    touch "$ENHANCD_DIR/enhancd.log"
end

# 🇬🇧 Removing bash/zsh sources
# 🇵🇹 Remover as fonets de bash/zsh
# 🇪🇸 Eliminar las fuentes de bash/zsh
if [ -d "$ENHANCD_ROOT/src" ]
    rm -rf "$ENHANCD_ROOT/src"
end

if [ -f "$ENHANCD_ROOT/init.sh" ]
    rm -f "$ENHANCD_ROOT/init.sh"
end

# 🇬🇧 Alias to enhancd
# 🇵🇹 Alias para enhancd
# 🇪🇸 Alias para enhancd
eval "alias $ENHANCD_COMMAND 'enhancd'"