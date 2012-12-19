" set up pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim

if exists("g:loaded_pathogen")
  call pathogen#infect()
endif
