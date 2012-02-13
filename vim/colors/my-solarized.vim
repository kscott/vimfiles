hi clear
if exists("syntax_on")
  syntax reset
endif

"Load the 'base' colorscheme - the one you want to alter
runtime colors/solarized.vim

"Override the name of the base colorscheme with the name of this custom one
let g:colors_name = "my-solarized"

"Clear the colors for any items that you don't like
hi clear Search

"Set up your new & improved colors
hi Search         guifg=fg        guibg=NONE        gui=underline ctermfg=NONE        ctermbg=NONE        cterm=underline

