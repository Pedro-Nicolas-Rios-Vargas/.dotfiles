noremap! ñ+ ~
noremap! ñ{ ^
noremap! ñ' \
noremap! ñ} `

nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()
