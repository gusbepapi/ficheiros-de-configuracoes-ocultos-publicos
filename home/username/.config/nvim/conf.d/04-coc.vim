" 🇬🇧 Enabling symbol highlight
" 🇵🇹 Ativar o realce do símbolo
" 🇪🇸 Activar el resaltado del símbolo
autocmd CursorHold * silent call CocActionAsync('highlight')

" 🇬🇧 If hidden is not set, TextEdit might fail.
" 🇵🇹 Se oculto não estiver definido, o TextEdit poderá falhar.
" 🇪🇸 Si hidden no está definido, TextEdit podría fallar.
set hidden

" 🇬🇧 Some servers have issues with backup files, see #649
" 🇵🇹 Alguns servidores têm problemas com ficheiros de backup, consulte #649
" 🇪🇸 Algunos servidores tienen problemas con archivos de copia de seguridad, consulte #649
set nobackup
set nowritebackup

" 🇬🇧 Better display for messages
" 🇵🇹 Melhor exibição de mensagens
" 🇪🇸 Mejor visualización de mensajes
set cmdheight=2

" 🇬🇧 Smaller updatetime for CursorHold & CursorHoldI
" 🇵🇹 Menor tempo de atualização para CursorHold & CursorHoldI
" 🇪🇸 Tiempo de actualización más pequeño para CursorHold & CursorHoldI
set updatetime=300

" 🇬🇧 Not giving |ins-completion-menu| messages.
" 🇵🇹 Não dar mensagens de |ins-completion-menu|.
" 🇪🇸 No dar mensajes de |ins-completion-menu|.
set shortmess+=c

" 🇬🇧 Using tab for trigger completion with characters ahead and navigate.
" 🇵🇹 Utilizar a guia para alternar a completação com os caracteres à frente e navegar.
" 🇪🇸 Usar la pestaña para alternar la completação con los caracteres adelante y navegar.

" 🇬🇧 Usar the command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" 🇵🇹 Utilizar o comando ':verbose imap <tab>' para garantir que a guia não seja mapeada por outro plugin.
" 🇪🇸 Usar el comando ':verbose imap <tab>' para asegurarse de que la pestaña no esté mapeada por otro complemento.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 🇬🇧 Using <cr> to confirm snippet
" 🇵🇹 Utilizar <cr> para confirmar o trecho
" 🇪🇸 Usar <cr> para confirmar el fragmento
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
			\"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 🇬🇧 Using <c-space> to trigger completion.
" 🇵🇹 Utilizar <c-space> para acionar a conclusão.
" 🇪🇸 Usar <c-space> para activar la conclusión.
inoremap <silent><expr> <c-space> coc#refresh()

" 🇬🇧 Using <cr> to confirm completion, `<C-g>u` means to break undo chain at current position.
" 🇵🇹 Utilizar <cr> para confirmar a conclusão; `<C-g> u` significa quebrar a corrente na posição atual.
" 🇪🇸 Usar <cr> para confirmar la conclusión; `<C-g> u` significa romper la cadena en la posición actual.

" 🇬🇧 Coc only does snippet and additional edit on confirm.
" 🇵🇹 O CoC apenas faz trechos e edições adicionais na confirmação.
" 🇪🇸 El CoC solo hace fragmentos y ediciones adicionales en la confirmación.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" 🇬🇧 Use `[c` and `]c` to navigate diagnostics
" 🇵🇹 Utilizar `[c` and `]c` para navegar nos diagnósticos
" 🇪🇸 Usar `[c` and `]c` para navegar en los diagnósticos
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" 🇬🇧 Remapping keys for gotos
" 🇵🇹 Remapear as chaves para gotos
" 🇪🇸 Remapear las claves para gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 🇬🇧 Using K to show documentation in preview window
" 🇵🇹 Utilizar K para mostrar a documentação na janela de visualização
" 🇪🇸 Usar K para mostrar la documentación en la ventana de vista previa
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" 🇬🇧 Highlighting symbol under cursor on CursorHold
" 🇵🇹 Realcar o símbolo sob o cursor no CursorHold
" 🇪🇸 Resaltar el símbolo bajo el cursor en CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" 🇬🇧 Remapping for renaming the current word
" 🇵🇹 Remapear para renomear a palavra atual
" 🇪🇸 Remapear para renombrar la palabra actual
nmap <leader>rn <Plug>(coc-rename)

" 🇬🇧 Remapping for format selected region
" 🇵🇹 Remapear para o formato da região selecionada
" 🇪🇸 Remapear para el formato de la región seleccionada
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	" Configurar tipo(s) de arquivos especificado(s) formatexpr.
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	" Atualizar ajuda de assinatura no espaço reservado para salto
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 🇬🇧 Remapping "for do codeAction" of selected region, ex: `<leader>aap` for current paragraph
" 🇵🇹 Remapear "for do codeAction" da região selecionada, ex: `<leader>aap` para o parágrafo atual
" 🇪🇸 Remapear "for do codeAction" de la región seleccionada, ej: `<leader>aap` para el párrafo actual
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" 🇬🇧 Remapping "for do codeAction" of current line
" 🇵🇹 Remapear "for do codeAction" da linha atual
" 🇪🇸 Remapear "for do codeAction" de la línea actual
nmap <leader>ac  <Plug>(coc-codeaction)

" 🇬🇧 Fixing the autofix problem of current line
" 🇵🇹 Corrigir o problema de correção automática da linha atual
" 🇪🇸 Corregir el problema de corrección automática de la línea actual
nmap <leader>qf  <Plug>(coc-fix-current)

" 🇬🇧 Using `:Format` to format current buffer
" 🇵🇹 Utilizar `:Format` para formatar o buffer atual
" 🇪🇸 Usar `:Format` para formatear el búfer actual
command! -nargs=0 Format :call CocAction('format')

" 🇬🇧 Using `:Fold` to fold current buffer
" 🇵🇹 Utilizar `:Fold` para dobrar o buffer atual
" 🇪🇸 Usar `:Fold` para doblar el búfer actual
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" 🇬🇧 Adding diagnostic info for:
" 🇵🇹 Adicione informações de diagnóstico para:
" 🇪🇸 Agregue información de diagnóstico para:
" https://github.com/itchyny/lightline.vim
let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'cocstatus': 'coc#status'
			\ },
			\ }

" 🇬🇧 Using CocList
" 🇵🇹 Utilizar CocList
" 🇪🇸 Usar CocList

" 🇬🇧 Showing all diagnostics
" 🇵🇹 Mostrar todos os diagnósticos
" 🇪🇸 Mostrar todos los diagnósticos
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

" 🇬🇧 Managing extensions
" 🇵🇹 Realizar a gestão extensões
" 🇪🇸 Realizar la gestión de extensiones
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>

" 🇬🇧 Showing commands
" 🇵🇹 Mostrar os comandos
" 🇪🇸 Mostrar los comandos
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>

" 🇬🇧 Finding the symbol of current document
" 🇵🇹 Encontrar o símbolo do documento atual
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" 🇬🇧 Search workspace symbols
" 🇵🇹 Pesquisar símbolos da área de trabalho
" 🇪🇸 Buscar símbolos del área de trabajo
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" 🇬🇧 Doing default action for next item.
" 🇵🇹 Executar a ação padrão para o próximo item.
" 🇪🇸 Ejecutar la acción predeterminada para el siguiente elemento.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>

" 🇬🇧 Do default action for previous item.
" 🇵🇹 Executar a ação padrão para o item anterior.
" 🇪🇸 Ejecutar la acción predeterminada para el elemento anterior.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

" 🇬🇧 Resume latest coc list
" 🇵🇹 Retomar a lista mais recente do COC
" 🇪🇸 Reanudar la lista más reciente del COC
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
