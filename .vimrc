"My Vimrc file (edited by dhuang)
"Maintainer: www.swaroopch.com/contact/
" Reference: Initially based on
"http://dev.gentoo.org/~ciaranm/docs/vim-guide/
" License: www.opensource.org/licenses/bsd-license.php


" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side
" effect.
set nocompatible

" Enable syntax highlighting.
syntax enable
syntax on

" Automatically indent when adding a curly bracket, etc.
set smartindent

" Tabs should be converted to a group of 4 spaces.
" This is the official Python convention
" (http://www.python.org/dev/peps/pep-0008/)
" I didn't find a good reason to not use it everywhere.
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=999

" Use UTF-8.
set encoding=utf-8

" Set color scheme that I like.
if has("gui_running")
colorscheme evening 
else
colorscheme evening 
endif

" Status line
set laststatus=2
set statusline=
set statusline+=%-3.3n\
set statusline+=%f\
set statusline+=%h%m%r%w
set statusline+=\[%{strlen(&ft)?&ft:'none'}]
set statusline+=%=
set statusline+=0x%-8B
set statusline+=%-14(%l,%c%V%)
set statusline+=%<%P

" Show line number, cursor position.
set ruler

" Show line number
set number

" Display incomplete commands.
set showcmd

" To insert timestamp, press F3.
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

" To save, press ctrl-s.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Search as you type.
set incsearch

" Ignore case when searching.
set ignorecase

" Show autocomplete menus.
set wildmenu

" Show editing mode
set showmode

" Error bells are displayed visually.
set visualbell
" Enable plugin
" for older version
"filetype plugin on
"after version 7.3,indent setting was moved to indent plugin
filetype plugin indent on

" Turn on omnicompletion
" turn off by dhuang at 2011-01-29 Sat 07:39 PM due to the shortcut
" conflict with neocomplete 
"set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType sql set omnifunc=sqlcomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete
"the fortran omnifunc is untest yet
"autocmd FileType fortran set omnifunc=fortrancomplete#Complete
if has("autocmd") && exists("+omnifunc")
        autocmd Filetype *
                \   if &omnifunc == "" |
                        \       setlocal omnifunc=syntaxcomplete#Complete |
                                \   endif
                                endif


"setting defalt key bind for supertab
"no need to enable anymore
"let g:SuperTabDefaultCompletionType="<c-j>"

" Enable code folding for fortran
let fortran_fold=1


" Folding code by syntax
set foldmethod=syntax

" Auto expand all the folding code when file is open.
set foldlevelstart=99 

" setting up Map leader to the value of system default
" backslash('\')
" this leader was used in the Nerdcommenters plug in
let mapleader = "\\"

"start winmanager when program begin
let g:winMandowLayout='FileExplorer|TagList|BufExplorer'
let g:persistentBehaviour=0
let g:winManagerWidth=35      
nmap <F5> :WMToggle<cr> 
"nmap <F5> :WMToggle<cr>:ConqueTermSplit bash<cr> <ESC>:resize 7<cr>:setlocal winfixheight<cr>i 
"ConqueTerm setup for using bash in vim
"let g:ConqueTerm_ToggleKey ='<F6>'
"let g:ConqueTerm_ReadUnfocused = 1
"let g:ConqueTerm_InsertOnEnter = 1
"let g:ConqueTerm_CWInsert = 1 
"let g:COnqueTerm_CloseOnEnd = 1

"allow using mouse if it is available
set mouse=a

"press ENTER to add a new line after current line but not go into insert
"mode
"press SHIFT+ENTER to add a new line before current line but not go into
"insert mode
map <cr> o<Esc>j 
map <S-Enter> O<Esc>k

"set tags position
set tags=tags

""" restore cursor to file position in previous editing session
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

""show function/method prototypes in the list
let Tlist_Display_Prototype=1

"enable vim-latex-suite
"set grepprg=grep\ -nH\ $*
"let g:tex_flavor='latex'
"filetype indent on
"
"
"” Buffer navigation (Ctrl+Tab / Ctrl+Shift+Tab)
nnoremap <C-Tab> :bnext<CR>
nnoremap <C-S-Tab> :bprevious<CR>
"
"set fix height for  preview window
set previewheight =7

"" Automatically open, but do not go to (if there are errors) the quickfix /
"" location list window, or close it when is has become empty.
""
"" Note: Must allow nesting of autocmds to enable any customizations for quickfix
"" buffers.
"" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
"" (but not if it's already open). However, as part of the autocmd, this doesn't
"" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""" Language Specific setting """""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable("Makefile")
    set makeprg=make
el
    autocmd FileType c   set makeprg=gcc\ -pg\ -O2\ -Wall\ %
    autocmd FileType cpp set makeprg=g++\ -pg\ -O2\ -Wall\ %
    autocmd FileType fortran  set makeprg=gfortran\ -pg\ -O2\ -Wall\ %
endif
    autocmd FileType python   set makeprg=python\ -d\ %
""set errformat for gfortran
autocmd FileType fortran set efm=%A%f:%l.%c:,%A%f:%l:,%C,%C%p%*[0123456789^],%Z%trror:\ %m,%Z%tarning:\ %m,%C%.%#
"set errformat for intel fortran
"set efm=%E%.%#rror:\ %f\\,\ line\ %l:\ %m,\%-C%.%#,\%-Z\%p^
"let isf="@,48-57,/,.,-,_,+,#,^,,$,%,~,="
autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
"Compile Program/Running Script with keyboard shortcut F7
map <buffer> <F7> :w<CR>:make<CR>
" execute project related configuration in current directory
if filereadable("workspace.vim")
    source workspace.vim
el
    set path=.,/usr/include,''
endif 

"supertab setting
let g:SuperTabDefaultCompletionType="context"
"auto save file when switch buffers
set autowrite
set autoread
