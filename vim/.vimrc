" ==============================================================================
" ~/.vimrc - Lightweight Minimal IDE (Native Vim, No External Plugins Needed)
" Mirrored from Neovim setup (Keymaps, Netrw Tree, Options)
" ==============================================================================

" --- Leader Key ---
let mapleader = " "
let maplocalleader = " "

" --- General Settings ---
set nocompatible
filetype plugin indent on
syntax on
set encoding=utf-8
set fileencoding=utf-8
set noswapfile
set nobackup
set undofile
if !isdirectory(expand('~/.vim/undo'))
    silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
endif
set undodir=~/.vim/undo

" --- Clipboard ---
set clipboard=unnamedplus

" --- Indentation (2 spaces like Neovim) ---
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set shiftround
set autoindent
set smartindent

" --- UI Settings ---
set number
set relativenumber
set cursorline
set nowrap
set scrolloff=10
set laststatus=2
set showcmd
set ruler
set wildmenu
set wildmode=longest:full,full
set mouse=a
set termguicolors
set background=dark
silent! colorscheme desert

" --- Search Settings ---
set incsearch
set ignorecase
set smartcase
set showmatch
set hlsearch

" --- Backspace & History ---
set backspace=indent,eol,start
set history=1000
set autowrite

" ==============================================================================
" Native File Explorer (Netrw as File Tree / Neo-tree equivalent)
" ==============================================================================
let g:netrw_banner = 0             " Sembunyikan banner help netrw
let g:netrw_liststyle = 3          " Tree view style
let g:netrw_browse_split = 4       " Buka file di window sebelumnya
let g:netrw_altv = 1               " Buka split ke kanan
let g:netrw_winsize = 25           " Lebar panel tree (25%)
let g:netrw_list_hide = '^\./\$,^\.\./\$'
let g:netrw_hide = 0               " Tampilkan hidden files

" Toggle Native File Tree with <leader>e / <C-e>
function! ToggleNetrw()
    let l:found = 0
    for w in range(1, winnr('$'))
        if getbufvar(winbufnr(w), '&filetype') ==# 'netrw'
            let l:found = 1
            execute w . 'wincmd c'
            break
        endif
    endfor
    if !l:found
        execute 'Vexplore'
    endif
endfunction

" ==============================================================================
" Keymaps (Disamakan 100% dengan Neovim Kamu)
" ==============================================================================

" Escape mode
inoremap jj <Esc>
vnoremap jk <Esc>

" Save & Quit
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a
nnoremap <leader>q :q<CR>

" File Tree Toggle (mirip Neo-tree <leader>e)
nnoremap <silent> <leader>e :call ToggleNetrw()<CR>
nnoremap <silent> <C-e> :call ToggleNetrw()<CR>

" Buffer Navigation & Management (Next, Prev, Close)
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprev<CR>
nnoremap <leader>x :bdelete<CR>
nnoremap <leader>b :ls<CR>:b<Space>

" Clear Search Highlight
nnoremap <silent> <Esc> :nohlsearch<CR>

" Window Navigation (Ctrl + h/j/k/l)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Window Splits (<leader>sv, <leader>sh, <leader>se, <leader>sx)
nnoremap <leader>sv <C-w>v
nnoremap <leader>sh <C-w>s
nnoremap <leader>se <C-w>=
nnoremap <leader>sx :close<CR>

" File / Find Helper (Native fuzzy-ish file finder via :find)
set path+=**
nnoremap <leader>ff :find<Space>
nnoremap <leader>fg :vimgrep // **/*<Left><Left><Left><Left><Left><Left>

" Terminal Split
if has('terminal')
    nnoremap <leader>t :terminal<CR>
endif
