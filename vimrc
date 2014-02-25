set nocompatible
filetype off

if filereadable(expand("~/.vimrc.bundles"))
	source ~/.vimrc.bundles
endif

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
		" set statusline=%n:\ %<%f\ %h%m%r\ %{fugitive#statusline()}\ %{SyntasticStatuslineFlag()}\ %=%-14.(%l,%c%V%)\ %P

		set statusline=%3*%02n\  " Buffer number
		set statusline+=%1*%-15.80f\ %* " file name minimum 15, maxiumum 80 (right justified)
		set statusline+=%3*[
		set statusline+=%{strlen(&ft)?&ft:'none'} " filetype
		set statusline+=]%*
		set statusline+=%2*
		set statusline+=%h "help file flag
		set statusline+=%r "read only flag
		set statusline+=%m "modified flag
		set statusline+=%w "preview flag
		set statusline+=%*
		set statusline+=%4*%{fugitive#statusline()}%* " Fugitive
		set statusline+=%6*%{SyntasticStatuslineFlag()}%* " Syntastic Syntax Checking
		set statusline+=%= " right align
		set statusline+=%8*%-10.(%l:%v%)\ %<%P%* " offset

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
	set fillchars=vert:\ 			" Use a space to separate vertical splits
	set grepprg=ack					" use ack instead of grep
	set hidden
	set history=1000				" Store a ton of history (default is 20)
	set hlsearch					" highlight search terms
	set ignorecase					" case insensitive search
	set incsearch					" find as you type search
	set laststatus=2				" always show status line
	set linespace=0					" No extra spaces between rows
	set nolist
    set listchars=tab:▸\ ,eol:¬,trail:•		" Use the same symbols as TextMate for tabstops and EOLs
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
	set relativenumber
	set showmatch					" show matching brackets/parenthesis
	set showmode					" display the current mode
	set smartcase					" case sensitive when uc present
	set smarttab
	set softtabstop=4				" How wide for soft tabs
	set tabstop=4					" an indentation every four columns
	set tags=./tmtags,tmtags,./tags,tags;$HOME
	set tildeop						" make the tilde key act as an operator
	set ttimeoutlen=50
	set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
	"set wildmenu					" show list instead of just completing
	set wildmode=list:longest,full	" command <Tab> completion, list matches, then longest common part, then all.
	set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn
	set winminheight=0				" windows can be 0 characters wide
	set winminheight=0				" windows can be 0 line high

	syn match rubyConditionalError "\<\%(else if\|elseif\)\>[?!]\@!"

	" let g:solarized_visibility = "low"
	" let g:solarized_hitrail = 1
	set background=dark
	let g:zenburn_high_Contrast=1
    let g:zenburn_alternate_Visual = 1
	colorscheme jellybeans			" load a colorscheme
" }

" Key Mappings {
	map Q gq
	nnoremap <leader><leader> :LustyJugglePrevious<CR>

	" Easier moving in tabs and windows
	map <C-J> <C-W>j
	map <C-K> <C-W>k
	map <C-L> <C-W>l
	map <C-H> <C-W>h

	" GRB: clear the search buffer when hitting return
	:nnoremap <CR> :nohlsearch<CR>/<BS>

	" Let tab key in visual mode change the indent level of the selection
	vnoremap <Tab> >gv
	vnoremap <S-Tab> <gv

	" Yank from the cursor to the end of the line, to be consistent with C and D.
	nnoremap Y y$

	" Open tag definitions in a vertical split
	map <D-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

	" Shortcuts
	" Change Working Directory to that of the current file
	noremap <silent><leader>cd :cd %:p:h<cr>

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
	command! Marked silent !open -a "Marked.app" "%:p"
	nnoremap <leader>p :Marked<CR>
" }

" Autocommands {
	if has("autocmd")
		autocmd BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
		autocmd BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)

		" PHP coding settings"
		augroup PHP
			autocmd!
			autocmd FileType php setlocal autoindent tabstop=4 shiftwidth=4 softtabstop=4 smarttab noexpandtab formatoptions=croq commentstring=//\ %s
		augroup END

		" Javascript coding settings"
		" augroup Javascript
		" 	autocmd!
		" 	autocmd FileType javascript setlocal autoindent tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab formatoptions=croq
		" augroup END

		" Ruby coding settings"
		augroup Ruby
			autocmd!
			autocmd FileType ruby setlocal autoindent tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab formatoptions=croq
		augroup END

		" Sass coding settings"
		augroup Sass
			autocmd!
			autocmd FileType scss setlocal nobackup nowritebackup noswapfile autoindent tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab formatoptions=croq
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
	" vim-airline
	" unicode symbols
	let g:airline_left_sep = ''
"	let g:airline_left_sep = '»'
"	let g:airline_left_sep = '▶'
	let g:airline_right_sep = ''
"	let g:airline_right_sep = '«'
"	let g:airline_right_sep = '◀'
	let g:airline_branch_prefix = '⎇ '
	let g:airline_paste_symbol = '◉'
	let g:airline#extensions#readonly#symbol = '✖'
	let g:airline_linecolumn_prefix = '§'
	let g:airline_modified_detection=1
	let g:airline_enable_branch=1
	let g:airline_enable_syntastic=1
	let g:airline_enable_bufferline=0
	let g:airline_inactive_collapse=0
	let g:airline_detect_whitespace=0
	let g:airline_theme='jellybeans'
	let g:airline_section_z='%13(%p%% '.g:airline_linecolumn_prefix.'%l:%v%)'

	let g:bufferline_echo = 0

	" Supertab
	let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
	let g:SuperTabClosePreviewOnPopupClose = 1

	" SQL Utilities
	let g:sqlutil_align_where = 1
	let g:sqlutil_align_comma = 1
	let g:sqlutil_cmd_terminator = ';'
	let g:sqlutil_default_menu_mode = 0
	let g:sqlutil_keyword_case = '\U'
	let g:sqlutil_align_first_word = 1
	let g:sqlutil_wrap_expressions = 1
	let g:sqlutil_split_unbalanced_paran = 1
	let g:sqlutil_indent_nested_blocks = 1
	let g:sqlutil_non_line_break_keywords = 'as,like,desc,asc'
	let g:sqlutil_stmt_keywords = 'select,insert,update,delete,with,merge,case,when,else,join'

	" ZoomWin configuration
	map <leader>z :ZoomWin<CR>

	" Lusty
	let g:LustyExplorerSuppressRubyWarning = 1
	let g:LustyJugglerSuppressRubyWarning = 1
	let g:LustyJugglerDefaultMappings = 0
	let g:LustyJugglerAltTabMode = 1
	let g:LustyJugglerShowKeys = 'a'
	nmap <silent> <Leader>j :LustyJuggler<CR>
	noremap <silent> <A-s> :LustyJuggler<CR>

	" Commentary
	nmap <D-/> <Plug>CommentaryLine
	xmap <D-/> <Plug>Commentary

	" Syntastic
	"let g:syntastic_auto_jump=1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_error_symbol = '✗'
	let g:syntastic_warning_symbol = '⚑'
	let g:syntastic_style_error_symbol = '☯'
	let g:syntastic_style_warning_symbol = '☯'
    let g:syntastic_check_on_open = 1

    let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['css'] }
	let g:syntastic_php_checkers=['php', 'phpcs']

	" PHP CS Fixer
	let g:php_cs_fixer_path = "php-cs-fixer"        " define the path to the php-cs-fixer.phar
	let g:php_cs_fixer_level = "all"                " which level ?
	let g:php_cs_fixer_config = "default"           " configuration
	let g:php_cs_fixer_php_path = "php"             " Path to PHP
	let g:php_cs_fixer_fixers_list = ""             " List of fixers
	let g:php_cs_fixer_enable_default_mapping = 1   " Enable the mapping by default (<leader>pcd)
	let g:php_cs_fixer_dry_run = 0                  " Call command with dry-run option
	let g:php_cs_fixer_verbose = 0                  " Return the output of command if 1, else an inline information.

	" Itchy
	nmap <leader>s :Scratch<CR>

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
	map <leader>e :python debugger_watch_input("eval")<cr>A

	let g:useCustomColors = 1

	" setup gdbp settings
	let g:debuggerMaxChildren = 2048
	let g:debuggerMaxData = 8192
	let g:debuggerMaxDepth = 10
	let g:debuggerDisableDefaultMappings = 1

	" Surround
	let g:surround_35  = "#{\r}"   " ysiw# to wrap the token under cursor in #{}

	" Tagbar
	let g:tagbar_type_markdown = { 'ctagstype' : 'markdown', 'kinds' : [ 'h:Heading_L1', 'i:Heading_L2', 'k:Heading_L3' ] }

	" Javascript syntax
	let g:used_javascript_libs = 'jquery,underscore,backbone'

	let g:html_indent_inctags = "html,body,head,tbody"
	let g:html_indent_script1 = "inc"
	let g:html_indent_style1 = "inc"

	" dbext profiles
	let g:dbext_default_profile_ccb = 'type=DBI:user=root:passwd=kds007:driver=mysql:conn_parms=database=ccb_dev;host=localhost'
	let g:dbext_default_profile_ccbcompany = 'type=DBI:user=root:passwd=kds007:driver=mysql:conn_parms=database=ccbcompany;host=localhost'
	let g:dbext_default_profile_bbt = 'type=DBI:user=root:passwd=kds007:driver=mysql:conn_parms=database=bbt;host=localhost'

	let g:dbext_default_profile = 'ccb'

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

