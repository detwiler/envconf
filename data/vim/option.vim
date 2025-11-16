"" option.vim

set autowrite
set path+=/usr/bin,/usr/local/bin
set secure
set tags+=./tags,tags
set wildmode=list:longest

" Linux Kernel
set tabstop=8
set shiftwidth=8
set noexpandtab
set cindent
" disable indentation for labels
set cinoptions=:0
set listchars=tab:>-,trail:·

if has('termguicolors')
    set termguicolors
endif

colorscheme desert
