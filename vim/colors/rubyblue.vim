" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	John Long <vim@johnwlong.com>
" Last Change:	2005 July
" Based on blue.vim by Steven Vertigan <steven@vertigan.wattle.id.au>.

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "rubyblue"

" GUI settings
hi Normal		guifg=#C7D4E2       guibg=#162433
hi NonText		guifg=#4A6480
hi SpecialKey	guifg=#4A6480
hi Function		guifg=white
hi phpFunctions	guifg=#FFEE80		gui=bold,italic
hi Comment		guifg=#237476		gui=italic
hi Constant		guifg=#00CC00
hi Identifier	guifg=white
hi Statement	guifg=#F9BB00       gui=none
hi Preproc		guifg=#F9BB00
hi Type			guifg=white			gui=underline
hi Special		guifg=#00CC00
hi Underlined	guifg=#208AFF		gui=underline

hi ErrorMsg		guifg=#F9BB00       guibg=darkBlue
hi WarningMsg	guifg=#428BDD       guibg=darkBlue         gui=bold
hi ModeMsg		guifg=yellow        gui=NONE
hi MoreMsg		guifg=yellow        gui=NONE
hi Error		guifg=white         guibg=red              gui=underline

hi Todo			guifg=black         guibg=yellow
hi Cursor		guifg=NONE			guibg=white
hi Search		guifg=black         guibg=yellow
hi IncSearch	guifg=black         guibg=yellow
hi LineNr		guibg=#B2CFE5		guifg=#162433
hi Title		guifg=white         gui=bold

hi StatusLineNC	gui=italic          guifg=#C0C0C0         guibg=#424242
hi StatusLine	gui=bold            guifg=black           guibg=orange

hi Label		guifg=#F9BB00       gui=none
hi Operator		guifg=#949C8B		gui=bold
hi Delimiter	guifg=#BD8C17
hi String		guifg=olivedrab
hi RegExp		guifg=#3C90FC		gui=bold
hi! link javaScriptRegexpString RegExp
hi Visual		guibg=#899797		gui=NONE

hi DiffChange	guibg=darkGreen		guifg=black
hi DiffText		guibg=olivedrab		guifg=black
hi DiffAdd		guibg=slateblue		guifg=black
hi DiffDelete   guibg=coral			guifg=black

hi Folded		guibg=white		guifg=black
hi FoldColumn	guibg=gray30		guifg=black
hi ColorColumn	guibg=#2F4056
hi CursorLine	guibg=#133856
hi VertSplit	guifg=#424242		guibg=#424242
hi cIf0			guifg=gray

" Terminal settings
hi Normal		ctermfg=lightGray   ctermbg=black
hi NonText		ctermfg=darkGray
hi comment		ctermfg=lightBlue
hi constant		ctermfg=lightGreen
hi identifier	ctermfg=white
hi statement	ctermfg=yellow
hi preproc		ctermfg=yellow
hi type			ctermfg=white
hi special		ctermfg=lightGreen
hi Underlined	ctermfg=lightBlue
hi Underlined	cterm=underline

hi ErrorMsg		ctermfg=black       ctermbg=red
hi WarningMsg	ctermfg=cyan
hi ModeMsg		ctermfg=yellow
hi MoreMsg		ctermfg=yellow
hi Error		ctermfg=white       ctermbg=red

hi Todo			ctermfg=black       ctermbg=yellow
hi Cursor		ctermfg=black       ctermbg=white
hi Search		ctermfg=black       ctermbg=yellow
hi IncSearch	ctermfg=black       ctermbg=yellow
hi LineNr		ctermfg=lightMagenta
hi title		cterm=bold

hi StatusLineNC	ctermfg=gray        ctermbg=darkBlue
hi StatusLine	ctermfg=white        ctermbg=lightBlue

hi label		ctermfg=yellow
hi operator		ctermfg=yellow

hi Visual		term=reverse
hi Visual		ctermfg=black       ctermbg=yellow

hi DiffChange	ctermbg=darkGreen	ctermfg=black
hi DiffText		ctermbg=lightGreen	ctermfg=black
hi DiffAdd		ctermbg=blue		ctermfg=black
hi DiffDelete	ctermbg=cyan		ctermfg=black

hi Folded		ctermbg=yellow		ctermfg=black
hi FoldColumn	ctermbg=gray		ctermfg=black
hi cIf0			ctermfg=gray
