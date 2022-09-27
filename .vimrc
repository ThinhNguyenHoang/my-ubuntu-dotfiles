" 
set nocompatible 
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
" ------------------ SNIPPET MANAGERS ----------------------------------- 
Plug 'SirVer/ultisnips'  
Plug 'honza/vim-snippets'
" ------------------ MOTION AND MOVEMENT + MATCH PAIRS ----------------------------- 
Plug 'andymass/vim-matchup' 
Plug 'preservim/nerdtree'
" ----------- THEMES ---------------------
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes'
Plug 'ayu-theme/ayu-vim' 
Plug 'bluz71/vim-nightfly-guicolors' 
Plug 'franbach/miramare'
Plug 'ryanoasis/vim-devicons'
" ----------------- FZF search  -------------------------
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', {'do': { -> fzf#install()}}
" --------------- TYPESCRIPT + REACT DEVELOPMENT --------------------------
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', {'branch':'main'}
Plug 'neoclide/coc.nvim' 
Plug 'morhetz/gruvbox' 
Plug 'tpope/vim-surround'
" --------------- PRETTIER - FOR AUTO FORMAT -----------------------
Plug 'prettier/vim-prettier', { 
      \ 'do': 'yarn install',
      \ 'for': ['javascript', 'typescript', 'typescriptreact', 'javascriptreact'] } 

" --------------  COMMENTS --------------------------------------------
Plug 'tpope/vim-commentary' 
" ---------------- GIT ----------------------------------------
Plug 'tpope/vim-fugitive'
call plug#end() 
" --------------------- VIM - PRETTTIER ---------------------------------
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


" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Show COC Suggestion 
inoremap <silent><expr> <C-space> coc#refresh() 
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>" 
" --------------------------------------- NERD TREER CONFIGS ---------
nnoremap <leader>n :NERDTreeFocus<CR> 
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-e> :NERDTreeToggle<CR> 
nmap ,n :NERDTreeFind<CR>

"-----------------------Theme toggles --------------------
"----------------------GRUV BOX THEME
" let g:gruvbox_termcolors=16
" autocmd vimenter * ++nested colorscheme gruvbox 
" ------------ NIGHTFLY 
colorscheme nightfly
" ------------ miramare 
" let g:miramare_enable_italic = 1 
" let g:miramare_disable_italic_comment = 1 
" colorscheme miramare 

set bg=dark
"COLOR SCHEME 
set t_Co=256 " Override terminal emulator color scheme
highlight Comment guifg=#4ADE80
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
" -------------------- ULTISNIPS - SNIPPETS TRIGGERS --------------------- 
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>" 

" -------------------- FZF File search --------------------------------------
nnoremap <C-g> :Rg<Cr>  
