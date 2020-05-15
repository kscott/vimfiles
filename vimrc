set nocompatible
filetype off

if filereadable(expand("~/.vimrc.bundles"))
	source ~/.vimrc.bundles
endif

" General {
	filetype plugin indent on	" Automatically detect file types.
	syntax on					" syntax highlighting
	scriptencoding utf-8
	set t_Co=256

	" Setting up the directories {
		set viminfo='50,<1000,s100,:0,n~/.vim/viminfo
		" set backupdir=$HOME/.vim/backup//	" but not when they clog .
		" set directory=$HOME/.vim/swap//	" Same for swap files
		" set viewdir=$HOME/.vim/views//	" same but for view files
		if v:version >= 703
    		set undodir=$HOME/.vim/undo     " same for persisitent undo
    		set undofile
    		set undolevels=1000
    		set undoreload=10000
		endif
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
	set nobackup
	if v:version >= 703
		set colorcolumn=140			" Highlight the optimal width for code
	endif
	set clipboard=unnamed			" Copy result of yy,d, etc. to system clipboard
	set cursorline					" highlight current line
	set encoding=utf-8
	set fillchars=vert:\ 			" Use a space to separate vertical splits
	set grepprg=ack					" use ack instead of grep
	set hidden
	set history=1000				" Store a ton of history (default is 20)
	set hlsearch					" highlight search terms
	set ignorecase					" case insensitive search
	set incsearch					" find as you type search
	set nojoinspaces				" Add one space after "." when joining lines
	set laststatus=2				" always show status line
	set lazyredraw
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
	set shortmess+=filmnrxoOatIT	" abbrev. of messages (avoids 'hit enter')
	set noshowcmd						" show partial commands in status line and selected characters/lines in visual mode
	set noshowmode                  " Don't show -- INSERT -- etc. at bottom of screen
	set nostartofline               " Don't move cursor to start of line when moving
	set noswapfile
	set synmaxcol=250               " Don't try syntax matching after column 250
	set cmdheight=1
	set relativenumber
	set showmatch					" show matching brackets/parenthesis
	set showmode					" display the current mode
	set smartcase					" case sensitive when uc present
	set smarttab
	set softtabstop=4				" How wide for soft tabs
	set tabstop=4					" an indentation every four columns
	set tags=./tags,tags;$HOME
	set tildeop						" make the tilde key act as an operator
	set ttimeoutlen=50
	set ttyfast
	set ttyscroll=3
	set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
	"set wildmenu					" show list instead of just completing
	set wildmode=list:longest,full	" command <Tab> completion, list matches, then longest common part, then all.
	set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn
	set winminwidth=0				" windows can be 0 characters wide
	set winminheight=0				" windows can be 0 line high

	set background=dark
	" colorscheme PaperColor			" load a colorscheme
	" colorscheme jellybeans			" load a colorscheme
	colorscheme gruvbox
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
	map <M-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

	" Shortcuts
	" Change Working Directory to that of the current file
	noremap <silent><leader>cd :cd %:p:h<cr>

	nnoremap <M-S-Down> :m+<CR>==
	nnoremap <M-S-Up> :m-2<CR>==
	inoremap <M-S-Down> <Esc>:m+<CR>==gi
	inoremap <M-S-Up> <Esc>:m-2<CR>==gi
	vnoremap <M-S-Down> :m'>+<CR>gv=gv
	vnoremap <M-S-Up> :m-2<CR>gv=gv

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

		" Ruby coding settings"
		augroup Ruby
			autocmd!
			autocmd BufEnter *.rb syn match error contained "\<binding.pry\>"
			autocmd BufEnter *.rb syn match error contained "\<debugger\>"
		augroup END

		augroup PHP
			autocmd!
			autocmd FileType php setlocal commentstring=\/\/\ %s
			autocmd FileType php setlocal tabstop=4
			autocmd FileType php setlocal softtabstop=4
			autocmd FileType php setlocal shiftwidth=4
			autocmd FileType php setlocal noexpandtab
		augroup END

		autocmd BufWritePost .vimrc nested source $MYVIMRC
		autocmd BufWritePost .gvimrc nested source $MYGVIMRC
	endif
" }

" Abbreviations {
	" Date/Time stamps
	iabbrev xstamp	<C-R>=strftime("%a %b %d %H:%M:%S %Y %Z")<CR>
	iabbrev lastmod  <C-R>="Last Modified: " . strftime("%a %b %d %H:%M:%S %Y %Z")<CR>
	iabbrev kds <C-R>="Kenneth Scott"<CR>
	iabbrev atccb <C-R>="kscott@ccbhq.com"<CR>
	iabbrev ati <C-R>="ken.scott@ibotta.com"<CR>
" }

" Plugin Settings {

	" Lusty
	let g:LustyExplorerSuppressRubyWarning = 1
	let g:LustyJugglerSuppressRubyWarning = 1
	let g:LustyJugglerDefaultMappings = 0
	let g:LustyJugglerAltTabMode = 1
	let g:LustyJugglerShowKeys = 'a'
	nmap <silent> <Leader>j :LustyJuggler<CR>
	noremap <silent> <A-s> :LustyJuggler<CR>

	" vim-ruby
	let g:ruby_indent_access_modifier_style = 'indent'
	let ruby_spellcheck_strings = 1

	" Itchy
	nmap <leader>c :Scratch<CR>

	" Surround
	let g:surround_35  = "#{\r}"   " ysiw# to wrap the token under cursor in #{}

	"vim-rspec
	" let g:rspec_command = "!bundle exec rspec {spec}"
	let g:rspec_runner = "os_x_iterm"
	map <Leader>t :call RunCurrentSpecFile()<CR>
	map <Leader>s :call RunNearestSpec()<CR>
	map <Leader>l :call RunLastSpec()<CR>
	map <Leader>a :call RunAllSpecs()<CR>

	" make YCM compatible with UltiSnips (using supertab)
	let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
	let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
	let g:SuperTabDefaultCompletionType = '<C-n>'
	let g:ycm_collect_identifiers_from_tags_files = 0

	" NERDTree
	map <C-n> :NERDTreeToggle<CR>
	let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

	" vim-indent-guides
	let g:indent_guides_auto_colors = 1
	" let g:indent_guides_start_level = 2

	" Terraform settings
	let g:terraform_align=1
	let g:terraform_fmt_on_save=1

	" Ctrl-P
	let g:ctrlp_working_path_mode = 'ra'

	let g:ctrlp_show_hidden = 1
	let g:ctrlp_custom_ignore = "build"
	if executable('ag')
		let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	endif

	let g:lightline = {
	\   'colorscheme': 'gruvbox',
	\   'active': {
	\     'left': [ [ 'mode', 'paste' ],
	\               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
	\   },
	\   'component_function': {
	\     'gitbranch': 'fugitive#head'
	\   },
	\ }

	let g:gruvbox_contrast_light = 'hard'
	let g:gruvbox_contrast_dark = 'hard'
	let g:gruvbox_italicize_comments = 1

	let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

highlight Comment cterm=NONE
