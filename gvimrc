" Last Modified: Sat Feb 26 16:06:21 2011 MST


set columns=125
set guioptions-=T
set lines=50
set printoptions=syntax:y,paper:letter

set list listchars=tab:▸\ ,eol:¬,trail:•		" Use the same symbols as TextMate for tabstops and EOLs
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
	set guifont=Consolas:h15.00,Monaco:h14

elseif has("linux")

endif

" Custom highlighting
	highlight ExtraWhitespace ctermfg=yellow ctermbg=red guifg=yellow guibg=red
	match ExtraWhitespace /\s\+$/
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	autocmd BufWinLeave * call clearmatches()
