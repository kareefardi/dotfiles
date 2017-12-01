set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')Plugin 'Valloric/YouCompleteMe'

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" themes
Plugin 'morhetz/gruvbox' 
Plugin 'chriskempson/base16-vim'
Plugin 'altercation/vim-colors-solarized' 

" linter
"Plugin 'vim-syntastic/syntastic'

" ycm
Plugin 'Valloric/YouCompleteMe'

" nerdtree
Plugin 'scrooloose/nerdtree'

" linter 2
Plugin 'w0rp/ale'

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

" airline settings
let g:airline_powerline_fonts = 1			" better airline rendering
let g:airline#extensions#ale#enabled = 1		" airline lint
let g:airline#extensions#tabline#enabled = 1		" airline buffer view
let g:airline#extensions#whitespace#enabled = 1		" airline whitespace shit

" setthing theme
set background=dark
colorscheme base16-3024

" hide gvim BS
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

" turn on syntax highlighting
syntax on

" decrease font size
" set guifont=Monospace\ 10

" line number
set number

" X clipboard
set clipboard=unnamedplus

" folding
set foldmethod=syntax
set foldnestmax=1

" set ycm settings
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_max_num_candidates = 11
let g:ycm_filetype_specific_completion_to_disable = {
	\ 'cpp': 1
	\}
" linter settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_cpp_checkers = ['clang_check']

"ale settings
let g:ale_lint_delay = 700
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
	\ 'python' : ['pylint', 'flake8'],
	\}

" toggle theme function
nnoremap <C-S-X> :call ToggleSolarized()<cr>

function ToggleSolarized()
	if &background == "light"
		set background=dark
	else
		set background=light
	endif
endfunction
