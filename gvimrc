" Last Modified: Sat Feb 26 16:06:21 2011 MST


set columns=125
set guioptions-=T
set lines=50
set printoptions=syntax:y,paper:letter

set background=light

if exists("+antialias")
	set antialias
endif

if exists('+fuoptions')
	set fuoptions=maxhorz,maxvert
	"set fu
endif

if has("Win32")
	set guifont=Consolas:h16:cANSI
	set mousehide
	set guioptions=gmrbt

elseif has("mac")
	set guioptions-=r
	set guioptions-=R
	set guioptions-=l
	set guioptions-=L
	set guioptions-=b

	"set guifont=Monaco:h14
	set guifont=Consolas:h15.00,Source\ Code\ Pro:h15,Monaco:h14
	colorscheme lucius

	" vim-indent-guides
	let g:indent_guides_enable_on_vim_startup = 0
	let g:indent_guides_color_change_percent = 1
	let g:indent_guides_start_level = 2

elseif has("linux")

endif

" Include user's local vim config
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif

