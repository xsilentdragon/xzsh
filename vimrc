"--------------Plugins
set nocompatible
source ~/.vim/plugins.vim
source ~/.vim/lightline_settings.vim
"--------Keyboard-------
""Handle backspace as we expect
set backspace=indent,eol,start

"---------Mappings--------
""Set our global leader to ,
let mapleader = ','
"Make it easy to edit the vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>
" /
" / NERDTree
" /
nmap <C-E> :NERDTreeToggle<cr>
" / 
" / Ctags Search
" 
nmap <Leader>f :tag<space>
" Prevent nerdtree from overriding - vim-vinegar browse
let NERDTreeHijackNetrw = 0

"---------Visuals--------
syntax on
syntax enable   "Enable syntax highlighting
colorscheme arcadia "arcadia arcadia load lucario from ~/.vim/colors/lucario.vim


set linespace=20
set number  "Sets line numbers
set nowrap
set autoindent
set copyindent
set tabstop=4
set shiftwidth=4
set showmatch
set ignorecase
set smartcase
set smarttab

set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak
set title
set noerrorbells
"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.
let g:netrw_banner=0
"
set shortmess=I
"
"
"
"
""-------Buffers---------
"Cycle buffers with Ctrl J-K
nmap <F5> :bprev<CR>
nmap <F6> :bnext<CR>
"
"
"
"
""---------Search--------
set hlsearch
set incsearch
"Make <Leader><space> turn off highlight after search
nmap <Leader><space> :nohlsearch<cr>
"
"
"
"
"
""-----Split Management--------
set splitbelow
set splitright
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>




"--------Auto-Commands-----
""Automatically source the vimrc file on save
augroup autosourcing
autocmd!
autocmd BufWritePost .vimrc source %
augroup END


"---------CTag regenerate
function! DelTagOfFile(file)
let fullpath = a:file
let cwd = getcwd()
let tagfilename = cwd . "/tags"
   let f =
   substitute(fullpath,
   cwd . "/", "",
)
let f = escape(f, './')
let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
let resp = system(cmd)
endfunction

function! UpdateTags()
let f = expand("%:p")
let cwd = getcwd()
let tagfilename = cwd . "/tags"
let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
call DelTagOfFile(f)
let resp = system(cmd)
endfunction
autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()
