" 🇬🇧 Auto-install vim-plug
" 🇵🇹 Instalação automática do vim-plug
" 🇪🇸 Instalación automática de vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif             

" 🇬🇧 Set COC extensions
" 🇵🇹 Definir extensões do COC
" 🇪🇸 Definir extensiones del COC
let g:coc_global_extensions = [
			\ 'coc-css',
			\ 'coc-dictionary',
			\ 'coc-explorer',
			\ 'coc-emmet',
			\ 'coc-emoji',
			\ 'coc-go',
			\ 'coc-html',
			\ 'coc-json',
			\ 'coc-markdownlint',
			\ 'coc-marketplace',
			\ 'coc-prettier',
			\ 'coc-python',
			\ 'coc-rust-analyzer',
			\ 'coc-snippets',
			\ 'coc-syntax',
			\ 'coc-tag',
			\ 'coc-texlab',
			\ 'coc-tsserver',
			\ 'coc-yaml',
			\ ]

call plug#begin()

" 🇬🇧 Statusline or tabline
" 🇵🇹 Linha de status ou linha de tabulação
" 🇪🇸 Línea de estado o línea de pestaña
Plug 'vim-airline/vim-airline'

" 🇬🇧 Make editing passwords safer
" 🇵🇹 Tornar a edição de palavra-passe mais segura
" 🇪🇸 Hacer que la edición de contraseñas sea más segura
Plug 'https://git.zx2c4.com/password-store', { 'rtp': 'contrib/vim/redact_pass.vim' }

" 🇬🇧 Colourise colour words
" 🇵🇹 Colorir as cores das palavras
" 🇪🇸 Colorear las palabras de color
Plug 'norcalli/nvim-colorizer.lua'

" 🇬🇧 Spelling
" 🇵🇹 Soletração
" 🇪🇸 Ortografía
Plug 'vim-scripts/Vimchant'

" 🇬🇧 Pandoc plugins
" 🇵🇹 Plugins do pandoc
" 🇪🇸 Plugins de pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'conornewton/vim-pandoc-markdown-preview'

" 🇬🇧 Fuzzy finder
" 🇵🇹 Localizador difuso
" 🇪🇸 Localizador difuso
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" 🇬🇧 Language syntax pack
" 🇵🇹 Pacote de sintaxe de idioma
" 🇪🇸 Paquete de sintaxis de idioma
Plug 'sheerun/vim-polyglot'

" 🇬🇧 Read editorconfig settings
" 🇵🇹 Leia as configurações do editorconfig
" 🇪🇸 Leer la configuración del editorconfig
Plug 'editorconfig/editorconfig-vim'

" 🇬🇧 Make directory if it doesn't exist
" 🇵🇹 Criar o diretório se ele não existir
" 🇪🇸 Crear el directorio si no existe
Plug 'pbrisbin/vim-mkdir'

" 🇬🇧 Tree explorer
" 🇵🇹 Explorador de árvore
" 🇪🇸 Explorador de árbol
Plug 'scrooloose/nerdtree'

" 🇬🇧 Moar snippets
" 🇵🇹 Trechos de Moar
" 🇪🇸 Fragmentos de Moar
Plug 'honza/vim-snippets'

" 🇬🇧 Filetype icons
" 🇵🇹 Ícones de tipo de ficheiro
" 🇪🇸 Iconos de tipo de archivo
Plug 'ryanoasis/vim-devicons'

" 🇬🇧 Surround stuff with brackets and quotes 
" 🇵🇹 Cercar a coisa com colchetes e aspas
" 🇪🇸 Cercar la cosa con corchetes y comillas
Plug 'tpope/vim-surround'

" 🇬🇧 Do stuff as sudo
" 🇵🇹 Fazer coisas como sudo
" 🇪🇸 Hacer cosas como sudo
Plug 'lambdalisue/suda.vim'

" 🇬🇧 Conguer of Completion
" 🇵🇹 Conguer da Completação
" 🇪🇸 Conguer de la Completación
Pl🇵ug 'neoclide/coc.nvim', {'branch': 'release'}

" 🇬🇧 VimL source for CoC
" 🇵🇹 Fonte do VimL para CoC
" 🇪🇸 Fuente de VimL para CoC
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'

" 🇬🇧 Git plugin
" 🇵🇹 Plugin do git
" 🇪🇸 Plugin de git
Plug 'jreybert/vimagit'

" 🇬🇧 Git diff in gutter
" 🇵🇹 Diferença de git na sarjeta
" 🇪🇸 Diferencia de git en la acera
Plug 'airblade/vim-gitgutter'

" 🇬🇧 GPG support
" 🇵🇹 Suporte ao GPG
" 🇪🇸 Soporte de GPG
Plug 'jamessan/vim-gnupg'

" 🇬🇧 Colourscheme
" 🇵🇹 Esquema de cores
" 🇪🇸 Esquema de colores
Plug 'joshdick/onedark.vim'

" 🇬🇧 LaTeX plugin
" 🇵🇹 Plugin do LaTex
" 🇪🇸 Plugin de LaTeX
Plug 'lervag/vimtex'

call plug#end()
