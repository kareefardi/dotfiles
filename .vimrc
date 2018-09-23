set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')Plugin 'Valloric/YouCompleteMe'

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline' 		" the cool bar at the bottom
Plugin 'vim-airline/vim-airline-themes'		" a theme for the the cool bar at the bottom
" Plugin 'vim-syntastic/syntastic' 		" synchronous autocomplete
Plugin 'Valloric/YouCompleteMe'			" aysnchronous autocomplete
Plugin 'scrooloose/nerdtree'			" project tree
Plugin 'w0rp/ale'				" linter
Plugin 'godlygeek/csapprox' 			" terminal color (make gui and terminal color the same)
Plugin 'universal-ctags/ctags' 			" Ctags for code navigation jump to definiton etc
Plugin 'junegunn/fzf.vim'				" fuzzy finder for project search

Plugin 'wlangstroth/vim-racket'			" racket shit
" themes
Plugin 'morhetz/gruvbox' 
Plugin 'altercation/vim-colors-solarized' 
Plugin 'chriskempson/base16-vim'
Plugin 'octol/vim-cpp-enhanced-highlight'

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
" let g:airline_solarized_bg='light'
let g:airline_powerline_fonts = 1 			" better airline rendering
let g:airline#extensions#ale#enabled = 1 		" airline lint
let g:airline#extensions#tabline#enabled = 1 		" airline buffer view
let g:airline#extensions#whitespace#enabled = 1 	" airline whitespace shit
let g:ale_set_highlights = 1				" error highlight

set t_Co=256				" terminal 256 colors
" colorscheme base16-default-dark
set background=dark

syntax on				" syntax highlighting
set number				" line numbers
set clipboard=unnamedplus		" clipboard shit
set foldmethod=syntax			" folding shit
set foldnestmax=1			" folding shit

" hide gvim BS
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar
:set guioptions-=e  "remove bottombar
:set guiheadroom=0


" set ycm settings
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_max_num_candidates = 11
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_echo_current_diagnostic = 0
"let g:ycm_filetype_specific_completion_to_disable = {
"\}
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
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
	\ 'python' : ['pylint', 'flake8'],
	\ 'cpp' : ['gcc', 'clang'],
	\}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1

" toggle theme function
nnoremap <C-S-x> :call ToggleSolarized()<cr>

function ToggleSolarized()
	if &background == "light"
		set background=dark
	else
		set background=light
	endif
endfunction

" remove auto enter comment


" separate themes for gui and termianl
if has('gui_running')
	" colorscheme base16-default-dark
	colorscheme gruvbox
else
	colorscheme gruvbox
endif


autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype cpp setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 smartindent
autocmd Filetype sql setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 smartindent autoindent

" nerdtree settings
let g:NERDTreeWinPos='right'
map <C-n> :NERDTreeToggle<CR>
map <C-S-N> :NERDTreeFocus<cr>

set smartindent
"set formatoptions-=cro

