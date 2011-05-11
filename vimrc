" Last Modified: Sat Feb 26 23:04:33 2011 MST
"
" Setup Bundle Support {
" The next two lines ensure that the ~/.vim/bundle/ system works
	filetype off
	runtime! autoload/pathogen.vim
	silent! call pathogen#runtime_append_all_bundles()
	silent! call pathogen#helptags()
" }

" Basics {
	set nocompatible		" must be first line
" }

" General {
	filetype plugin indent on	" Automatically detect file types.
	syntax on					" syntax highlighting
	scriptencoding utf-8

	" Setting up the directories {
		set viminfo='50,<1000,s100,:0,n~/.vim/viminfo
		set backup						" backups are nice ...
		set backupcopy=auto
		set backupdir=$HOME/.vim/backup	" but not when they clog .
		set directory=$HOME/.vim/swap	" Same for swap files
		set viewdir=$HOME/.vim/views	" same but for view files
		if v:version >= 703
    		set undodir=$HOME/.vim/undo     " same for persisitent undo
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

	set autoindent					" indent at the same level of the previous line
	set autowrite					" Automatically save when jumping around buffers
	set backspace=indent,eol,start	" backspace for dummys
	if v:version >= 703
		set colorcolumn=105			" Highlight the optimal width for code
	endif
	set cursorline					" highlight current line
	set grepprg=ack					" use ack instead of grep
	set history=1000				" Store a ton of history (default is 20)
	set hlsearch					" highlight search terms
	set ignorecase					" case insensitive search
	set incsearch					" find as you type search
	set linespace=0					" No extra spaces between rows
	set list listchars=tab:▸\ ,eol:¬,trail:•		" Use the same symbols as TextMate for tabstops and EOLs
	set mouse=a						" automatically enable mouse usage
	set noequalalways				" don't resize windows on splits
	set noexpandtab					" tabs are tabs, not spaces
	set nowrap						" wrap long lines
	set number						" Line numbers on
	set scrolljump=5				" lines to scroll when cursor leaves screen
	set scrolloff=3					" minimum lines to keep above and below cursor
	set secure						" just in case...
	set shiftround
	set shiftwidth=4				" use indents of 4 spaces
	set shortmess+=filmnrxoOtT		" abbrev. of messages (avoids 'hit enter')
	set showcmd						" show partial commands in status line and selected characters/lines in visual mode
	set showmatch					" show matching brackets/parenthesis
	set showmode					" display the current mode
	set smartcase					" case sensitive when uc present
	set smarttab
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
	let g:solarized_hitrail = 1
	set background=light
	colorscheme solarized			" load a colorscheme
" }

" Key Mappings {

	" Easier moving in tabs and windows
	map <C-J> <C-W>j<C-W>_
	map <C-K> <C-W>k<C-W>_
	map <C-L> <C-W>l<C-W>_
	map <C-H> <C-W>h<C-W>_

	map <Leader>, :nohl<CR>

	" Let tab key in visual mode change the indent level of the selection
	vmap <Tab> >gv
	vmap <S-Tab> <gv

	" Yank from the cursor to the end of the line, to be consistent with C and D.
	nnoremap Y y$

	" Shortcuts
	" Change Working Directory to that of the current file
	cmap cwd lcd %:p:h

	nnoremap <D-S-Down> :m+<CR>==
	nnoremap <D-S-Up> :m-2<CR>==
	inoremap <D-S-Down> <Esc>:m+<CR>==gi
	inoremap <D-S-Up> <Esc>:m-2<CR>==gi
	vnoremap <D-S-Down> :m'>+<CR>gv=gv
	vnoremap <D-S-Up> :m-2<CR>gv=gv

	map <F5> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }

" Autocommands {
	if has("autocmd")
		autocmd BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
		autocmd BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)

		au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

		" PHP coding settings
		augroup PHP
			autocmd!
			autocmd FileType php noremap <C-M> :!php -l %<CR>
		augroup END

		" Ruby coding settings"
		augroup Ruby
			autocmd!
			autocmd FileType ruby set autoindent tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab formatoptions=croq
			autocmd FileType ruby set foldenable foldmethod=syntax
		augroup END

		" Cucumber coding settings"
		augroup Cucumber
			autocmd!
			autocmd FileType cucumber set autoindent tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab formatoptions=croq
			autocmd FileType cucumber set foldenable foldmethod=syntax
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

	" Command-T
	let g:CommandTMaxHeight = 8
	let g:CommandTMatchWindowAtTop = 1

	" NERDCommenter settings
	let NERDDefaultNesting = 0
	map <D-/> <leader>ci
	vmap <D-/> <leader>cigv

	" Custom mapping for Ack Plugin
	map <D-F> :Ack<space>

	" NERDTree configuration
	let NERDTreeIgnore=['\.rbc$', '\~$']
	map <Leader>n :NERDTreeToggle<CR>

	" Command-T configuration
	let g:CommandTMaxHeight=20

	" ZoomWin configuration
	map <Leader>z :ZoomWin<CR>

	" CTags
	map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
	
	" Enable syntastic syntax checking
	let g:syntastic_enable_signs=1
	let g:syntastic_quiet_warnings=1

	let g:SuperTabMappingForward = '<c-space>'
	let g:SuperTabMappingBackward = '<s-c-space>'

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

