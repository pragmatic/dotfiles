" VIMRC

" CONFIGURATION {{{

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase   " case-sensitive if expresson contains a capital letter

" turn hybrid line numbers on
" set number norelativenumber
set number

set viminfo=!,'100,<1000,s200,h

set wildmenu
set wildoptions=pum

" SPACING
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set backspace=indent,eol,start
" set list listchars=tab:\ \ ,precedes:<,extends:>,trail:\
set wrap
set pastetoggle=<F12>

set fillchars=vert:│

set diffopt+=vertical

" Jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" }}}

""" FUNCTIONS

" Removes trailing spaces
map <F6> :StripWhitespace<CR>

" Toggle line numbers from none at all
" to relative numbering with current line number
" noremap <F3> :set invnumber invrelativenumber<CR>
noremap <F3> :set invnumber<CR>

noremap > :norm .<CR>

" osc52.vim {{{
" Sends default register to terminal TTY using OSC 52 escape sequence
function! Osc52Yank()
    let buffer=system('base64 | tr -d "\n"', @0)
    let buffer='\033]52;c;'.buffer.'\033\'
    silent exe "!echo -ne ".shellescape(buffer).
        \ " > ".(exists('g:tty') ? shellescape(g:tty) : '/dev/tty')
endfunction

" Like Osc52Yank, except send all the contents to a single line
" TODO: Figure out how to do this more cleanly.
function! Osc52YankOneLine()
  let @"=substitute(@", '\n', '', 'g')
  call Osc52Yank() | redraw!
endfunction

" Automatically call OSC52 function on yank to sync register with host clipboard
augroup Yank
  autocmd!
  autocmd TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
augroup END
" }}}

" Automatically source .vimrc on save
augroup Vimrc
  autocmd!
  autocmd! bufwritepost .vimrc source %
augroup END

" " Automatic toggling between 'hybrid' and absolute line numbers
" augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
"   autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
" augroup END


""" COLOURS

colorscheme inatick

if has("gui_running")
    if has("macunix")
        set guifont=Iosevka\ Fixed:h14
    else
        set guifont=JetBrains\ Mono:h12
    endif

    set guioptions-=T
    set columns=160
    set lines=64

    set guicursor=a:block-Cursor-blinkwait500-blinkoff500-blinkon500

    set fullscreen

    set guioptions-=r " Removes right hand scroll bar

    " This sets the matched listchars characters (tabs and trailing whitespace)
    " highlight SpecialKey    term=reverse    cterm=reverse   ctermfg=254         ctermbg=black   gui=reverse         guifg=#E9E9E9   guibg=Black
else
    " highlight SpecialKey    term=reverse    cterm=reverse   ctermfg=235         ctermbg=black   gui=reverse         guifg=#262626   guibg=Black
endif

if has('python3_dynamic')
endif

""" PLUGINS
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'

" Plug 'hashivim/vim-terraform'
let g:terraform_fmt_on_save=1
let g:terraform_binary_path="tofu"

Plug 'godlygeek/tabular'

Plug 'tpope/vim-commentary'         " Comment stuff out

Plug 'dense-analysis/ale' " Check syntax asynchronously and fix files, with Language Server Protocol (LSP) support
let g:ale_virtualtext_cursor = 'current'
let g:ale_virtualtext_cursor = 'disabled'

Plug 'tpope/vim-fugitive'           " Vim plugin for Git
" Plug 'pearofducks/ansible-vim'      " A vim plugin for syntax highlighting Ansible's common filetypes
augroup ansible_vim_ftyaml_ansible
    autocmd!
    autocmd BufRead,BufNewFile */plays_*/*.yml          set filetype=yaml.ansible
    autocmd BufRead,BufNewFile */plays_*/hosts          set filetype=ansible_hosts
    autocmd BufRead,BufNewFile */ansible/roles*/*.yml   set filetype=yaml.ansible
augroup END

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  " Go development plugin for Vim

Plug 'vim-airline/vim-airline'                      " lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = "powerlineish"

Plug 'preservim/tagbar'                             " Vim plugin that displays tags in a window, ordered by scope
let g:tagbar_autoshowtag = 1
let g:tagbar_sort = 0
let g:tagbar_singleclick = 1

let g:tagbar_type_ansible = {
    \ 'ctagstype' : 'ansible',
    \ 'kinds' : [
        \ 't:tasks',
        \ 'h:hosts'
    \ ],
    \ 'sort' : 0
\ }

let g:tagbar_type_terraform = {
    \ 'ctagstype' : 'terraform',
    \ 'kinds' : [
        \ 'r:resources',
        \ 'm:modules',
        \ 'o:outputs',
        \ 'v:variables',
        \ 'f:tfvars',
        \ 'd:data'
    \ ],
    \ 'sort' : 0
\ }
nmap <F8> :TagbarToggle<CR>

Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }

Plug 'christoomey/vim-tmux-navigator'

Plug 'ntpeters/vim-better-whitespace'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'jgerry/terraform-vim-folding'

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Initialize plugin system
call plug#end()

