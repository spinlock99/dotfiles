"set shell=bash\ --login

" vim: foldmethod=marker
syntax on
set nocompatible
filetype off
" always show status bar
set laststatus=2

" Vundle {{{1
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Plugin 'gmarik/vundle'
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
set colorcolumn=120
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

" execute current file
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
let g:rspec_command = "!bin/rspec {spec}"
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
"
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
"
"
"" Vundle / plugins
"set nocompatible
"filetype off
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"Plugin 'gmarik/Vundle.vim'
"Plugin 'tpope/vim-rails'
"Plugin 'tomtom/tcomment_vim'
"Plugin 'kchmck/vim-coffee-script'
"" Plugin 'Valloric/YouCompleteMe'
"Plugin 'tmhedberg/matchit'
"Plugin 'tpope/vim-surround'
"Plugin 'vim-scripts/gitignore'
"Plugin 'rking/ag.vim'
"Plugin 'bling/vim-airline'
"Plugin 'tpope/vim-fugitive'
"Plugin 'AndrewRadev/splitjoin.vim'
"Plugin 'bronson/vim-trailing-whitespace'
"Plugin 'kien/ctrlp.vim'
"Plugin 'ngmy/vim-rubocop'
"call vundle#end()
"filetype plugin indent on
"
"" General environment stuff
"set encoding=utf-8
"syntax enable                        " enable syntax highlighting
"set nomodeline                       " don't allow files to set vim settings
"set hidden                           " allow switching buffers without saving first
"set nostartofline                    " keep cursor column in some situations where vi would jump to 0
"set mouse=a                          " enable mouse in all modes
"set tags=./tags                      " use CTags output
"set omnifunc=syntaxcomplete#Complete " Use omnicompletion
"set clipboard=unnamedplus            " d, y, p use system clipboard
"set ttimeout                         " time out on key codes
"set ttimeoutlen=500                  " ...in half a second
"set scrolloff=2                      " keep 2 lines above and below current line on screen
"set sidescrolloff=10                 " ...and 10 columns left and right
"set display+=lastline                " don't replace last line with @@@ if it doesn't fit
"set autoread                         " automatically re-read file when modified outside of vim
"set fileformats+=mac                 " handle weird line endings
"set grepprg=ag\ --nogroup\ --nocolor " use Ag instead of grep
"
"" Use project settings for rubocop
"let g:vimrubocop_config = 'config/.rubocop.yml'
"
"" CtrlP options
"let g:ctrlp_user_command = 'ag %s -l -S --nocolor --ignore tmp -g ""'
"let g:ctrlp_working_path_mode = 'r'
"let g:ctrlp_use_caching = 0 " ag is fast enough that we don't need this
"
"" Mappings
"let mapleader = " "
"inoremap jk <esc>
"nnoremap ; :
"nnoremap <leader>w :w<cr>
"nnoremap <leader>Q :qa<cr>
"nnoremap <leader><tab> :bnext<cr>
"nnoremap <leader><s-tab> :bprevious<cr>
"nnoremap <leader>W :bdelete<cr>
"nnoremap <leader>o :CtrlPMixed<cr>
"nnoremap <leader>s :Ag -S --ignore tmp --ignore vendor --ignore db --ignore spec ""<left>
"
"" Colors
"set t_Co=16                           " double the colors!!1
"highlight Pmenu ctermfg=0 ctermbg=7
"highlight PmenuSel ctermfg=15 ctermbg=7 cterm=Bold
"highlight Visual ctermbg=8
"if &diff
"  syntax off
"  highlight DiffAdd ctermfg=4 ctermbg=7 cterm=none
"  highlight DiffDelete ctermfg=1 ctermbg=7 cterm=none
"  highlight DiffChange ctermfg=none ctermbg=7 cterm=none
"  highlight DiffText ctermfg=4 ctermbg=7 cterm=none
"end
"
"" Status line
"set laststatus=2                             " always display status line
"set wildmenu                                 " show possible completions of command
"let g:airline_powerline_fonts=1              " use FANCY symbols
"let g:airline#extensions#tabline#enabled = 1 " show open buffers in tab line
"
"" Whitespace
"set nowrap                     " don't wrap lines
"set tabstop=2                  " \t counts for two columns
"set shiftwidth=2               " reindent uses two columns
"set softtabstop=2              " tab key inserts two columns
"set expandtab                  " never insert \t
"set backspace=indent,eol,start " backspace in insert mode goes past these
"set autoindent                 " if no filetype setting, keep indent from previous line
"
"" Search
"set hlsearch   " highlight matches of current search
"set incsearch  " search while typing
"set ignorecase " ignore case in searching
"set smartcase  " ...unless the search is not all lowercase
"
