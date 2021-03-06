""""""""""""""""""""""""""""""""""""""""""""""""
" Generic setup
""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

let mapleader = ","


"""""""""""""""""""""""""""
" Python Setup
"""""""""""""""""""""""""""
let g:python_host_prog = '/Users/dheldt/code/vev2/bin/python'
let g:python3_host_prog = '/Users/dheldt/code/vev3/bin/python'

"""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""
" Turn on the Wild menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/tmp/*,*.zip
" Always show current position
set ruler
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Find words as typing out search
set incsearch
" Start scrolling before cursor hits top/bottom
set scrolloff=5
" Number of lines to jump when scrolling off screen
" -# = percentage
set scrolljump=-10

" Set the paste toggle
map <F10> :set paste<cr>
map <F11> :set nopaste<cr>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>

" Quick funtion that will
" highlight over 80 columns
autocmd FileType cpp :autocmd! BufWritePre * :match ErrorMsg '\%>80v.\+'

" Use Unix as the standard file type
set ffs=unix,mac,dos

""""""""""""""""""""""""""""
" => Tags
""""""""""""""""""""""""""""
" setup tags
set tags=./.tags;/

""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc.
set nobackup
set nowb
set noswapfile

" Echo the full path of file being edited
nnoremap <leader>path :echo expand('%:p')<cr>

" Source and Edit nvim/init
nnoremap <leader>src :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>erc :vsp ~/.config/nvim/init.vim<cr>

" Sudo save a file
nnoremap <leader>save :w !sudo dd of=%<cr>

""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Do not expand tab for Makefiles
autocmd FileType make set noexpandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Auto indent and wrap lines
set ai
set wrap

" Set the backspace to work as expected
set backspace=2

" Auto remove trailing whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

"""""""""""""""""""""""""""""""""""
" Grep
"""""""""""""""""""""""""""""""""""
" nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
" vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>
"
" function! GrepOperator(type)
"     if a:type ==# 'v'
"         normal! `<v`>y
"     elseif a:type ==# 'char'
"         normal! `[v`]y
"     else
"         return
"     endif
"
"     silent execute "grep! -nHIRs " . shellescape(@@) . " ."
"     copen
" endfunction

"""""""""""""""""""""""""""""""""""
" Window Management Stuff
"""""""""""""""""""""""""""""""""""
" Move to next or previous tab
nnoremap <leader>T :tabn<cr>
nnoremap <leader>P :tabp<cr>

" Increase and Decrease the width of a vertically split window
nnoremap <leader>< :vertical resize -10<cr>
nnoremap <leader>> :vertical resize +10<cr>

" Rotate panes
nnoremap <leader>wvh <C-w>t<C-w>K
nnoremap <leader>whv <C-w>t<C-w>H

set background=dark

"""""""""""""""""""""""""""""""""""
" Neovim terminal support
"""""""""""""""""""""""""""""""""""
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

"""""""""""""""""""""""""""""""""""
" Operator Maps
"""""""""""""""""""""""""""""""""""
" Operator maps to get inside () '' and "
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap in) :<c-u>normal! F)vi)<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap in} :<c-u>normal! F}vi}<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap in] :<c-u>normal! F]vi]<cr>
onoremap in' :<c-u>normal! f'vi'<cr>
onoremap il' :<c-u>normal! F'vi'<cr>
onoremap in" :<c-u>normal! f"vi"<cr>
onoremap il" :<c-u>normal! F"vi"<cr>

""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug setup
""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

" ##### APPEARENCE #####
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='distinguished'

Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'

Plug 'kien/rainbow_parentheses.vim', {'on': 'RainbowParenthesesToggleAll'}
nnoremap <leader>( :RainbowParenthesesToggleAll<cr>

Plug 'junegunn/goyo.vim'
nnoremap <leader>clear :Goyo<CR>
Plug 'junegunn/limelight.vim'
let g:limelight_default_coefficient = 0.7
let g:limelight_conceal_ctermfg = 238
nmap <silent> gl :Limelight!!<CR>
xmap <silent> gl <Plug>(Limelight)

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_exclude_filetypes = ['help', 'startify', 'man', 'rogue']

Plug 'machakann/vim-highlightedyank'

" ##### APPEARENCE #####


" ##### TEXT MANIPULATION #####
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'tmhedberg/matchit'

Plug 'godlygeek/tabular', {'on': 'Tabularize'}
" see http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
if exists(":Tabularize")
    nnoremap <leader>a= :Tabularize /=<CR>
    vnoremap <leader>a= :Tabularize /=<CR>
    nnoremap <leader>a: :Tabularize /:\zs<CR>
    vnoremap <leader>a: :Tabularize /:\zs<CR>
endif
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
" end tabularize

inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

" ##### TEXT MANIPULATION #####

" ##### COMPLETION #####
Plug 'SirVer/ultisnips'
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsListSnippets="<c-s-tab>"
let g:ultisnips_python_style="sphinx"

if has('nvim')
    Plug 'shougo/deoplete.nvim'

    if exists(':DeopleteEnable')
        let g:deoplete#enable_at_startup = 1
    endif
endif

Plug 'honza/vim-snippets'
Plug 'spiroid/vim-ultisnip-scala'


if has('nvim')
  Plug 'neovim/node-host', {'do': 'npm install'}
endif

" ##### NAVIGATION #####
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-repeat'

Plug 'scrooloose/nerdtree', {'on':  'NERDTreeToggle'}
nnoremap <F6> :NERDTreeToggle<cr>

Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fc :Colors<CR>
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <Leader>bb :Buffers<CR>
nnoremap <silent> <Leader>; :Commands<CR>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>ll :Lines<CR>
nnoremap <silent> <Leader>lb :BLines<CR>
nnoremap <silent> <Leader>tt :Tags<CR>

Plug 'majutsushi/tagbar'
nnoremap <leader>tag :TagbarOpen fjc<cr>

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_enabled = 0
let g:gutentags_ctags_exclude = [
  \ '*.min.js',
  \ '*html*',
  \ '*/vendor/*',
  \ '*/node_modules/*',
  \ ]
nnoremap <leader>t! :GutentagsUpdate!<CR>

" let g:grepper = {
"     \ 'tools': ['ag', 'git', 'grep'],
"     \ }
" nnoremap <leader>git :Grepper -tool git<cr>
" nnoremap <leader>ag :Grepper -tool ag -grepprg ag --vimgrep<cr>
" nmap gs <plug>(GrepperOperator)
" xmap gs <plug>(GrepperOperator)

" ##### NAVIGATION #####

" ##### UTILITIES #####
Plug 'Shougo/junkfile.vim'
nnoremap <leader>jo :JunkfileOpen
let g:junkfile#directory = $HOME . '/.nvim/cache/junkfile'

Plug 'janko-m/vim-test'
function! TerminalSplitStrategy(cmd) abort
	tabnew | call termopen(a:cmd) | startinsert
endfunction
let g:test#custom_strategies = get(g:, 'test#custom_strategies', {})
let g:test#custom_strategies.terminal_split = function('TerminalSplitStrategy')
let test#strategy = 'terminal_split'
nnoremap <silent> <leader>rr :TestFile<CR>
nnoremap <silent> <leader>rf :TestNearest<CR>
nnoremap <silent> <leader>rs :TestSuite<CR>
nnoremap <silent> <leader>ra :TestLast<CR>
nnoremap <silent> <leader>ro :TestVisit<CR>

" ##### LANGUAGES #####
Plug 'rizzatti/dash.vim', {'on': 'Dash'}
nmap <silent> <leader>d <Plug>DashSearch

" Plug 'scrooloose/syntastic'
" Plug 'benekastah/neomake'
" let g:neomake_python_enabled_makers = ['flake8']
" let g:neomake_python_flake8_maker = {
"     \ 'args': ['--ignore=E501']
"     \ }
" let g:neomake_error_sign = {
"     \ 'text': '✗',
"     \ }
" let g:neomake_warning_sign = {
"     \ 'text': '⚠',
"     \ }
" let g:neomake_info_sign = {
"     \ 'text': '>',
"     \ }
" let g:neomake_airline = 1
"
" autocmd! BufReadPost * Neomake
" autocmd! BufWritePost * Neomake
" end neomake
Plug 'w0rp/ale'
let airline#extensions#ale#enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_python_flake8_args = '--ignore E501 '
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

Plug 'motus/pig.vim', {'for': ['pig']}
Plug 'fatih/vim-go', {'for': ['go']}
Plug 'mitsuhiko/vim-jinja', {'for': ['jinja']}
Plug 'mxw/vim-jsx', {'for': ['jsx']}
Plug 'stephpy/vim-yaml', {'for': ['yaml']}
Plug 'cespare/vim-toml', {'for': ['toml']}
Plug 'mattn/emmet-vim', {'for': ['html', 'css']}
Plug 'hdima/python-syntax', {'for': ['python']}
Plug 'vim-scripts/SQLUtilities', {'for': ['sql']}
Plug 'hashivim/vim-hashicorp-tools', {'for': ['terraform']}
Plug 'leafgarland/typescript-vim', {'for': ['typescript']}
Plug 'Quramy/vim-js-pretty-template', {'for': ['typescript', 'javascript']}
Plug 'jason0x43/vim-js-indent', {'for': ['typescript', 'javascript']}
Plug 'Quramy/vim-dtsm', {'for': ['typescript']}
Plug 'mhartington/vim-typings', {'for': ['typescript']}
Plug 'ekalinin/Dockerfile.vim', {'for': ['dockerfile']}

Plug 'rust-lang/rust.vim', {'for': ['rust']}
let g:rustfmt_autosave = 1
Plug 'racer-rust/vim-racer', {'for': ['rust']}
set hidden
let g:racer_cmd = "/Users/akinsley/.cargo/bin/racer"
let g:racer_experimental_completer = 1

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

Plug 'davidhalter/jedi-vim', {'for': ['python']}
Plug 'zchee/deoplete-jedi', {'for': ['python']}

Plug 'elzr/vim-json', {'for': ['json']}
autocmd FileType json setlocal foldmethod=syntax


Plug 'derekwyatt/vim-scala', {'for': ['scala', 'sbt.scala']}
Plug 'ensime/ensime-vim', {'for': ['scala', 'java', 'sbt.scala']}
" autocmd BufWritePost *.scala silent :EnTypeCheck
nnoremap <localleader>tc :EnTypeCheck<CR>
nnoremap <localleader>ti :EnInspectCheck<CR>
nnoremap <localleader>tp :EnTypeCheck<CR>

au BufNewFile,BufRead Jenkinsfile set filetype=groovy

" Jump to Declarations
au FileType scala nnoremap <leader>gd :EnDeclarationSplit v<CR>
au FileType scala nnoremap <leader>si :EnSuggestImport<CR>

" Suggest Import
nnoremap <silent> <leader>I :EnSuggestImport<CR>

" Remap omnicomplete
inoremap <C-o> <C-X><C-O>
" Use Tab and Shift-Tab
inoremap <expr> <TAB> pumvisible() ? '<C-n>' : '<TAB>'
inoremap <expr> <S-TAB> pumvisible() ? '<C-p>' : '<S-TAB>'
" Map the Enter type to do <C-Y> to select without a newline in omicomplete
inoremap <expr> <CR> pumvisible() ? '<C-Y>' : '<CR>'
" ##### LANGUAGES #####

" ##### GIT #####
Plug 'airblade/vim-gitgutter'
let g:gitgutter_diff_args = '--ignore-space-at-eol'
nmap [h <Plug>GitGutterPrevHunk
nmap ]h <Plug>GitGutterNextHunk

call plug#end()

colorscheme gruvbox
