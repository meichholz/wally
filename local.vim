" source devsupport/vim/local_gem.vim
" try to use the generic rake plugin
let g:make_target="run:gui"
nmap <F10> :w!<CR>:execute ":make ".g:make_target<CR>

" echo "locally reloaded!"


