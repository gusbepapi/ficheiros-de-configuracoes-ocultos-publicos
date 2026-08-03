" 🇬🇧 Changing leader to space
" 🇵🇹 Mudar o líder para o espaço
" 🇪🇸 Cambiar el líder al espacio
nnoremap <SPACE> <Nop>
let mapleader = ' '

" 🇬🇧 Toggling nerdtree
" 🇵🇹 Alternar o nerdtree
" 🇪🇸 Alternar nerdtree
map <silent> <C-t> :NERDTreeToggle<CR>

" 🇬🇧 Markdown preview
" 🇵🇹 Visualização do Markdown
" 🇪🇸 Vista previa de Markdown
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

set splitbelow
set splitright

" 🇬🇧 Moving between buffers
" 🇵🇹 Mover entre buffers
" 🇪🇸 Mover entre buffers
nnoremap <C-N> :bn<CR>
nnoremap <C-B> :bp<CR>

" 🇬🇧 Move between splits
" 🇵🇹 Mover entre divisões
" 🇪🇸 Mover entre divisiones
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 🇬🇧 Enabling mouse
" 🇵🇹 Ativar o rato
" 🇪🇸 Activar el ratón
set mouse=a

" 🇬🇧 Toggling equalalways
" 🇵🇹 Alternar para sempre
" 🇪🇸 Alternar siempre
function ToggleEqual ()
	:set equalalways!
	:set equalalways!
endfunction

nnoremap <leader>= :call ToggleEqual()<CR>

" 🇬🇧 Navigating display lines insted of physical lines
" 🇵🇹 Navegar pelas linhas de exibição em vez de linhas físicas
" 🇪🇸 Navegar por líneas de visualización en lugar de líneas físicas
nnoremap j gj
nnoremap k gk
