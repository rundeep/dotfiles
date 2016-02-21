" Stand by this platitude:
" Don't put any lines in your vimrc that you don't understand.

" Environment {{{

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set shell=/bin/sh

" }}}

" Bundles config {{{

filetype off  "обязательно!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on     " Automatically detect file types.

" Репозитории на github

" First of all, we must manage the vundle package itself with vundle.
Plugin 'gmarik/vundle'

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'flazz/vim-colorschemes'

Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/tComment'
Bundle 'scrooloose/syntastic'

Bundle 'tpope/vim-pathogen'
Bundle 'CyCoreSystems/vim-cisco-ios'

Bundle 'Shougo/neocomplcache.vim'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
Bundle 'honza/vim-snippets'

Plugin 'bling/vim-airline'

Bundle 'vim-scripts/SyntaxRange'
Bundle 'vim-scripts/TaskList.vim'

Bundle 'sjl/gundo.vim'
Bundle 'fs111/pydoc.vim'
Bundle 'cburroughs/pep8.py'
Bundle 'alfredodeza/pytest.vim'
Bundle 'mitechie/pyflakes-pathogen'

Bundle 'rking/ag.vim'

Bundle 'sukima/xmledit'
Bundle 'vim-scripts/taglist.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'jeetsukumaran/vim-buffergator'

" Python autocompletion
Bundle 'davidhalter/jedi-vim'

" Vim syntax for i3 window manager config
Bundle 'PotatoesMaster/i3-vim-syntax'

" Для установки и обновления плагинов выполняем команду :BundleInstall

" }}}

" General {{{

syntax on                " Syntax highlighting

set modelines=1          " check just the final line of the file for a modeline
                         " which gives the settings for vim to use
scriptencoding utf-8
" Кодировка терминала, должна совпадать с той,
" которая используется для вывода в терминал
set termencoding=utf-8
" возможные кодировки файлов и последовательность определения.
set fileencodings=utf8,cp1251

" Отключить создание файлов бекапа и свопа
set nobackup
set nowritebackup
set noswapfile

set history=1000          " Store a ton of history (default is 20)
set hidden                " Allow buffer switching without saving

" }}}

" Vim UI {{{

if has('gui_running')
    " GUI colors
    set guifont=Inconsolata\ LGC\ 11
    set guioptions-=m  "hide menu bar
    set guioptions-=T  "hide toolbar
    set guioptions-=r  "hide scrollbar
    colorscheme pyte
else
    " Non-GUI (terminal) colors
    set t_Co=256                " Enable 256 colors to stop the CSApprox
                                " warning and make xterm vim shine
    set background=dark         " dark | light "
    colorscheme solarized       " Load a colorscheme
endif

set showmode                    " Display the current mode

set cursorline                  " Highlight current line

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
    " Selected characters/lines in visual mode
endif

if has('statusline')
    " Status line
    set laststatus=2
endif

set number                      " Line numbers on
"set relativenumber              "Prefer relative line numbering?
set showmatch                   " Show matching brackets/parenthesis
set hlsearch                    " Highlight search terms
set incsearch                   " Find as you type search
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches,
                                " then longest common part, then all.
" Folding
set foldenable                  " Enable folding
set foldlevelstart=10           " Open most folds by default
                                " Setting it to 99 would guarantee
                                " folds are always open.
set foldmethod=indent           " Fold based on indent level
set foldnestmax=10              " 10 nested fold max

" Show tabs and trailing characters.
set list
"set listchars=tab:»·,trail:•,extends:#,nbsp:.,eol:¬
set listchars=tab:»·,trail:•,extends:#,nbsp:.

" }}}

" Formatting {{{

set nowrap          " Do not wrap long lines
set autoindent      " Indent at the same level of the previous line
filetype indent on  " load filetype-specific indent files

set shiftwidth=4    " Use indents of 4 spaces
set tabstop=4       " Number of visual spaces per TAB
set softtabstop=4   " Number of spaces in tab when editing
set expandtab       " Tabs are spaces, not tabs

set nojoinspaces    " Prevents inserting two spaces
                    " after punctuation on a join (J)
set splitright      " Puts new vsplit windows to the right of the current
set splitbelow      " Puts new split windows to the bottom of the current

" }}}

" Autogroups {{{

" A nice way of marking just the first character
" going out of the specified bounds
augroup vimrc_autocmds
    autocmd!
    autocmd BufRead * highlight ColorColumn ctermbg=magenta "set color
    autocmd BufRead * call matchadd('ColorColumn', '\%81v', 100) "set column nr
augroup END

" This is a slew of commands that create language-specific settings
" for certain filetypes/file extensions. It is important to note they are
" wrapped in an augroup as this ensures the autocmd's are only applied once.
augroup configgroup
    " autocmd! Clears all the autocmd's for the current group
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufRead,BufNewFile *.vbi set filetype=vb
    autocmd BufRead,BufNewFile *.hta set filetype=html
    "  AsciiDoc
    autocmd BufRead,BufNewFile *.txt,*.asciidoc,README,TODO,CHANGELOG,NOTES,ABOUT
        \ setlocal autoindent expandtab tabstop=8 softtabstop=2 shiftwidth=2 filetype=asciidoc
        \ textwidth=70 wrap formatoptions=tcqn
        \ formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+
        \ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>
    " Formatting XML with indent command. Type gg=G and say "Hell yeah!"
    autocmd FileType xml setlocal
        \ equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
    " When working with HTML with embedded script,
    " the syntax highlighting often gets out of sync.
    autocmd BufEnter *.html,*.htm,*.hta :syntax sync fromstart
    " Syntax highlighting for files which contain Cisco ACL rules
    autocmd BufRead,BufNewFile *.acl,*.conf,*.cfg   set filetype=cisco
    "Automatically change current directory to that of the file in the buffer
    autocmd BufEnter * cd %:p:h
augroup END

" }}}

" Key (re)Mappings {{{
" nmap, vmap, imap описывают поведение комбинации клавишь в нормальном,
" визуальном и режиме вставки

" The default leader is '\', but many people prefer ','
" as it's in a standard location.
let mapleader = ','
" Ever notice a slight lag after typing the leader key + command? This lowers
" the timeout.
"set timeoutlen=500

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" space open/closes folds
nnoremap <space> za

"Helpeful abbreviations
iab lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
iab llorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
iab hellomylove Hello, my love! It's getting cold on this island. I'm sad alone, I'm so sad on my own. The truth is - we were much too young... Now I'm looking for you, or anyone like you. We said goodbye with the smile on our faces... Now you're alone, you're so sad on your own. The truth is - we run out of time. Now you're looking for me, or anyone like me.

"Spelling corrects. Just for example. Add yours below.
iab teh the
iab Teh The

" Get to home dir easier
" <leader>hm is easier to type than :cd ~
nmap <leader>hm :cd ~/ <CR>

" Bind Ctrl+<movement> keys to move around the windows,
" instead of using Ctrl+w + <movement>:
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Reformat paragraphs and list.
nnoremap <leader>r gq}

" Delete trailing white space and Dos-returns and to expand tabs to spaces.
nnoremap <leader>t :set et<CR>:retab!<CR>:%s/[\r \t]\+$//<CR>

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" highlight last inserted text
nnoremap gV `[v`]

" To save, ctrl-s.
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

" edit vimrc/bashrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>es :vsp ~/.bashrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Shortcuts for moving between tabs.
" Alt-j to move to the tab to the left
noremap <A-j> gT
" Alt-k to move to the tab to the right
noremap <A-k> gt

" To insert timestamp, press F3.
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %T")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %T")<CR>

" }}}

" Plugins {{{

" NerdTree {{{
map <C-e> :NERDTreeToggle<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
" }}}

" Buffergator {{{

" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tabnmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>

" }}}

" neocomplcache {{{
" Setting examples from https://github.com/Shougo/neocomplcache.vim

" Disable AutoComplPop.
let g:acp_enableAtStartup = 1
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.

let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'vb' : $HOME.'/dict/vbscript.dict',
            \ 'dosbatch' : $HOME.'/dict/dosbatch.dict',
            \ 'wsh' : $HOME.'/dict/wsh.dict',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}}

" Neosnippet {{{
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" }}}

" vim-airline {{{
" Set configuration options for the statusline plugin vim-airline.
" Use the powerline theme and optionally enable powerline symbols.
" To use the symbols , , , , , , and .in the statusline
" segments add the following to your .vimrc.before.local file:
"   let g:airline_powerline_fonts=1
" If the previous symbols do not render for you then install a
" powerline enabled font.

" See `:echo g:airline_theme_map` for some more choices
" Default in terminal vim is 'dark'

if isdirectory(expand("~/.vim/bundle/vim-airline/"))

    if !exists('g:airline_theme')
        let g:airline_theme = 'solarized'
    endif
    if !exists('g:airline_powerline_fonts')
        " Use the default set of separators with a few customizations
        let g:airline_left_sep='›'  " Slightly fancier than '>'
        let g:airline_right_sep='‹' " Slightly fancier than '<'
    endif

    " Automatically displays all buffers when there's only one tab open.
    let g:airline#extensions#tabline#enabled = 1

    " If you don't like the defaults, you can replace all sections with standard statusline syntax.
    " Give your statusline that you've built over the years a face lift.
    function! AirlineInit()
        let g:airline_section_b = airline#section#create(['%{strlen(&fenc)?&fenc:&enc} %{fugitive#statusline()}'])
        let g:airline_section_y = airline#section#create(['%04b'])
    endfunction
    autocmd VimEnter * call AirlineInit()

endif

" }}}

" syntastic {{{

let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_signs = 1
" This is optional but useful. Otherwise Syntastic will only check syntax after saving the file.
"let g:syntastic_check_on_open = 1

" Display all of the errors from all of the checkers together
let g:syntastic_aggregate_errors = 1

" The perl checker is now disabled by default (it's a security problem).
" To (re-)enable it:
let g:syntastic_enable_perl_checker = 1

" Local checkers for HTML5
let g:syntastic_html_tidy_exec = '/sbin/tidy'
" Disable syntax checking for a given filetype:
let g:syntastic_mode_map={ 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['html'] }

" Checkers can be chained together.
" This is telling syntastic to run the php checker first, and if no errors are found, run phpcs, and then phpmd.
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
"
" Configure the python checker to call a Python 2 interpreter rather than Python 3, e.g:
" let g:syntastic_python_python_exec = '/sbin/python2'

let g:syntastic_python_checkers=['python']
" Get the python3 incompatible warnings:
"let g:syntastic_python_checkers = ['pylint', 'pyflakes', 'flake8']

" }}}

" SyntaxRange {{{

autocmd BufEnter * :call SyntaxRange#Include("'start_vb{{", "'}}end_vb", 'vb')

" }}}

" CtrlP {{{

" Setup some default ignores
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
            \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
            \}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" order matching files top to bottom with ttb
let g:ctrlp_match_window = 'bottom,order:ttb'

" always open files in new buffers
let g:ctrlp_switch_buffer = 0

" run an external command to find matching files
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
"nmap <leader>bs :CtrlPMRU<cr>

" }}}

" Jedi-VIM {{{

" If you are a person who likes to use VIM-buffers not tabs,
" you might want to put that in your .vimrc:
let g:jedi#use_tabs_not_buffers = 0
" If you are a person who likes to use VIM-splits,
" you might want to put this in your .vimrc:
let g:jedi#use_splits_not_buffers = "left"

" }}}

" TaskList {{{
" Now you can hit <leader>td to open your task list and hit ‘q’ to close it.
" You can also hit enter on the task to jump to the buffer and line that it is placed on.
map <leader>td <Plug>TaskList

" }}}

" Ag (The Silver Searcher) {{{
nnoremap <leader>a :Ag
" }}}

" Gundo {{{
" It’ll allow you to view diff’s of every save on a file you’ve made
" and allow you to quickly revert back and forth
map <leader>g :GundoToggle<CR>
" }}}

" Pyflakes {{{
"I like to tell it not use the quickfix window:
let g:pyflakes_use_quickfix = 0
" }}}

" tComment {{{
map <leader>c <c-_><c-_>
" }}}


" }}} End Plugins

" Backup {{{

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" }}}

" Custom Functions {{{

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" }}}


" Special comments in a file that can declare certain
" Vim settings to be used only for that file:
" vim:foldmethod=marker:foldlevel=0
