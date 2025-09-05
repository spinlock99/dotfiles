set belloff=all

"workaround for NERDTree Bug
let g:NERDTreeNodeDelimiter = "\u00a0"

set nocompatible
filetype off

" Vundle {{{1
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" tpope
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
" Grep
Plugin 'rking/ag.vim'
" tags
Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
"Plugin 'lukaszkorecki/coffeetags'
" html5
Plugin 'othree/html5.vim'
" Ember
Plugin 'kchmck/vim-coffee-script'
Plugin 'elzr/vim-json'
Plugin 'joukevandermaas/vim-ember-hbs'
" rspec and mocha!
"Plugin 'spinlock99/vim-spec'
Plugin 'geekjuice/vim-spec'
" rename
Plugin 'danro/rename.vim'
"nerdtree
Plugin 'scrooloose/nerdtree'
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
" Typescript
Plugin 'leafgarland/typescript-vim.git'
Plugin 'Quramy/tsuquyomi.git'
Plugin 'Shougo/vimproc.vim'
Plugin 'Quramy/vim-js-pretty-template'
Plugin 'jason0x43/vim-js-indent'
Plugin 'ianks/vim-tsx'
" javascript
"Plugin 'jelera/vim-javascript-syntax'S
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
" solarized
Plugin 'altercation/vim-colors-solarized'
" elixir
Plugin 'elixir-editors/vim-elixir'
Plugin 'c-brenn/phoenix.vim'
Plugin 'benmills/vimux'
Plugin 'gravityblast/vimux-elixir'
Plugin 'spiegela/vimix'
" ruby
Plugin 'ngmy/vim-rubocop'

call vundle#end()
filetype plugin indent on
autocmd BufNewFile,BufRead *.slim set filetype=slim

autocmd BufNewFile  *.jsx	0r ~/vim/skeleton.jsx

" set preferences {{{1
syntax enable
let g:solarized_termcolors=256
set t_Co=256
colorscheme solarized
set background=dark
" always show status bar
set laststatus=2
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
execute "set colorcolumn=" . join(range(80,120), ',')
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
set linebreak
set nolist
" bash-like tab completion
set wildmode=longest,list,full
set wildmenu
" keep 10 lines visible on top and bottom
set scrolloff=10
" make backspace work
set backspace=start
" don't put backup files in with the source
"set backupdir=$TMPDIR//
"set directory=$TMPDIR//
"}}}

" Custom Key Bindings to move between windows {{{
map <c-h> <c-w>h
map <c-l> <C-W>l
set wmh=0
map <c-j> <C-W>j<C-W>_
map <c-k> <C-W>k<C-W>_
" open the current split all the way
map <c-o> :res 100<CR>
"}}}

" quick run for a project. leader leader will be a task that the current
" project needs.
" Current Quick Key: Fork Equity - add to cart test
"nnoremap <leader><leader> :!yarn run add_to_cart --domain=notifications.myshopify.com  --path=/tmp/add-to-cart.png --productTitle='8.5 x 11 Full Color Brochures'<Enter>
nnoremap <leader><leader> :!mix test --max-failures 1 --seed 0 %<Enter>

" reload .vimrc
nnoremap <leader>v :source ~/.vimrc<Enter>

" execute current file
nnoremap <leader>e :!%:p<Enter>
nnoremap <leader>R :!%:p<space>

" run RuboCop
nnoremap <leader>r :RuboCop<Enter>
" run mocha
nnoremap <leader>m :!/usr/local/bin/mocha<Enter>

" execute coffeescript file
nnoremap <leader>c :!coffee %:p -n<Enter>

" add ruby highlighting to arbre files
au BufNewFile,BufRead *.arb set filetype=ruby

" add elixir highlighting to heex files
au BufRead,BufNewFile *.heex set filetype=eelixir

" highlight trailing whitespace {{{
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
:highlight ExtraWhitespace ctermbg=red guibg=red
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:au InsertLeave * match ExtraWhitespace /\s\+$/
"}}}
filetype plugin indent on     " required!

" rspec and mocha setup {{{
let g:rspec_command = "!NODE_ENV=test bundle exec rspec --format documentation {spec}"
let g:mocha_coffee_command = "!mocha {spec}"
let g:mocha_js_command = "!NODE_PATH=app/javascript/components/ time $(yarn bin)/mocha spec/javascript/setup.js {spec}"
let g:mocha_debug_command = "!NODE_PATH=./frontend $(yarn bin)/mocha debug --require ./frontend/tests/mocha.js {spec}"

" Rspec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
" TODO: reinstall my fork of vim-spec
"map <Leader>s :call RunNearestSpec(0)<CR>
map <Leader>s :call RunNearestSpec(0)<CR>
map <Leader>d :call RunNearestSpec(1)<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
"}}}

" generate swagger.json from integration specs
map <Leader>sw :Rake rswag:specs:swaggerize<CR>

map <Leader>w :!source '/Users/dixon/.nvm/nvm.sh'; nvm use 0.12; npm test -- config.js<Enter>
map <Leader>y :!yarn run add_to_cart<Enter>

" Open vertical split with identical configuration to parent
function! AwesomeSplit()
  :let savex=winsaveview()
  vsplit
  :call winrestview(savex)
endfunction

nnoremap <Leader>vs :call AwesomeSplit()<CR>

"" Use the system clipboard {{{
"" For Ubuntu
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

"" For OSX
"" Use pbcopy with visual mode -syntax on
"set nocompatible
"
"vmap <C-x> :!pbcopy<CR>
"vmap <C-c> :w !pbcopy<CR><CR>
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

" Wrap Text in QuickFix Window
augroup quickfix
  autocmd!
  autocmd FileType qf setlocal wrap
augroup END

" Automatically open the quickfix window after grep (including Ggrep)
" autocmd QuickFixCmdPost *grep* cwindow
