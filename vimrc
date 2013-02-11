" Last Modified: Thu Dec 27 09:31:12 2012 MST 
"
" Basics {
	set nocompatible		" must be first line
" }

" Setup Bundle Support {
" The next two lines ensure that the ~/.vim/bundle/ system works
	filetype off
	runtime! autoload/pathogen.vim
	silent! call pathogen#runtime_append_all_bundles()
	silent! call pathogen#helptags()
" }

" General {
	filetype plugin indent on	" Automatically detect file types.
	syntax on					" syntax highlighting
	scriptencoding utf-8

	" Setting up the directories {
		set viminfo='50,<1000,s100,:0,n~/.vim/viminfo
		set backup						" backups are nice ...
		set backupcopy=auto
		set backupdir=$HOME/.vim/backup//	" but not when they clog .
		set directory=$HOME/.vim/swap//	" Same for swap files
		set viewdir=$HOME/.vim/views//	" same but for view files
		if v:version >= 703
    		set undodir=$HOME/.vim/undo//     " same for persisitent undo
    		set undofile
    		set undolevels=1000
    		set undoreload=10000
		endif

		" Creating directories if they don't exist
		silent execute '!mkdir -p $HOME/.vim/backup'
		silent execute '!mkdir -p $HOME/.vim/swap'
		silent execute '!mkdir -p $HOME/.vim/views'
	" }
" }

" Vim UI {

	if has('cmdline_info')
		set ruler					" show the ruler
		set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
	endif

	if has('statusline')
		set laststatus=2			" always show statusline
		set statusline=%n:\ %<%f\ %h%m%r\ %{fugitive#statusline()}\ %=%-14.(%l,%c%V%)\ %P
	endif

	let mapleader=","
	let maplocalleader="\\"

	set autoindent					" indent at the same level of the previous line
	set autowrite					" Automatically save when jumping around buffers
	set backspace=indent,eol,start	" backspace for dummys
	if v:version >= 703
		set colorcolumn=125			" Highlight the optimal width for code
	endif
	set cursorline					" highlight current line
	set encoding=utf-8
	set grepprg=ack					" use ack instead of grep
	set hidden
	set history=1000				" Store a ton of history (default is 20)
	set hlsearch					" highlight search terms
	set ignorecase					" case insensitive search
	set incsearch					" find as you type search
	set linespace=0					" No extra spaces between rows
	set nolist
	set mouse=a						" automatically enable mouse usage
	set noequalalways				" don't resize windows on splits
	set noexpandtab					" tabs are tabs, not spaces
	set nowrap						" wrap long lines
	set number				        " Line numbers on
	set scrolljump=5				" lines to scroll when cursor leaves screen
	set scrolloff=3					" minimum lines to keep above and below cursor
	set secure						" just in case...
	set shiftround
	set shiftwidth=4				" use indents of 4 spaces
	set shortmess+=filmnrxoOtT		" abbrev. of messages (avoids 'hit enter')
	set showcmd						" show partial commands in status line and selected characters/lines in visual mode
	set cmdheight=1
	set showmatch					" show matching brackets/parenthesis
	set showmode					" display the current mode
	set smartcase					" case sensitive when uc present
	set smarttab
	set softtabstop=4				" How wide for soft tabs
	set tabstop=4					" an indentation every four columns
	set tags=./tmtags,tmtags,./tags,tags;$HOME
	set tildeop						" make the tilde key act as an operator
	set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
	"set wildmenu					" show list instead of just completing
	set wildmode=list:longest,full	" command <Tab> completion, list matches, then longest common part, then all.
	set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn
	set winminheight=0				" windows can be 0 characters wide
	set winminheight=0				" windows can be 0 line high

	syn match rubyConditionalError "\<\%(else if\|elseif\)\>[?!]\@!"

	let g:solarized_visibility = "low"
	" let g:solarized_hitrail = 1
	set background=dark
	colorscheme lucius			" load a colorscheme
" }

" Key Mappings {
	map Q gq
	nnoremap <leader><leader> <c-^>

	" Easier moving in tabs and windows
	map <C-J> <C-W>j
	map <C-K> <C-W>k
	map <C-L> <C-W>l
	map <C-H> <C-W>h

	" GRB: clear the search buffer when hitting return
	:nnoremap <CR> :nohlsearch<CR>/<BS>

	" Remap the tab key to do autocompletion or indentation depending on the
	" context (from http://www.vim.org/tips/tip.php?tip_id=102)
	function! InsertTabWrapper()
		let col = col('.') - 1
		if !col || getline('.')[col - 1] !~ '\k'
			return "\<tab>"
		else
			return "\<c-p>"
		endif
	endfunction
	inoremap <tab> <c-r>=InsertTabWrapper()<cr>
	inoremap <s-tab> <c-n>

	" Let tab key in visual mode change the indent level of the selection
	vnoremap <Tab> >gv
	vnoremap <S-Tab> <gv

	" Yank from the cursor to the end of the line, to be consistent with C and D.
	nnoremap Y y$

	" Enable Very Magic for search/replace
	nnoremap / /\v
	vnoremap / /\v

	" Open tag definitions in a vertical split
	map <D-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

	" Shortcuts
	" Change Working Directory to that of the current file
	noremap <silent><leader>cd :cd %:p:h<cr>
	noremap <leader>e :e %:h

	nnoremap <D-S-Down> :m+<CR>==
	nnoremap <D-S-Up> :m-2<CR>==
	inoremap <D-S-Down> <Esc>:m+<CR>==gi
	inoremap <D-S-Up> <Esc>:m-2<CR>==gi
	vnoremap <D-S-Down> :m'>+<CR>gv=gv
	vnoremap <D-S-Up> :m-2<CR>gv=gv

	" This command will allow us to save a file we don't have permission to save
	" *after* we have already opened it. Super useful.
	cnoremap w!! w !sudo tee % >/dev/null

	map <F5> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

	nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" }

" Autocommands {
	if has("autocmd")
		autocmd BufEnter * set relativenumber

		autocmd BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
		autocmd BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)

		au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

		" PHP coding settings"
		augroup PHP
			autocmd!
			autocmd FileType php setlocal autoindent tabstop=4 shiftwidth=4 softtabstop=4 smarttab noexpandtab formatoptions=croq commentstring=//\ %s
		augroup END

		" Ruby coding settings"
		augroup Ruby
			autocmd!
			autocmd FileType ruby setlocal autoindent tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab formatoptions=croq
		augroup END

		" Cucumber coding settings"
		augroup Cucumber
			autocmd!
			autocmd FileType cucumber setlocal autoindent tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab formatoptions=croq
		augroup END

		" autocomplete functions and identifiers for languages
		autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
		autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
		autocmd FileType css set omnifunc=csscomplete#CompleteCSS
		autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
		autocmd FileType sql set omnifunc=sqlcomplete#Complete

		autocmd BufWritePost .vimrc source $MYVIMRC
		autocmd BufWritePost .gvimrc source $MYGVIMRC
	endif
" }

" Abbreviations {
	" Date/Time stamps
	iabbrev xstamp	<C-R>=strftime("%a %b %d %H:%M:%S %Y %Z")<CR>
	iabbrev lastmod  <C-R>="Last Modified: " . strftime("%a %b %d %H:%M:%S %Y %Z")<CR>
	iabbrev kds <C-R>="Kenneth Scott"<CR>
	iabbrev atccb <C-R>="kscott@ccbhq.com"<CR>
" }

" Plugin Settings {
	" SQL Utilities
	let g:sqlutil_align_comma = 1
	let g:sqlutil_cmd_terminator = ';'
	let g:sqlutil_default_menu_mode = 0
	let g:sqlutil_keyword_case = '\U'
	let g:sqlutil_align_first_word = 1
	let g:sqlutil_wrap_expressions = 1

	" Custom mapping for Ack Plugin
	let g:ackprg = 'ag --nogroup --nocolor --column'
	map <D-F> :Ack<space>
	map <leader>a :Ack!

	" ZoomWin configuration
	map <leader>z :ZoomWin<CR>

	" Lusty
	let g:LustyExplorerSuppressRubyWarning = 1
	let g:LustyJugglerSuppressRubyWarning = 1
	let g:LustyJugglerDefaultMappings = 0
	let g:LustyJugglerAltTabMode = 1
	nmap <silent> <Leader>j :LustyJuggler<CR>
	noremap <silent> <A-s> :LustyJuggler<CR>

	" Commentary
	nmap <D-/> <Plug>CommentaryLine
	xmap <D-/> <Plug>Commentary

	" Syntastic
	"let g:syntastic_auto_jump=1
	let g:syntastic_auto_loc_list=1
	let g:syntastic_error_symbol = '✗'
	let g:syntastic_warning_symbol = '⚠'

	" Itchy
	nmap <leader>s :Scratch<CR>

	" Lint
	let lint_highlight_color = "#dadada"

	" DBGp
	map <leader>1 :python debugger_resize()<cr>
	map <leader>4 :python debugger_command('step_out')<cr>
	map <leader>5 :python debugger_run()<cr>
	map <leader>6 :python debugger_quit()<cr>
	map <leader>7 :python debugger_command('step_into')<cr>
	map <leader>8 :python debugger_command('step_over')<cr>
	map <leader>9 :python debugger_context()<cr>
	map <leader>0 :python debugger_property()<cr>
	map <leader>9 :python debugger_watch_input("context_get")<cr>A<cr>
	map <leader>0 :python debugger_watch_input("property_get", '<cword>')<cr>A<cr>
	map <leader>b :Bp<cr>
	" map <leader>e :python debugger_watch_input("eval")<cr>A
 	
	" setup gdbp settings
	let g:debuggerMaxChildren = 2048
	let g:debuggerMaxData = 8192
	let g:debuggerMaxDepth = 10
	let g:debuggerDisableDefaultMappings = 1
	
	" vim-indent-guides
	let g:indent_guides_enable_on_vim_startup = 1
	let g:indent_guides_color_change_percent = 1
	let g:indent_guides_start_level = 2

	" MatchTagAlways
	let g:mta_use_matchparen_group = 0

" Custom highlighting
	highlight ExtraWhitespace ctermfg=yellow ctermbg=red guifg=yellow guibg=red
	match ExtraWhitespace /\s\+$/
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	autocmd BufWinLeave * call clearmatches()
" Include user's local vim config

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

