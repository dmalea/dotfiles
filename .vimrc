" It's VIM, not VI
set nocompatible

" A tab produces space indentation
set expandtab

set number
set autoindent
set smartindent
set linebreak
set mouse=a
set incsearch
set hlsearch

" Highlight trailing whitespace and lines longer than 80 columns.
highlight WhitespaceEOL ctermbg=DarkYellow guibg=DarkYellow
au InsertEnter * syntax match WhitespaceEOL /\s\+\%#\@<!$/
au InsertLeave * syntax match WhitespaceEOL /\s\+$/

" Enable filetype detection
filetype on

" Optional
" C/C++ programming helpers -- 2 line spaces with 80 col marker
augroup csrc
  au!
  autocmd FileType *      set nocindent smartindent
  autocmd FileType c,cpp  set colorcolumn=80 cindent softtabstop=2 shiftwidth=2
augroup END

" Python programming helpers -- 4 line spaces
augroup pysrc
  au!
  autocmd FileType python set softtabstop=4 shiftwidth=4
augroup END

" CMake files -- from http://www.vtk.org/Wiki/VTK/FAQ#Vim_indentation
augroup filetype
   autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in set tabstop=2 shiftwidth=2 expandtab cinoptions={1s,:0,l1,g0,c0,(0,(s,m1 
   autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in set filetype=cmake
   autocmd BufRead,BufNewFile *.ctest,*.ctest.in set filetype=cmake
augroup END

" Set a few indentation parameters. See the VIM help for cinoptions-values for
" details.  These aren't absolute rules; they're just an approximation of
" common style in LLVM source.
set cinoptions=:0,g0,(0,Ws,l1
" Add and delete spaces in increments of `shiftwidth' for tabs
set smarttab

" Highlight syntax in programming languages
syntax on

" LLVM Makefiles can have names such as Makefile.rules or TEST.nightly.Makefile,
" so it's important to categorize them as such.
augroup filetype
  au! BufRead,BufNewFile *Makefile* set filetype=make
augroup END

" In Makefiles, don't expand tabs to spaces, since we need the actual tabs
autocmd FileType make set noexpandtab

" Useful macros for cleaning up code to conform to LLVM coding guidelines

" Convert all tab characters to two spaces
command! Untab :%s/\t/  /g

" Enable syntax highlighting for LLVM files. To use, copy
" utils/vim/llvm.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

" Enable syntax highlighting for tablegen files. To use, copy
" utils/vim/tablegen.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END

" camelcasemotion
map <silent> w ,w
map <silent> b ,b
map <silent> e ,e

set path=$PWD/**
set exrc

call pathogen#infect()
filetype plugin indent on
