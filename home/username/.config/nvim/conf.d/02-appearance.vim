" 🇬🇧 Seting colourscheme
" 🇵🇹 Definir as cores
" 🇪🇸 Definir el esquema de colores
colorscheme onedark

" 🇬🇧 Floating window transparency
" 🇵🇹 Transparência da janela flutuante
" 🇪🇸 Transparencia de la ventana flotante
set winblend=10

" 🇬🇧 Enabling italics
" 🇵🇹 Ativar o itálico
" 🇪🇸 Activar el itálico
let g:onedark_terminal_italics=1

" 🇬🇧 Disabling built-in statusline because airline shows it
" 🇵🇹 Desactivar a linha de status interna porque a companhia aérea mostra
" 🇪🇸 Desactivar la línea de estado interna porque la aerolínea la muestra
set noshowmode

" 🇬🇧 Airline
" 🇵🇹 CIA aérea
" 🇪🇸 Aerolínea
set laststatus=2
set encoding=utf-8
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_warning = ''
let g:airline_section_error = ''
let g:airline_theme='onedark'

" 🇬🇧 True colour support
" 🇵🇹 Suporte de cores verdadeiras
" 🇪🇸 Soporte de colores verdaderos
set termguicolors

" 🇬🇧 Line numbering
" 🇵🇹 Numeração de linha
" 🇪🇸 Numeración de línea
set relativenumber
set number

" 🇬🇧 Always showing signcolumn
" 🇵🇹 Mostrar sempre a coluna do sinal
" 🇪🇸 Mostrar siempre la columna de la señal
set signcolumn=yes

" 🇬🇧 Autoindent and syntax highlight
" 🇵🇹 Autoindetação e realce de sintaxe
" 🇪🇸 Autoindenta y resaltado de sintaxis
set autoindent
set smartindent
syntax on
filetype on
filetype plugin indent on
set tabstop=4
set shiftwidth=4

" 🇬🇧 Make gutter and cursorline bg transparent
" 🇵🇹 Tornar o fundo da garjeta e da linha do cursor transparente
" 🇪🇸 Hacer el fondo de la tarjeta y la línea del cursor transparente
highlight CursorLineNr 			guibg=transparent
highlight SignColumn 			  guibg=transparent

" 🇬🇧 Don't wrap in the middle of words
" 🇵🇹 Não enroles no meio das palavras
" 🇪🇸 No enrollar en medio de las palabras
set linebreak
