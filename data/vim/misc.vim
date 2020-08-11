" custom.vim

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
