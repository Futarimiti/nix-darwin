" Quick fuzzy find in pwd, config dir, $VIMRUNTIME and more
cnoremap <C-Space> <NOP>

" file
nnoremap <localleader>f :edit **/
nnoremap <localleader>g :vimgrep  **<Left><Left><Left>
cnoremap <C-Space>f **/
cmap <C-Space><C-F> <C-Space>f

" shipped runtime
nnoremap <localleader>r :edit $VIMRUNTIME/**/
nnoremap <localleader>R :vimgrep  $VIMRUNTIME/**<C-Left><Left>
cnoremap <nowait> <C-Space>r $VIMRUNTIME/**/
cmap <nowait> <C-Space><C-R> <C-Space>r

" scriptnames
nnoremap <localleader>s :scriptnames **/
nnoremap <localleader>S
      \ :vimgrep  `=getscriptinfo()->map({_,f->f.name})`<C-Left><Left>
