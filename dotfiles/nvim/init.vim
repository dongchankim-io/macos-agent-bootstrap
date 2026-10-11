" ~/.config/nvim/init.vim
" Lightweight, zero-plugin Neovim configuration

" Enable file type detection
filetype on

" Ignore capital letters during search (unless uppercase is used)
set ignorecase
set smartcase

" Incrementally highlight matching characters while typing a search
set incsearch

" Highlight search matches
set hlsearch

" Command history size
set history=1000

" Indentation: 4 spaces, expand tabs to spaces
set expandtab
set tabstop=4
set shiftwidth=4

" Show line numbers on the left
set number

" Enable syntax highlighting
syntax on

" Highlight the current line horizontally
set cursorline

" Configure invisible character symbols (toggle with :set list)
set listchars=tab:▸·,trail:·,nbsp:␣

" Colorscheme
colorscheme industry

" Soft wrap long lines
set wrap
