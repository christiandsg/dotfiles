" === Style
set number
set hlsearch
set textwidth=0
set wrapmargin=0

" Shifts are two spaces
set shiftwidth=2

" No tabs, a tab is 2 spaces
set expandtab
set tabstop=2
set smarttab

" No Swap file
set noswapfile

" === Coding related
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" === Automatic actions
" Removing unnecessary whitespaces
autocmd BufWritePre *.py,*.js,*.rb :call <SID>StripTrailingWhitespaces()

" === Functions
" Tyding up whitespaces
" source: http://vimcasts.org/episodes/tidying-whitespace/
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
