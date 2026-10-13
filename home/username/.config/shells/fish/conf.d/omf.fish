# 🇬🇧 Path to Oh My Fish install
# 🇵🇹 Caminho para a instalação do Oh My Fish
# 🇪🇸 Ruta a la instalación de Oh My Fish

set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# 🇬🇧 To load Oh My Fish configuration.
# 🇵🇹 Carregar a configuração do Oh My Fish.
# 🇪🇸 Cargar la configuración de Oh My Fish.
source $OMF_PATH/init.fish
