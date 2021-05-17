""""""""""""""
"bemug's vimrc
""""""""""""""
"Made with love <3

"VUNDLE
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" own stuff
"Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
"Plugin 'bling/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'ciaranm/detectindent'
"Plugin 'chriskempson/vim-tomorrow-theme'
"Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'bogado/file-line'
Plugin 'mrtazz/DoxygenToolkit.vim'
Plugin 'will133/vim-dirdiff'
"Plugin 'morhetz/gruvbox'
"Plugin 'sjl/badwolf'
"Plugin 'scrooloose/nerdtree'
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'jiangmiao/auto-pairs'
"Plugin 'jlanzarotta/bufexplorer'
Plugin 'kshenoy/vim-signature'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'chrisbra/Colorizer'
Plugin 'cormacrelf/vim-colors-github'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"END VUNDLE

"coloration
syn on
filetype indent plugin on
syntax enable
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"Indentation
set smartindent
set noexpandtab

""linux kernel compliance
set tabstop=8
set shiftwidth=8
set tw=80
"autowrap
set fo+=t
set fo-=l

"Swap files in their own directory
set directory=/work1/bmugnier/.vim/swapfiles/

"Line number
set nu
"Line number color
highlight LineNr ctermfg=grey

"Highlight matching brackets
set showmatch

"Incremental search (Firefox like)
set incsearch

" Highlight search results
set hlsearch

"Case
set smartcase

"Auto completion
set wildmode =list:longest,full    "affiche toutes les possibilités
set wildignore =*.o,*.r,*.so,*.sl,*.tar,*.tgz    "ignorer certains types de fichiers pour la complétion des includes

" Set to auto read when a file is changed from the outside
set autoread

"Always show current position
set ruler

"Never show status bar (airline does)
"set laststatus=0

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set 5 lines to the cursor - when moving vertically using j/k
set so=5

"Highlight 81 column (oldschool style)
"set colorcolumn=81
"Change color
let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=grey

"Stop acting dumb when pasting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

map <F4> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>

"Where the fuck are my tags pulled off
map <F6> :echo join(tagfiles(), ',')<CR>

"TabBar shortcut
nmap <F7> :NERDTreeToggle<CR>
"TabBar shortcut
nmap <F8> :TagbarToggle<CR>

"Buffer switching
"map gn :bn<cr>
"map gp :bp<cr>
"map gd :bd<cr>

"Omnicompletion
if !has("gui_running")
    inoremap <C-@> <C-x><C-o>
endif

"Gvim options
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar

"Colors
"colorscheme Tomorrow-Night
"set background=light
"colorscheme PaperColor
"let g:airline_theme='papercolor'


"Helpers
" Returns true if paste mode is enabled
function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	en
	return ''
endfunction

"whitespaces and tabs
set list
"set listchars=tab:→\ ,trail:· "old ones
"set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:· "compat
set listchars=tab:→\ ,extends:›,precedes:‹,nbsp:␣,trail:•,extends:⟩

"Let me open how many I want
set tabpagemax=100

"ctrlp only in cur dir
let g:ctrlp_working_path_mode = 0

"c++11
let g:syntastic_cpp_compiler_options = ' -std=c++11'

"fuck power line fonts this shit doesn't grow on trees
"let g:airline_powerline_fonts = 0

"Look for tags, and iterate in parents dir untill found
set tags=./tags;

" Disable mouse support (even in neovim)
set mouse=

" Don't show seperators
"let g:airline_left_sep=''
"let g:airline_right_sep=''

" Enable the list of buffers
"let g:airline#extensions#tabline#enabled = 1

" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'

"Escape using jk
inoremap jk <Esc>
inoremap kj <Esc>

"Highligh cursor line
"set cursorline

"Access system clipboard
"set clipboard=unnamedplus

"Only draw when necessary
set lazyredraw
set ttyfast

" Git commit no longer than 72 chars and check spelling to avoid random autism
" Quick reminder:
" - Summary first letter capitalized
" - no DOT at the end of the summary
" - Blank line before long description
" - Should answer "why is it necessary" following by "how did it fix it"
au FileType gitcommit set tw=72 spell
" And ffs let me start at the top of the file
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])


" Ruby is an oddball in the family, use special spacing/rules
if v:version >= 703
  " Note: Relative number is quite slow with Ruby, so is cursorline
  autocmd FileType ruby setlocal nocursorline
  autocmd FileType ruby setlocal norelativenumber
else
  autocmd FileType ruby setlocal
endif

set hidden

"neovim and terminal improvements
if has('nvim')
	tnoremap <Esc> <C-\><C-n>

	tnoremap <A-h> <C-\><C-n><C-w>h
	tnoremap <A-j> <C-\><C-n><C-w>j
	tnoremap <A-k> <C-\><C-n><C-w>k
	tnoremap <A-l> <C-\><C-n><C-w>l
	nnoremap <A-h> <C-w>h
	nnoremap <A-j> <C-w>j
	nnoremap <A-k> <C-w>k
	nnoremap <A-l> <C-w>l<F37>
endif

"YCM use ctags
"let g:ycm_collect_identifiers_from_tags_files = 1

" Beauuuutiful
if $TERM == "xterm-256color" || $TERM == "screen-256color"
	set t_Co=256
endif

"Don't touch my background you dumb colorscheme
"hi Normal guibg=NONE ctermbg=NONE

"Detect indentation
"autocmd BufReadPost * :DetectIndent
"ez down here
"let g:detectindent_preferred_indent = 4

"Death to whitespaces
nnoremap <F3> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>a

"whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"display buffer nb
"let g:airline#extensions#tabline#buffer_idx_mode = 1

"fuck \ as leader
let mapleader = ","

"fast buffer switching
"https://vi.stackexchange.com/questions/2129/fastest-way-to-switch-to-a-buffer-in-vim
nnoremap <Leader>b :ls<CR>:b<Space>

" https://askubuntu.com/questions/60200/how-to-copy-data-between-different-instances-of-vim
"vmap <leader>y :w! ~/.vbuf<CR>
"nmap <leader>p :r! cat ~/.vbuf<CR>
noremap <leader>y "*y
noremap <leader>p "*p
noremap <leader>g :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

" Space to last macro
noremap <Space> .

" Don't restart at the top when searching
"set nowrapscan

" Smarter Ggrep
command -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | cw | redraw!

" refresh gitgutter on save
autocmd BufWritePost * GitGutter

" folds
set foldmethod=syntax
"open folds at startup
set foldlevelstart=20
