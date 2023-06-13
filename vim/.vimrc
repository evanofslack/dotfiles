" minimal vimrc for use on remote machines

" set leader as space
let mapleader = "\<Space>"

" vertical movement
nnoremap J <c-d>zz
nnoremap K <c-u>zz
vnoremap J }
vnoremap K {

" move by visual line not buffer
nnoremap j gj
nnoremap k gk

" move in insert mode
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-j> <down>
inoremap <c-k> <up>

" unmap arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>

" indent and keep selection
xnoremap <S-Tab> <gv
xnoremap <Tab> >gv
xnoremap < <gv
xnoremap > >gv

" unsets the last search pattern register by hitting return
nnoremap <CR> :noh<CR><CR>

" quicksave
nmap <leader>w :w<CR>

" mouse cursor
let &t_EI.="\e[2 q" "EI = NORMAL mode  = solid block
let &t_SI.="\e[6 q" "SI = INSERT mode = solid bar
let &t_SR.="\e[4 q" "SR = REPLACE mode = solid underscore

" turn of bash <C-j>
let g:BASH_Ctrl_j = 'off'

filetype plugin indent on

" sane split
set splitbelow
set splitright

set noshowmode
set laststatus=2

" keep 10 lines visible
set scrolloff=10

" tabs
:set tabstop=4
:set shiftwidth=4
:set expandtab

" permanent undo
set undodir=~/.vimdid
set undofile

" reduce time before 'o' opens new line
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line

" set system clipboard
set clipboard=unnamedplus

" set relative line numbers in normal mode
" and absolute line numbers in insert mode
:set number
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

let base16colorspace=256

" the best colorscheme
autocmd vimenter * ++nested colorscheme gruvbox

" syntax on
set background=dark

" search highlight
hi Search cterm=NONE ctermfg=15 ctermbg=4

" enable 24-bit color in vim
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif

if !has('gui_running')
  set t_Co=256
endif
