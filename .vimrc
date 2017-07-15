"
" set runimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/afterno,~/.vim/afterno
set t_Co=256

if (&t_Co == 256 || &t_Co == 88) && !has('gui_running') &&
        \ filereadable(expand("$HOME/.vim/plugin/guicolorscheme.vim"))
    runtime! plugin/guicolorscheme.vim
    GuiColorScheme synthwave
    "GuiColorScheme nucolors
else
    colorscheme synthwave
    "cottonmouse, nucolors and jellybeans are cool
endif

let g:superman_use_Xresources = 1 "rxvt-u-8

set history=1000

set autochdir

syntax on
filetype plugin indent on

nnoremap ' `
nnoremap ` '
set hidden
runtime macros/matchit.vim
set wildmenu
set wildmode=list:longest,full

set backupdir=~/.local/share/vim
set directory=~/.local/share/vim
set nobackup
set nowritebackup
set noswapfile

set nocompatible
set relativenumber
set mouse=r
set showmatch
set ruler
set cursorline

" display current mode, enables partial commands
set showmode
set showcmd

" case-insensitive search, unless caps are involved
set ignorecase
set smartcase

set foldmethod=indent
set foldlevel=99

set shortmess=atI

set autoread

set equalalways

set magic
set so=5

set clipboard=unnamed

" tabs -> spaces
" default 4-space dd
set tabstop=4
set shiftwidth=4
set softtabstop=4
set cindent
set smartindent
set autoindent
set expandtab

set hlsearch
set incsearch

highlight Pmenu ctermbg=238 gui=bold

" width limits
autocmd BufRead /tmp/mutt-* set tw=72 " mutt limit 72 characters

"vertical line at 80th column
set colorcolumn=80

nmap <silent> <leader>s :set nolist!<CR>

autocmd! InsertEnter * set number
autocmd! InsertLeave * set relativenumber

function! NumberToggle()
    if(%relateivenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunction

" autoruns files
set autowrite
command! -buffer W make

autocmd! FileType python set shiftwidth=4 softtabstop=4 tabstop=4 makeprg=python\ %
autocmd! FileType c,cpp set shiftwidth=4 softtabstop=4 tabstop=4 makeprg=make
autocmd! BufNewFile,BufRead PKGBUILD set shiftwidth=2 softtabstop=2 softtabstop=2 tabstop=2 makeprg=makepkg

" indentation only
" no indentation
autocmd! FileType asciidoc set nocindent noautoindent

autocmd! FileType javascript,arduino,html,xhtml,xml,css set shiftwidth=4 softtabstop=4 tabstop=4

autocmd! FileType vhdl set shiftwidth=2 softtabstop=2 tabstop=2

let g:ConqueTerm_PyVersion = 3
let g:ConqueTerm_FaseMode = 0
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_InsertOnEnter = 0
let g:ConqueTerm_CloseOnEnd = 0

"auto-chmod
autocmd BufWritePost * call NoExtNewFile()

function! NoExtNewFile()
    if getline(1) =~ "^#!.*/bin/"
        if &filetype == ""
            filetype detect
        endif
        silent !chmod a+x <afile>
    endif
endfunction

" use temps
autocmd! BufNewFile * call LoadTemplate()

" jump between %VAR% placeholders in Insert mode with <Ctrl-p>
inoremap <C-p> <ESC>/%\u.\{-1,}%<cr>c/%/e<cr>

function! LoadTemplate()
    silent! 0r ~/.vim/skel/tmpl.%:e
    
    " Highlight %VAR% placeholders with the Todo color group
    syn match Todo "%\u\+%" containedIn=ALL
endfunction
