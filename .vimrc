" Settings {{{
" Basic
set backspace=indent,eol,start             " Normal backspace behaviour
set number                                 " Display number line
set hidden                                 " Display hidden buffers in list
set signcolumn=auto                        " Display sign column
set autoread                               " Update file if changed outside
set incsearch                              " Turn on incremental search
set hlsearch                               " Highlight search term
set showmatch                              " Highlight matching paranthesis
set clipboard+=unnamed                     " System clipboard
set wrap                                   " Wrap long lines
set autoindent                             " Minimal auto indenting for any filetype
set lazyredraw                             " Only redraw when I tell you to

" Splits
set splitbelow                             " Split window opens below
set splitright                             " Split window opens right

" Complete options
set completeopt+=menuone,noinsert          " Open menu and no insert
set wildmenu                               " Turn menu on for wild searches

" Case
set smartcase                              " To ignore case in certain cases, overrides ignorecase
set ignorecase                             " Ignore case all together

" Backup settings
set sessionoptions-=options
set viewoptions-=options
set undofile                               " Set this option to have full undo power
set backup                                 " Set this option to enable backup
set writebackup                            " Set this option to write back up
set backupdir=$HOME/.vim/tmp/dir_backup//  " Back up dir
set directory^=$HOME/.vim/tmp/dir_swap//   " Swap file dir
set undodir=$HOME/.vim/tmp/dir_undo        " Undo dir

" Statusline
set laststatus=2                           " Display statusline
set ruler                                  " Set ruler in statusline
set statusline=\ ❮\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P\ ❯\ 

" Set wildmenu ignore
set path-=/usr/include
set path-=**/node_modules/**
set path=**
set wildignore=**/node_modules/**

" Grep
if executable('rg')
	set grepprg=rg\ --column\ --no-heading\ --smart-case\ --follow\ --vimgrep
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" Autocmd {{{
augroup GeneralSettings
	autocmd!
augroup END

" Auto close preview window
autocmd GeneralSettings CompleteDone * silent! pclose
autocmd GeneralSettings CursorMoved * silent! pclose

" Modify buffer colors
autocmd GeneralSettings ColorScheme * call functions#modifyBufferColors()

" Lsc colors
autocmd GeneralSettings ColorScheme * call functions#modifylscColors()

" Signify colors
autocmd GeneralSettings ColorScheme * call functions#modifySignifyColors()

" Create a new dir if it doesnt exists
autocmd GeneralSettings BufWritePre *
			\ if '<afile>' !~ '^scp:' && !isdirectory(expand('<afile>:h')) |
			\ call mkdir(expand('<afile>:h'), 'p') |
			\ endif

" Set cwd on bufenter
autocmd GeneralSettings BufEnter * silent! Glcd

" Auto-resize splits when Vim gets resized.
autocmd GeneralSettings VimResized * wincmd =

" Save session on exit
autocmd GeneralSettings VimLeavePre * call functions#sessionSave()

" Disable cursorline in insert mode
autocmd GeneralSettings InsertEnter * setlocal nocursorline
autocmd GeneralSettings VimEnter,InsertLeave * setlocal cursorline
"}}}


" Syntax {{{
filetype plugin indent on
syntax on
" }}}

" Plugins {{{
if empty(glob(substitute(&packpath, ",.*", "/pack/plugins/opt/minPlug", "")))
	call system("git clone --depth=1 https://github.com/Jorengarenar/minPlug ".substitute(&packpath, ",.*", "/pack/plugins/opt/minPlug", ""))
	autocmd VimEnter * nested silent! MinPlugInstall | echo "minPlug: INSTALLED"
endif

packadd minPlug
MinPlug arzg/vim-colors-xcode           " Xcode 11’s dark and light colourschemes, now for Vim!
MinPlug sheerun/vim-polyglot            " A solid language pack for Vim
MinPlug justinmk/vim-dirvish            " Directory viewer for Vim ⚡️
MinPlug tpope/vim-fugitive              " 💀 A Git wrapper so awesome, it should be illegal
MinPlug tpope/vim-eunuch                " Helpers for UNIX
MinPlug tpope/vim-dispatch              " Asynchronous build and test dispatcher
MinPlug tpope/vim-repeat                " repeat any command
MinPlug tpope/vim-surround              " quoting/parenthesizing made simple
MinPlug tpope/vim-commentary            " comment stuff out
MinPlug tpope/vim-unimpaired            " Pairs of handy bracket mappings
MinPlug romainl/vim-cool                " A very simple plugin that makes hlsearch more useful
MinPlug romainl/vim-qf                  " Tame the quickfix window
MinPlug godlygeek/tabular               " 🌻 A Vim alignment plugin
MinPlug markonm/traces.vim              " Range, pattern and substitute preview for Vim
MinPlug ciaranm/detectindent            " Vim script for automatically detecting indent settings
MinPlug christoomey/vim-tmux-navigator  " Seamless navigation between tmux panes and vim splits
MinPlug natebosch/vim-lsc               " A vim plugin for communicating with a language server
MinPlug mhinz/vim-signify               " ➕ Show a diff using Vim its sign column
set runtimepath^=~/.fzf                 " Source system fzf binary for fzf to run
MinPlug junegunn/fzf.vim                " fzf ❤️ vim

" Dirvish
let g:loaded_netrwPlugin = 1                     " disable netrw
let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r' " Sort dir at the top

" Vim-qf
let g:qf_mapping_ack_style = 1
" }}}

" Set this after vim polyglot has loaded {{{
" Set prettier as formatter
autocmd GeneralSettings FileType javascript,typescript,less,css,html,typescriptreact setlocal formatprg=prettier\ --stdin\ --stdin-filepath\ %
autocmd GeneralSettings FileType javascript,typescript,less,css,html,typescriptreact setlocal formatexpr=""
" }}}

" Visual {{{
colorscheme xcodedark
" }}}

" Commands {{{
" Grep for location list
command! -nargs=+ -complete=file -bar Grep lgetexpr functions#grep(<q-args>)
" Grep for location list
command! -nargs=0 -bar GrepWord lgetexpr functions#grep(expand('<cword>'))
" Git stash list
command! -nargs=0 Gstash :call functions#getGitStash()
" Run jest test watcher
command! -nargs=1 -complete=file JestSingleFile call functions#jestRunForSingleFile()
" Save sessions (force)
command! -nargs=0 SessionSave call functions#sessionSave()
" Load sessions
command! -nargs=1 -complete=customlist,functions#sessionCompletePath
			\ SessionLoad call functions#sessionLoad(<q-args>)
" Show all diagnostics
command! -nargs=0 AllDiagnostics execute 'LSClientAllDiagnostics'
" Yank paths
" Relative path
command -nargs=0 YRelative call functions#yankPath("relative")
" Full path
command -nargs=0 YAbsolute call functions#yankPath("full")
" Filename
command -nargs=0 Yfname call functions#yankPath("filename")
" Filename
command -nargs=0 Ydirectory call functions#yankPath("directory")
" }}}

" Abbr {{{
call functions#setupCommandAbbrs('w','update')
call functions#setupCommandAbbrs('sov','source $MYVIMRC')
call functions#setupCommandAbbrs('Mi','MinPlugInstall')
call functions#setupCommandAbbrs('gr','Grep')
call functions#setupCommandAbbrs('gp','Dispatch! git push')
call functions#setupCommandAbbrs('gl','Dispatch! git pull')
call functions#setupCommandAbbrs('gs','Gstash')
call functions#setupCommandAbbrs('slo','SessionLoad')
call functions#setupCommandAbbrs('ssa','SessionSave')
" }}}

" Mappings {{{
" Commands
nnoremap ; :
nnoremap : ;

" Omnifunc
" Completion pum
inoremap ,, <C-x><C-o>
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" keyword completion
inoremap        ,'      <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
" File name completion
inoremap        ,;      <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
" Whole line completion
inoremap        ,=      <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>

" Vertical movement with cursor center of screen
nnoremap j gjzz
nnoremap k gkzz

" Clear highlights
nnoremap <space>/ :nohlsearch<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" Terminal
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <space>te :tabe <bar> terminal<CR>

" Vim-qf
nmap <UP> <Plug>(qf_qf_toggle)
nmap <DOWN> <Plug>(qf_loc_toggle)

" Center search result line in screen
nnoremap n nzvzz
nnoremap N Nzvzz
nnoremap * *zvzz
nnoremap # #zvzz

" Substitute
nnoremap <space>sr :%s/<C-r><C-w>//gc<Left><Left><Left>
xnoremap <space>sr <Esc>:%s/<C-R><C-R>=<SID>functions#getVisualSelection()<CR>//gc<Left><Left><Left>

" CFDO
nnoremap <space>sc :cfdo %s/<C-r><C-w>//g \| update<S-Left><Left><Left><Left><Left><Left>
xnoremap <space>sc :cfdo %s/<C-R><C-R>=<SID>functions#getVisualSelection()<CR>//gc \| update<S-Left><S-Left><Left><Left><Left><Left>

" Tabularize
xnoremap ga :Tabularize /
xnoremap g" :Tabularize / ".*<CR>
nnoremap ga :Tabularize /

" Format buffer
nnoremap gQ gggqG

" Previous buffer
nnoremap <backspace> <C-^>
nnoremap gb :ls<CR>:b<Space>

" Open last searched qf
nnoremap <silent> <space>gr :execute 'Grep '.@/.' %'<CR>

" Window
nnoremap <space>w <C-w>

" Yank relative path
" TODO: Create a function that takes a type and returns the file path, file name or
" the full file path
nnoremap <space>yr :let @+ = expand("%")<CR>
" }}}
