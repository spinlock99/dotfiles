"set shell=bash\ --login

" vim: foldmethod=marker
syntax on
set nocompatible
filetype off
" always show status bar
set laststatus=2

" Vundle {{{1
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Ruby
Plugin 'vim-ruby/vim-ruby'
" Grep
Plugin 'rking/ag.vim'
" tpope
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-dispatch'
" tags
Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
Plugin 'lukaszkorecki/coffeetags'
" html5
Plugin 'othree/html5.vim'
" Ember
Plugin 'kchmck/vim-coffee-script'
"Plugin 'mustache/vim-mustache-handlebars'
Plugin 'joukevandermaas/vim-mustache-handlebars'
Plugin 'heartsentwined/vim-emblem'
Plugin 'elzr/vim-json'
" rspec and mocha!
Plugin 'geekjuice/vim-spec'
" rename
Plugin 'danro/rename.vim'
"nerdtree
Plugin 'scrooloose/nerdtree'
" Stylus
Plugin 'wavded/vim-stylus'
" CSS3
Plugin 'hail2u/vim-css3-syntax'
" vim-scripts
Plugin 'Align'
Plugin 'loremipsum'
" dbext
Plugin 'vim-scripts/dbext.vim'
" slim
Plugin 'slim-template/vim-slim.git'
" CtrlP
Plugin 'kien/ctrlp.vim'
" Rainbow Parentheses
Plugin 'kien/rainbow_parentheses.vim'
" Clojure
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
Plugin 'guns/vim-clojure-highlight'
" Reddit
"Plugin 'joshhartigan/vim-reddit'
autocmd BufNewFile,BufRead *.slim set filetype=slim
"}}}
filetype plugin indent on

" set preferences {{{1
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set colorcolumn=80
set number
set ruler
set spell
"set hlsearch
set showmatch
set incsearch
set ignorecase
set nowrap
set autoindent
set history=1000
set cursorline
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2
set background=dark
"colorscheme wombat
set linebreak
set nolist
" bash-like tab completion
set wildmode=longest,list,full
set wildmenu
" keep 10 lines visible on top and bottom
set scrolloff=10
"}}}

" Custom Key Bindings to move between windows {{{
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
set wmh=0
map <c-j> <C-W>j<C-W>_
map <c-k> <C-W>k<C-W>_
" open the current split all the way
map <c-o> :res 100<CR>
"}}}

"source vimrc
nnoremap <leader>i :source ~/.vimrc<Enter>

" execute current file
nnoremap <leader>x :!%:p<Enter>
nnoremap <leader>r :!%:p<Enter>
nnoremap <leader>R :!%:p<space>

" execute coffeescript file
nnoremap <leader>c :!coffee %:p -n<Enter>

" add ruby highlighting to arbre files
au BufNewFile,BufRead *.arb set filetype=ruby

" highlight trailing whitespace {{{
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
:highlight ExtraWhitespace ctermbg=red guibg=red
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:au InsertLeave * match ExtraWhitespace /\s\+$/
"}}}
filetype plugin indent on     " required!

" rspec and mocha setup {{{
let g:rspec_command = "!zeus rspec {spec}"
let g:mocha_coffee_command = "!mocha {spec}"

" Rspec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
"}}}

map <Leader>w :!source '/Users/dixon/.nvm/nvm.sh'; nvm use 0.12; npm test -- config.js<Enter>

" Open vertical split with identical configuration to parent
function! AwesomeSplit()
  :let savex=winsaveview()
  vsplit
  :call winrestview(savex)
endfunction

nnoremap <Leader>vs :call AwesomeSplit()<CR>

"" Use the system clipboard {{{
"" Use pbcopy with visual mode -syntax on
"set nocompatible
"
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>
"}}}
" YCombinator Kata {{{
function! TennentCorrespondence()
  normal d i->() { pA }.()
endfunction

"command-range TennentRefactor call TennentCorrespondence()
"}}}

" folding
nnoremap <Space> za
vnoremap <Space> za

" Tab in source files
set cindent

ca gd Gdiff<enter>
ca dg diffget<enter>

" Define a command to make it easier to use
command! -nargs=+ QFDo call QFDo(<q-args>)

" " Function that does the work
function! QFDo(command)
  " Create a dictionary so that we can
  " get the list of buffers rather than the
  " list of lines in buffers (easy way
  " to get unique entries)
  let buffer_numbers = {}
  " For each entry, use the buffer number as 
  " a dictionary key (won't get repeats)
  for fixlist_entry in getqflist()
    let buffer_numbers[fixlist_entry['bufnr']] = 1
  endfor
  " Make it into a list as it seems cleaner
  let buffer_number_list = keys(buffer_numbers)

  " For each buffer
  for num in buffer_number_list
    " Select the buffer
    exe 'buffer' num
    " Run the command that's passed as an argument
    exe a:command
    " Save if necessary
    update
  endfor
endfunction
