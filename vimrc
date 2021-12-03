set path+=**
set nocompatible              " be iMproved, required
filetype off                  " required

let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" -----------------------------------------------------------------------------
"
" Plugins list 
"
" -----------------------------------------------------------------------------
if has('nvim')
    call plug#begin('~/.config/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" Copilot
Plug 'github/copilot.vim'

" Code autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" File explorer
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" Utility
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-fugitive' " Git util commands
Plug 'scrooloose/nerdcommenter'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'othree/html5.vim'
Plug 'mlaursen/vim-react-snippets'
Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
\}
Plug 'mattn/emmet-vim' " html/jsx tags generator

" Multiple Cursors like sublime text
Plug 'terryma/vim-multiple-cursors'

" Javascript support
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'

" TypeScript support 
Plug 'HerringtonDarkholme/yats.vim' 
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Golang support
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Svelte support
"Plug 'evanleck/vim-svelte', {'branch': 'main'}

" Dart / flutter support
"Plug 'dart-lang/dart-vim-plugin'
"Plug 'thosakwe/vim-flutter'

" Graphql support
Plug 'jparise/vim-graphql'

" JSX Support
Plug 'maxmellon/vim-jsx-pretty'

" Styled components support
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" PHP Support
"Plug 'phpvim/phpcd.vim'
"Plug 'StanAngeloff/php.vim'
"Plug 'stephpy/vim-php-cs-fixer'

" Godot support
"Plug 'calviken/vim-gdscript3'

" Markdown support
Plug 'tpope/vim-markdown'

" Style & themes
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine' " Display vertical lines
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'metalelf0/base16-black-metal-scheme'
Plug 'romainl/Apprentice'
Plug 'atelierbram/Base2Tone-vim'

" Initialize plugin system
call plug#end()

" -----------------------------------------------------------------------------
"
" Global Vim configuration 
"
" -----------------------------------------------------------------------------
syntax enable
let mapleader = ","
set encoding=UTF-8
"set backupcopy=yes
" Indentation
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set showcmd 
set wildmenu
if has('nvim')
    set wildoptions=pum
endif
set wildignore+=**/node_modules/**
set ls=2 " Always show status line
set wildmode=longest,list,full
set showtabline=2
"set colorcolumn=80

if has('nvim')
  set pumblend=10 " popup transparency (only neovim)
endif


" JS specifics
autocmd filetype javascript set sw=2 ts=2 expandtab
autocmd filetype dart set sw=2 ts=2 expandtab
" Golang / Python specifics
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype php setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4

" set 7 lines to the cursor = when moving vertically using j/k
set so=7
set ruler

" Enable Elite mode, No ARRRROWWS!!!!
let g:elite_mode=1

" Enable highlighting of the current line
"set cursorline

" Theme and Styling
set t_Co=256

if (has("termguicolors"))
  set termguicolors
endif

if has('nvim')
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
endif

set background=dark
let base16colorspace=256  " Access colors present in 256 colorspace

"colorscheme base16-dracula
colorscheme iceberg
"colorscheme dracula 
"colorscheme base16-black-metal 
"colorscheme Base2Tone_DrawbridgeDark
"colorscheme Base2Tone_EveningDark
"colorscheme nord
"colorscheme base16-nord
"colorscheme base16-tomorrow-night
"colorscheme OceanicNext
"colorscheme lucius 
"colorscheme jellybeans 
"colorscheme smyck 
"colorscheme grb256 
" only for grb256:
"highlight clear SignColumn

" Don't outdent hashes
inoremap # #

" Line numbers
set number

set hidden " switch buffers without saving to a currently modified file

" some languages servers have issues with backup files 
set nobackup
set nowritebackup
set noswapfile

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

set tw=0
set wm=0
set linebreak
set whichwrap+=>,l<,h

set lazyredraw
set showmatch

set backspace=indent,eol,start

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>.,trail:.,precedes:<,extends:>
set list

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

" clear selection
nnoremap ,<space> <CR>:nohlsearch<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

command! MakeTags !ctags -R .

" copy from system clipboard
set clipboard^=unnamed,unnamedplus
"set clipboard+=unnamedplus

" -----------------------------------------------------------------------------
"
" Plugins configuration
"
" -----------------------------------------------------------------------------

" CoC  - autocomplete

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Better display for messages 
set cmdheight=2 
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" coc extensions 
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-snippets',
      \ 'coc-pairs',
      \ 'coc-tsserver',
      \ 'coc-html',
      \ 'coc-json', 
      \ 'coc-yaml',
      \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" To make <cr> select the first completion item and confirm the completion when no item has been selected
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
if exists('*complete_info')
  inoremap <silent><expr> <cr> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap keys for snippets.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Copilot trigger remap to Ctrl + J
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""  UltiSnips
let g:UltiSnipsExpandTrigger='<c-space>'

" File explorer
" NERDTree Ctrl+n
map <C-b> :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline = 0

" go-vim plugin specific commands
" Also run `goimports` on your current file on every save
" Might be be slow on large codebases, if so, just comment it out
let g:go_fmt_command = "goimports"

" Status line types/signatures.
let g:go_auto_type_info = 1

"Javascript Docs
nmap <silent> <C-l> <Plug>(jsdoc)
let g:javascript_plugin_jsdoc = 1

" Ctrlp ignore
let g:ctrlp_custom_ignore = 'node_modules\|git'

" GitGutter
let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>

" emmet
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

" Airline fonts
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='Base2Tone_EveningDark'

" Search for selected text. press // after select
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" CtrlSF Search by text
nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordPath
vmap <C-F>F <Plug>CtrlSFVwordExec
nnoremap <C-F>t :CtrlSFToggle<CR>
let g:ctrlsf_auto_focus = {
    \ "at": "done",
    \ "duration_less_than": 1000
    \ }

let g:ctrlsf_ignore_dir = ["*.pyc", "*.pyo", ".next/", "_coverage/", "_build/", "build/", "_reports/", "_test-results/"]


"highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#444444
"highlight ColorColumn ctermbg=235 guibg=#101010

" if you want background transparency terminal: 
"hi Normal guibg=NONE ctermbg=NONE
"highlight clear LineNr
"highlight clear SignColumn
"highlight clear CursorLine
"highlight clear CursorLineNR
"highlight LineNr guifg=gray39
"set fillchars+=vert:│
"hi VertSplit ctermbg=NONE guibg=NONE
"hi Cursor       guifg=black     ctermfg=0   guibg=grey46 ctermbg=243
