" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
" hi clear Normal
hi clear
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "inatick"

" vim: sw=2
" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Ron Aaron <ron@ronware.org>
" Last Change:	2003 May 02

set background=dark
set t_Co=256
hi Normal		guifg=#C7C7C7 guibg=Black
hi Visual ctermfg=0   ctermbg=74   gui=bold        guifg=#070F19   guibg=#B9F63F

hi Comment      term=none       cterm=none      ctermfg=240             gui=none        guifg=#535353
hi Constant     term=underline                  ctermfg=167                             guifg=#D75F5F
hi Special                                      ctermfg=169                             guifg=#D75FAF
hi Identifier   term=underline  cterm=none      ctermfg=80                              guifg=#5FD7D7
hi Statement    term=none                       ctermfg=185             gui=none        guifg=#D7D75F
hi Type         term=underline                  ctermfg=77              gui=none        guifg=#64D565
hi Underlined   term=underline  cterm=underline ctermfg=169             gui=underline   guifg=#D338D3
hi Ignore                                       ctermfg=7                               guifg=bg
hi Error        term=reverse                    ctermfg=185   ctermbg=1                   guifg=#F4F4F4   guibg=#C23621

hi perlSubname                                  ctermfg=2                               guifg=#25BC24

" hi SpecialKey   term=bold                                                               guifg=#492EE1
hi NonText      term=bold                                               gui=bold        guifg=#5F87D7
hi Directory    term=bold                                                               guifg=#5F87D7
hi! link SpecialKey Directory

hi CursorLine                                   ctermfg=0   ctermbg=6   gui=bold        guifg=#070F19   guibg=#33BBC8

hi Pmenu                                        ctermbg=236 ctermfg=38                  guifg=#00BFDD   guibg=#3F3F3F
hi PmenuSel                                     ctermbg=38  ctermfg=237                 guifg=#3F3F3F   guibg=#00BFDD
hi PmenuSbar                                    ctermbg=237 ctermfg=38                  guifg=#3F3F3F   guibg=#00BFDD
hi PmenuThumb                                   ctermbg=38  ctermfg=237                 guifg=#3F3F3F   guibg=#00BFDD

" hi link goExtraType Identifier
" hi link goMethod    Type

" Used when using Gblame and NERDTree
highlight VertSplit    term=none    cterm=none   ctermfg=235         gui=none         guifg=#262626

" Fix the gaudy default colours when using vimdiff
highlight DiffAdd       term=reverse    cterm=none      ctermbg=darkgreen   ctermfg=black   gui=none            guifg=#25BC24   guibg=Black
highlight DiffChange    term=reverse    cterm=none      ctermbg=darkcyan    ctermfg=black   gui=none            guifg=#22BBC8   guibg=Black
highlight DiffText      term=reverse    cterm=none      ctermbg=darkgray    ctermfg=black   gui=none            guifg=#CBCCCD   guibg=Black
highlight DiffDelete    term=reverse    cterm=none      ctermbg=darkred     ctermfg=black   gui=none            guifg=#C23621   guibg=Black

highlight DiffAdd       term=reverse    cterm=none      ctermbg=108   ctermfg=22   gui=none            guifg=#25BC24   guibg=Black
highlight DiffChange    term=reverse    cterm=none      ctermbg=138   ctermfg=black   gui=none            guifg=#22BBC8   guibg=Black
highlight DiffText      term=reverse    cterm=none      ctermbg=131   ctermfg=black   gui=none            guifg=#CBCCCD   guibg=Black
highlight DiffDelete    term=reverse    cterm=none      ctermbg=131   ctermfg=131   gui=none            guifg=#C23621   guibg=Black

highlight Title         term=bold       cterm=bold      ctermfg=darkmagenta                 gui=bold            guifg=#C930C7
highlight SpellBad      term=reverse                    ctermbg=darkred                     gui=undercurl       guisp=#FC391F

highlight Todo          term=reverse    cterm=bold,reverse ctermfg=166      ctermbg=16      gui=reverse         guifg=#D75F00   guibg=Black
highlight PreProc       term=underline                  ctermfg=darkmagenta                 gui=none            guifg=#D338D3

highlight Cursor		guifg=#FF2B8F   guibg=#FB3B98
highlight Folded                                        ctermfg=70          guifg=#5FAF00   guibg=NONE
hi! link Folded String

highlight Search        term=reverse    cterm=bold      ctermfg=16          ctermbg=11      gui=bold            guifg=Black     guibg=#FFFC67
highlight MatchParen    term=reverse    cterm=bold      ctermfg=16          ctermbg=148     gui=bold            guifg=black     guibg=#B0D52B

hi! link LineNr SpecialKey
" But don't highlight the tabs in Go files
autocmd FileType go hi clear SpecialKey

" hi LineNr                                   ctermfg=237 ctermbg=233 guifg=#3A3A3A   guibg=#121212
hi LineNr                                   ctermfg=238 ctermbg=233 guifg=#444444   guibg=#121212
" hi LineNrAbove                              ctermfg=239 ctermbg=233 guifg=#626262   guibg=#121212
" hi! link LineNrBelow LineNrAbove
hi SignColumn                               ctermfg=237 ctermbg=233 guifg=#3A3A3A   guibg=#121212

hi SyntasticWarningSign         cterm=bold  ctermfg=3   ctermbg=233 guifg=#C7C400   guibg=#121212
hi SyntasticErrorSign           cterm=bold  ctermfg=16  ctermbg=160 guifg=Black     guibg=#D71E00
hi SyntasticStyleWarningSign    cterm=bold  ctermfg=3   ctermbg=233 guifg=#C7C400   guibg=#121212
hi SyntasticStyleErrorSign      cterm=bold  ctermfg=16  ctermbg=233 guifg=Black     guibg=#121212

hi clear WarningMsg
hi! link WarningMsg SyntasticWarningSign

hi GitGutterAdd                             ctermfg=2   ctermbg=233 guifg=#00C200   guibg=#121212
hi GitGutterChange                          ctermfg=3   ctermbg=233 guifg=#C7C400   guibg=#121212
hi GitGutterDelete                          ctermfg=1   ctermbg=233 guifg=#C91B00   guibg=#121212
hi GitGutterChangeDelete                    ctermbg=233

hi ALEWarning ctermbg=19 guibg=#021FAF

"    white          #F4F4F4
" 30 black          #000000
" 31 darkred        #C23621
" 32 darkgreen      #25BC24
" 33 darkyellow     #ADAD27
" 34 darkblue       #492EE1
" 35 darkmagenta    #D338D3
" 36 darkcyan       #33BBC8
" 37 gray           #CBCCCD

" 40 darkgray       #818383
" 41 red            #FC391F
" 42 green          #31E722
" 43 yellow         #FFFC67
" 44 blue           #5833FF
" 45 magenta        #F935F8
" 46 cyan           #14F0F0
" 47 white          #E9EBEB
