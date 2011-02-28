" yankinclude.vim

if !hasmapto('YankInclude')
    nmap <silent> <unique>sy :call <SID>YankInclude()<CR>
endif

function! <SID>YankInclude()
    let g:includefile = expand("%:t")
endfunction
