noremap! ñ+ ~
noremap! ñ{ ^
noremap! ñ' \
noremap! ñ} `

nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()

" let counter = 0
" inoremap <expr> <C-L> ListItem()
" inoremap <expr> <C-R> ListReset()
" 
" func ListItem()
"     let g:counter += 1
"     return g:counter .. '. '
" endfunc
" 
" func ListReset()
"     let g:counter = 0
"     return ''
" endfunc
