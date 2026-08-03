" 🇬🇧 Enabling Python support
" 🇵🇹 Ativar suporte ao Python
" 🇪🇸 Habilitar el soporte de Python
let g:python3_host_prog='/usr/bin/python3'
let pyxversion=3

" 🇬🇧 Using suda by default
" 🇵🇹 Utilizar suda por padrão
" 🇪🇸 Usar suda por defecto
let g:suda_smart_edit = 1

" 🇬🇧 Remapping exit terminal mode to Esc
" 🇵🇹 Remapear o modo de saída do terminal para Esc
" 🇪🇸 Remapear el modo de salida del terminal a Esc
au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>

" 🇬🇧 Using system clipboard
" 🇵🇹 Utilizar área de transferência do sistema
" 🇪🇸 Usar portapapeles del sistema
set clipboard=unnamedplus

" 🇬🇧 Removing extra line
" 🇵🇹 Remover a linha extra
" 🇪🇸 Eliminar la línea extra
set cmdheight=1

" 🇬🇧 Disabling autocommenting
" 🇵🇹 Desativar o comentário automático
" 🇪🇸 Desactivar el comentario automático
set formatoptions-=cro

" 🇬🇧 Seting pandoc preview program
" 🇵🇹 Definir o programa de visualização de Pandoc
" 🇪🇸 Definir el programa de vista previa de Pandoc
let g:pandoc_preview_pdf_cmd = "zathura"

" 🇬🇧 Case insensitive search
" 🇵🇹 Pesquisa sem distinção entre maiúsculas e minúsculas
" 🇪🇸 Búsqueda sin distinción entre mayúsculas y minúsculas
set ignorecase
set smartcase

" 🇬🇧 Nerdtree settings
" 🇵🇹 Configurações do Nerdtree
" 🇪🇸 Configuraciones de Nerdtree
let NERDTreeMinimalUI = 1 "remove press ? for help"
let NERDTreeAutoDeleteBuffer = 1 " delete buffer when file is deleted
let NERDTreeQuitOnOpen = 1 " close nerdtree when opening file
let NERDTreeDirArrows = 1

" 🇬🇧 Firenvim filetypes
" 🇵🇹 Tipos de ficheiros de Firenvim
" 🇪🇸 Tipos de archivos de Firenvim
au BufEnter github.com_*.txt set filetype=markdown
au BufEnter gitlab.com_*.txt set filetype=markdown
au BufEnter git.reekynet.com_*.txt set filetype=markdown
au BufEnter www.reddit.com_*.txt set filetype=markdown
au BufEnter node.reekynet.com_*.txt set filetype=json
