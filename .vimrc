"
set termguicolors
" Search down into subfolders
" Provides tab-completion when searching for files
set path+=** 

" Display all matching files when we tab complete
set wildmenu 

set incsearch 
set ignorecase 
set showcmd 
set hlsearch 
set history=1000

" FILE BROWSING 
" Tweaks for brwosing 
let g:netrw_banner=0  "Disable banner
let g:netrw_browse_split=4 " open in prior window 
let g:netrw_altv=1  	" open splits to the right 
let g:netrw_liststyle=3    " tree view 
let g:netrw_list_hide=netrw_gitignore#Hide() 
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" PLUGINS 
call plug#begin() 
Plug 'preservim/nerdtree'
" ----------- THEMES ---------------------
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes'
Plug 'ayu-theme/ayu-vim' 
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', {'do': { -> fzf#install()}}
Plug 'ryanoasis/vim-devicons'

" --------------- TYPESCRIPT + REACT DEVELOPMENT --------------------------
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', {'branch':'main'}
Plug 'neoclide/coc.nvim' 
Plug 'morhetz/gruvbox' 

" --------------- PRETTIER - FOR AUTO FORMAT -----------------------
Plug 'prettier/vim-prettier', { 
      \ 'do': 'yarn install',
      \ 'for': ['javascript', 'typescript', 'typescriptreact', 'javascriptreact'] } 

" --------------  COMMENTS --------------------------------------------
Plug 'tpope/vim-commentary'
call plug#end() 
" vim-prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0 
let g:coc_global_extensions = [
	\ 'coc-tsserver', 
	\]
" --------------- AUTO STARTUP Syntax highlighting -----------" 
"  May suffer perfomance issues 		   -----------" 
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
" --------------- COC(k) Configuration ----------------------------
" COC config:: Jumping 
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references) 

" COC config:: Navgiating Error 
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" COC(k) : Navigating the suggestion 
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"


"NERD TREER CONFIGS 
nnoremap <leader>n :NERDTreeFocus<CR> 
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-e> :NERDTreeToggle<CR> 
nmap ,n :NERDTreeFind<CR>

"-----------------------Theme toggles --------------------
"'''''''''''''AYU THEME CONFIG 
" let ayucolor="mirage"
"'''''''''''''GRUV BOX THEME
" let g:gruvbox_termcolors=16
" autocmd vimenter * ++nested colorscheme gruvbox 
" ------------ NIGHTFLY 
colorscheme nightfly

set bg=dark
"COLOR SCHEME 
set t_Co=256 " Override terminal emulator color scheme

"AIRLINE CONFIG 
set encoding=UTF-8
set tabstop=4
set shiftwidth=4
set expandtab

" FZF config mapping 
nnoremap <silent> <C-f> :Files<CR>
set nu

set ttimeout
set ttimeoutlen=1
set ttyfast
set cursorline

" Color Support  
if (empty($TMUX))
    if (has("nvim"))
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1 
    endif
    if (has("termguicolors"))
        set termguicolors
    endif 
endif 
