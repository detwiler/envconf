" $Id$

if !hasmapto('PutInclude')
    nmap <silent> <unique>sp :call <SID>PutInclude()<CR>
endif

function! <SID>PutInclude()
    silent execute "normal O#include \"" . g:includefile . "\""
endfunction

