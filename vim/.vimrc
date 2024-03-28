""""""""""""""
"bemug's vimrc
""""""""""""""
"Made with love <3

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" own stuff
"Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
"Plug 'bling/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'ciaranm/detectindent'
"Plug 'chriskempson/vim-tomorrow-theme'
"Plug 'LaTeX-Box-Team/LaTeX-Box'
"Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'bogado/file-line'
"Plug 'mrtazz/DoxygenToolkit.vim'
Plug 'will133/vim-dirdiff'
"Plug 'morhetz/gruvbox'
"Plug 'sjl/badwolf'
"Plug 'scrooloose/nerdtree'
"Plug 'altercation/vim-colors-solarized'
"Plug 'jiangmiao/auto-pairs'
"Plug 'jlanzarotta/bufexplorer'
Plug 'kshenoy/vim-signature'
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'cormacrelf/vim-colors-github'
"Plug 'ronakg/quickr-cscope.vim'
"Plug 'github/copilot.vim'

"LSP stuff
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting


"LSP
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    "nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    "nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
    nmap <buffer> ge :LspDocumentDiagnostics<cr>

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"coloration
syn on
"filetype plugin on
set omnifunc=syntaxcomplete#Complete
"Shift tab to complete, requires tags to be found
inoremap <S-TAB> <C-X><C-O>

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
set directory=~/.vim/swapfiles/

"Line number
set nu
"Line number color
"highlight LineNr ctermfg=lightgreen

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

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set 5 lines to the cursor - when moving vertically using j/k
set so=5

"Highlight 81 column (oldschool style)
"let &colorcolumn=join(range(81,9999),",")
"Change color
"highlight ColorColumn ctermbg=darkgrey

"Stop acting dumb when pasting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"Spell check
map <F4> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>

"Where the fuck are my tags pulled off
map <F6> :echo join(tagfiles(), ',')<CR>

"Buffer switching
"map gn :bn<cr>
"map gp :bp<cr>
"map gd :bd<cr>

"Gvim options
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar

"Colors
set background=light

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

"Look for tags, and iterate in parents dir untill found
set tags=./tags;

" Disable mouse support (even in neovim)
set mouse=

"Escape using jk
inoremap jk <Esc>
inoremap kj <Esc>

"Highligh cursor line
"set cursorline

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

" Beauuuutiful
if $TERM == "xterm-256color" || $TERM == "screen-256color"
	set t_Co=256
endif

"Death to whitespaces
nnoremap <F3> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>a

"whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"fuck \ as leader
let mapleader = ","

"fast buffer switching
"https://vi.stackexchange.com/questions/2129/fastest-way-to-switch-to-a-buffer-in-vim
nnoremap <Leader>b :ls<CR>:b<Space>

" https://askubuntu.com/questions/60200/how-to-copy-data-between-different-instances-of-vim
vnoremap <leader>y :w! ~/saved.txt<cr>
nnoremap <leader>p :r ~/saved.txt<cr>

" Space to last macro
noremap <Space> .

" Don't restart at the top when searching
"set nowrapscan

" Open quickfix window after git grep
command -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | cw | redraw!

nnoremap <C-F> :execute 'Ggr '.expand('<cword>')

" refresh gitgutter on save
autocmd BufWritePost * GitGutter

" Folds
set foldmethod=syntax
" Open folds at startup
set foldlevelstart=99
" Fold only functions, not what is inside
set foldnestmax=1
" Don't search in folds
set fdo-=search

" Turns off syntax highlight when diffing
if &diff
    syntax off
endif

" Copy to both clipboard
set clipboard^=unnamed,unnamedplus

" Load cscope bindings
"source ~/cscope_maps.vim

" Handle Jenkinsfile as groovy
au BufNewFile,BufRead Jenkinsfile setf groovy

" Change window title according to file
set title

" Colorize hexcodes
let g:colorizer_startup = 1
