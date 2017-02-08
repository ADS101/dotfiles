execute pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syn on se title
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
"Allow saving while sudo!"
cmap w!! w !sudo tee > /dev/null %
