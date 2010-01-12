" $Id:$

" option settings
set shiftwidth=2
set expandtab
set exrc
set secure
set wildmode=list:longest

set path+=/usr/bin,/usr/local/bin

set tags+=./tags,tags

" load man ftplugins
runtime! ftplugin/man.vim

if has("cscope")
  set cscopeprg=/usr/bin/cscope
  set cscopetagorder=0
  set cscopetag
  set cscopequickfix=s-,c-,d-,i-,t-,e-

  set nocscopeverbose
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
    " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set cscopeverbose

endif

"mappings

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Using 'CTRL-spacebar' then a search type makes the vim window
" split horizontally, with search result displayed in
" the new window.

nmap ss :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap sg :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap sc :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap st :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap se :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap sf :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap si :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap sd :scs find d <C-R>=expand("<cword>")<CR><CR>

" Hitting CTRL-space *twice* before the search type does a vertical
" split instead of a horizontal one

nmap <C-Space><C-Space>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space><C-Space>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

" usually we move to the end of a word to begin editing there
map e ea

map sa :!skiperror<CR>:make<CR>

" save current window, open quickfix window, call make
map sm :write<CR>:cwindow<CR>:make<CR>

" new #include directive by copying a directive and editing the filename 
map sn yypf"lcw

" change #if BLAH to #endif /* BLAH */
map su :substitute ;^#\(if\)\(def\)*\(\s\+\)\(\w\+\)$;#end\1\3/* \4 */;<CR>

" change #ifndef BLAH to #endif /* !BLAH */
map sx :substitute ;^#\(if\)ndef\(\s\+\)\(\w\+\)$;#end\1\2/* !\3 */;<CR>

" sp is mapped in .vim/plugin/putinclude.vim

" grab object filename from a line of make output discarding the rest of the
" line, replace extension with .c, join the result with the line above
map sw :substitute /.*\[\(.*\)\.o\].*/\1.c/<CR>kJ

" sy is mapped in .vim/plugin/yankinclude.vim

" movement commands

" split window and jump to tag under cursor 
map sr ]

" jump to window above
map sj j

" jump to window below
map sk k

" jump to window left
map sl l

" jump to window right
map sh h

" move current window to far left using full height of screen
map sL L
