" touch-object-file.vim

if !hasmapto('TouchObjectFile')
    nmap <silent> <unique>so :call <SID>TouchObjectFile()<CR>
endif

function! <SID>TouchObjectFile()
    let l:object_file = expand("%:p:r") . ".o"
    execute "!touch -m " . l:object_file
    execute "make"
endfunction

