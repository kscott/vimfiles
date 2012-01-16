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
	set guioptions-=rRlLb
	"set guifont=Monaco:h14
	set guifont=Consolas:h15.00,Monaco:h14

elseif has("linux")

endif
