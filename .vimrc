" vimrc example file:
"
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"Show line numbers
set number

"Vundle
filetype off  "Required for Vundle, will turn it back on later

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'nvie/vim-flake8'
" Plugin 'dusktreader/vim-flake8'  " Need to git checkout dusktreader/64_config_file_option
Plugin 'rdnetto/YCM-Generator'
Plugin 'w0rp/ale'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/ShowTrailingWhitespace'
Plugin 'mgedmin/python-imports.vim'
Plugin 'JamshedVesuna/vim-markdown-preview'
" All of your Plugins must be added before the following line
call vundle#end()            " required

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on


if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
" set statusline+=%F      " show full path of file in status bar
set statusline=%F\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P

" default tab spacings
set expandtab
set shiftwidth=4
set softtabstop=4

" Don't use Ex mode, use Q for formatting
"map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  nmap <silent> ,/ :nohlsearch<CR>
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

   set shellslash
  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
syntax on

"End of vimrc example file

set foldmethod=indent
set foldlevel=99

" Windows movement mappings
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" tab movement mappings
nmap tl gt
nmap th gT
nmap tn :$tabnew<CR>

" Redefine leader key from \ to ,
let mapleader=","

"For supertab plugin
"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"
"set completeopt=menuone,longest,preview
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
"autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Tag navigation remap
" To be figured out

" Color scheme
set t_Co=256
set background=light
colorscheme hemisu

" Shortcut to edit this file
nmap <silent> <leader>ev :e $MYVIMRC<cr>

" Allows edited buffers to be hidden
set hidden

"F5 mapping to run python scripts
autocmd BufRead *.py nmap <F5> :!python3 %<CR>


"Run Flake8 after every buffer save
" autocmd BufWritePost *.py call Flake8()

"Shortcut to insert breakpoints
nmap ,bp iimport pdb; pdb.set_trace();
nmap ,ibp ifrom shining_software.costmaps.map_drawing_utils import *;

"Remap esc key to jj
inoremap jj <esc>

"For Vim-Latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

"Always display file name and [+] sign
set laststatus=2

"Mappings for quickfix
nnoremap <leader>qq :cn<CR>
nnoremap <leader>qp :cp<CR>
nnoremap <leader>qc :cclose<CR>
nnoremap <leader>qf :cc 1<CR>

"Nerdcommenter remaps
let g:NERDCreateDefaultMappings = 0
nmap <leader>c <Plug>NERDCommenterToggle
vmap <leader>c <Plug>NERDCommenterToggle
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {'python': {'left': '#'}}

au FileType c,cpp,cu,h,hpp setlocal comments-=:// comments+=f://

"F5 mapping to run python scripts
autocmd FileType c,cpp,cu,h,hpp nmap <F5> :!make<CR>

"Have You complete me not prompt when loading .ycm_extra_conf.py file
let g:ycm_confirm_extra_conf=0
" turn on tag completion
let g:ycm_collect_identifiers_from_tags_files=1

"Close preview window after insertion
let g:ycm_autoclose_preview_window_after_insertion = 1

"Find (YcmComplete GoToReferences) mapping:
" nnoremap <leader>f :YcmCompleter GoToReferences<CR>
" nnoremap <leader>t :YcmCompleter GoTo<CR>

"Open with maximimzed window on Windows
au GUIEnter * simalt ~x

"For Latex suite (grep program for aut-completion)
"set grepprg="C:\Program Files (x86)\GnuWin32\bin\grep" -nH\ $*

let g:flake8_config_file=$HOME . '/.config/flake8'

"Tags mappings
nmap <leader>t g<C-]>
nmap <leader>p <C-W>g<C-]>
nmap <leader>b <C-T>
set tags=./tags;

"Vimgrep mapping
function ShiningPath()
	let l:src_path = expand('%:p')
	return substitute(l:src_path, '/src.*$','/src','')
endfunction

function GetRepoPath()
        let l:repo_path = systemlist('git rev-parse --show-toplevel')[0]
        return l:repo_path
endfunction
" nmap <leader>g "zyiw:exe "vimgrep /".@z."/gj ".GetRepoPath()."/**/*.py ".GetRepoPath()."/**/*.swift ".GetRepoPath()."/**/*.c* ".GetRepoPath()."/**/*.h* "

"ALE settings
let g:ale_set_quickfix = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

"Function to toggle doc checking on or off
command! -nargs=0 TestDoc call ToggleDocTestMode()
nnoremap <leader>doc :TestDoc<CR>

"Enable fzf
set rtp+=~/.fzf

" Customize fzf colors to match your color scheme

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


"Custom Ag command for fzf to search only file content
"and use root of search corresponding to the tags file
function! AgProjectFun(query, ...)
  if type(a:query) != type('')
    echom 'Invalid query argument'
    return
  endif
  let query = empty(a:query) ? '^(?=.)' : a:query
  let args = copy(a:000)
  let ag_opts = len(args) > 1 && type(args[0]) == type('') ? remove(args, 0) : ''
  let tagfile_list = tagfiles()
  let tagfile_path = empty(tagfile_list) ? '' : fnamemodify(tagfile_list[0], ':p:h')
  let command = ag_opts . ' ' . '--python --cpp --swift --color-path "0;32" --color-line-number "1;35"' . ' ' . fzf#shellescape(query) . ' ' . tagfile_path
  echo command
  return call('fzf#vim#ag_raw', insert(args, command, 0))
endfunction

"Searches only file contents:
command! -bang -nargs=* Agp call AgProjectFun(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
"Search file contents and filenames:
command! -bang -nargs=* Agp2 call AgProjectFun(<q-args>, <bang>0)

nnoremap <leader>f :Agp<CR>
nnoremap <leader>r "zyiw:Agp <C-R>z<CR>
nnoremap <leader>F :GFiles<CR>

"Turn off bracketed paste mode
set t_BE=

"Highlight trailing whitespaces
highlight ShowTrailingWhitespace ctermbg=Red guibg=Red

"Mapping for python auto-import
nmap <leader><Space> :ImportName<CR>

"Mouse scrolling for Mac...
" map <ScrollWheelUp> <C-Y>
" map <ScrollWheelDown> <C-E>
"

" Select specific directories to tags for some repos where tagging everything
" is too slow
let s:repo_to_tag_dir = {}
let s:repo_to_tag_dir.DE_SDoF = ['DE_DL']

"Updates ctags in current git project
function! UpdateTags()
    let l:repo_path = systemlist('git rev-parse --show-toplevel')[0]
    let l:repo_name = fnamemodify(l:repo_path, ':t')
    if (v:shell_error != 0)
	echo "Not inside a git repository, can't update tags"
	return
    endif
    let l:repo_path_rel = systemlist('git rev-parse --show-cdup')[0]
    if (match(l:repo_path_rel, '\.') == -1)
	let l:repo_path_rel = './'
    endif
    let l:ctags_file_path = l:repo_path . "/tags"
    " let l:command = "!git ls-files --full-name ". l:repo_path_rel . " | sed 's,^," . l:repo_path . "/,' | ctags --fields=+l -L - -f " . l:ctags_file_path

    " check if we are in a repo specified in s:repo_to_tag_dir variable
    if (has_key(s:repo_to_tag_dir, l:repo_name))
        let l:dirs_to_tag = ""
        for directory in s:repo_to_tag_dir[l:repo_name]
            let l:dirs_to_tag = l:dirs_to_tag . l:repo_path_rel . directory . " "
        endfor
    else
        let l:dirs_to_tag = l:repo_path_rel
    endif

    " let l:command = "!git ls-files --full-name ". l:repo_path_rel . " | sed 's,^," . l:repo_path . "/,' | ctags -L - -f " . l:ctags_file_path
    let l:command = "!git ls-files --full-name ". l:dirs_to_tag . " | sed 's,^," . l:repo_path . "/,' | ctags -L - -f " . l:ctags_file_path
    execute l:command
endfunction

"Options for vim-markdown-preview
let vim_markdown_preview_github=1

" disable ALE cc linter until i can make it work
let g:ale_linters_ignore = ['cc']

" Gblame
:command! Gblame Git blame
