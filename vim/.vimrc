" ~/.vimrc

" Section: Init ============================================          {{{

" Preamble -------------------------------------------------          {{{
inoremap jk <Esc>

filetype plugin indent on
set nocompatible
" }}}

" Leader.Mappings ------------------------------------------         {{{
let mapleader = "-"
let maplocalleader = ","
" END Leader.Mappings }}}

" END.Init }}}

" Section: Options =========================================          {{{

" General options ------------------------------------------          {{{
set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set colorcolumn=+1
set cursorline          " Highlight the cursor line
set diffopt+=vertical
set expandtab

" Save your swap files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" set hidden
set history=1000
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set linebreak
set list
" set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
" List- and fillchars --------------------------------------          {{{
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
  let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  let &fillchars = "vert:\u259a,fold:\u0020"
else
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<
endif
"" END List- and fillchars }}}
set matchtime=3
set modelines=1
set number
set norelativenumber
set nowrap
set ruler
set scrolljump=2        " Faster scrolling
set shiftround
set showbreak=↪
set showcmd
set showmode
set sidescrolloff=5
set signcolumn=number
set title
set ttyfast
if isdirectory($HOME . '/.vim/undo') == 0
  :silent !mkdir -p ~/.vim/undo >/dev/null 2>&1
endif
set undodir=~/.vim/undo
set undofile
set undoreload=10000
set visualbell

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

nnoremap Y y$

set shiftwidth=4
set tabstop=4

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    if &grepformat !~# '%c'
        set grepformat^=%f:%l:%c:%m
    endif
else
    set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude=tags
endif
" }}}


" Wild Menu ----------------------------------------------- {{{
set wildmenu
set wildmode=list:full
set wildignore+=tags,.*.un~,*.swp,*.bak
set wildignore+=*.pyc,*.class
set wildignorecase
" }}}

" Status Line --------------------------------------------- {{{
let g:vimrc_statusline = 1
function! ToggleStatusLine() " {{{
    if exists("g:vimrc_statusline") == 1 && g:vimrc_statusline == 1
        let g:vimrc_statusline = 0
        set statusline =
        let &statusline = "%1*[%n]%*"
        let &statusline .= " %.20{fnamemodify(getwinvar(0, 'getcwd', getcwd()), ':t')} "
        let &statusline .= "%{&readonly ? '-' : &modified ? '+' : ''}"
        let &statusline .= "\u2502 %<%f "
        let &statusline .= "[%B \u2502 %b]"
        let &statusline .= "%="
        let &statusline .= "%{&binary == 1 ? \"\u2502 binary\" : ''} "
        let &statusline .= "\u2502 %{&fileencoding} "
        let &statusline .= "\u2502 %{&fileformat} "
        let &statusline .= "\u2502 %{&filetype == '' ? 'unknown' : &filetype} "
        let &statusline .= "\u2502 %l:%2c \u2502 %p%% \u2502"
    else
        let g:vimrc_statusline = 1
        set statusline =
        let &statusline = "%1*[%n]%*"
        let &statusline .= " %.20{fnamemodify(getwinvar(0, 'getcwd', getcwd()), ':t')} "
        let &statusline .= "%{&readonly ? '-' : &modified ? '+' : ''}"
        let &statusline .= "\u2502 %<%f "
        let &statusline .= "%="
        let &statusline .= "%{&binary == 1 ? \"\u2502 binary\" : ''} "
        let &statusline .= "[%{&filetype == '' ? 'unknown' : &filetype}\u2502"
        let &statusline .= "%l:%2c\u2502%p%%]"
    endif
endfunc "}}}
call ToggleStatusLine()
nnoremap <Leader>ts :call ToggleStatusLine()<CR>
" }}}


" Set path {{{
set path=.,,
" TODO: Set include, includeexpr, etc
" }}}

" Colors ---------------------------------------------------          {{{
" Put all edits to colorschemes into ~/.vim/after/colors/{colorscheme}.vim
" and source this file everytime a colorscheme is set
function! JJAfterColors()
    if exists('g:colors_name') && strlen(g:colors_name)
        execute 'runtime! after/colors/' . g:colors_name . '.vim'
    endif
endfunc
augroup JJAfterColors
    autocmd!
    autocmd Colorscheme * call JJAfterColors()
augroup END

let g:solarized_termcolors = 256
set background=dark
packadd badwolf
colorscheme badwolf
" End.Colors }}}

" Tags -----------------------------------------------------          {{{
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    elseif filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    endif
endif
" End.Tags }}}

" Plugin Options -------------------------------------------         {{{

" VimWiki: -------------------------------------------------        {{{
let wiki_1 = {}
let wiki_1.path = '~/Documents/neo/wiki/src/'
let wiki_1.path_html = '~/Documents/neo/wiki/html/'
let wiki_1.template_path = '~/.vimwiki/templates/'
let wiki_1.template_default = 'default'
let wiki_1.template_ext = '.html'
let wiki_1.auto_export = 1
let wiki_1.nested_syntaxes = {
    \ 'asciidoc': 'asciidoc',
    \ 'cypher': 'cypher',
    \ 'js': 'javascript',
    \ 'python': 'python',
    \ 'sh': 'sh',
    \ 'vim': 'vim',
    \ 'java': 'java',
    \ 'docbk': 'docbk'
    \ }

let g:vimwiki_list = [wiki_1]
" END.VimWiki }}}
"
" END.Plugin Options }}}

" END.Options }}}

" Section: Mappings ========================================          {{{

" New.Mappings ---------------------------------------------          {{{

" Purpose: Center the screen after jumping to a mark
" Added: 2016-04-08
" Source: http://stackoverflow.com/questions/13409774/vim-center-screen-position-on-current-line-after-jumping-to-a-mark/13410481
map <expr> M printf('`%c zz',getchar())

" Purpose: Search for visual selection (one-line 'visual star' plugin)
" Added: 2016-02-26
" Source: http://vi.stackexchange.com/questions/6208/how-to-search-for-lines-matching-current-line-in-vim
xnoremap * :<c-u>let @/=@"<cr>gvy:let [@/,@"]=[@",@/]<cr>/\V<c-r>=substitute(escape(@/,'/\'),'\n','\\n','g')<cr><cr>

" Purpose: Open file under cursor in a vertical split
" Added: 2016-02-28
" Source: Me @ http://vi.stackexchange.com/questions/3364/open-filename-under-cursor-like-gf-but-in-a-new-tab-or-split/3369#3369
nnoremap <C-W><C-F> <C-W>vgf

" Purpose: Expand completion for coc.vim
" Added: 2020-08-06
" Source: https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-tab-or-custom-key-for-trigger-completion
inoremap <silent><expr> <Tab> pumvisible()?"\<C-n>":<SID>check_back_space()?"\<Tab>":coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" }}}

" Navitaion ------------------------------------------------          {{{
nnoremap <Tab> <C-W><C-W>
nnoremap <S-Tab> <C-W><S-W>
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>

"""""""""""""""""""""""
" JUGGLING WITH FILES "
"""""""""""""""""""""""
nnoremap <LocalLeader>f :find *
nnoremap <LocalLeader>F :find <C-R>=expand('%:p:h').'/**/*'<CR>
nnoremap <LocalLeader>s :sfind *
nnoremap <LocalLeader>S :sfind <C-R>=expand('%:p:h').'/**/*'<CR>
nnoremap <LocalLeader>v :vert sfind *
nnoremap <LocalLeader>V :vert sfind <C-R>=expand('%:p:h').'/**/*'<CR>
nnoremap <LocalLeader>t :tabfind *
nnoremap <LocalLeader>T :tabfind <C-R>=expand('%:p:h').'/**/*'<CR>

"""""""""""""""""""""""""
" JUGGLING WITH BUFFERS "
"""""""""""""""""""""""""
nnoremap <LocalLeader>b :buffer *
nnoremap <LocalLeader>B :sbuffer *
" }}}

" Editing --------------------------------------------------          {{{
" Edit .vimrc in a split window
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
" END.Editing}}}

" Normal.Mappings ------------------------------------------          {{{

"" Path/Find/Search options and bindings -------------------          {{{
if executable('ag')
    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap <silent> <Leader>K :grep! "\b\s?<C-R><C-W>\b"<CR>:cw<CR>
endif
"}}}

" END Normal.Mappings }}}

" END.Mappings }}}

" Section: FileSettings ====================================          {{{

" Vimscript.FileSettings -----------------------------------          {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim nnoremap <buffer> <localleader>c gI" <ESC>j
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" END Vimscript.FileSettings }}}

" Vimwiki.FileSettings -------------------------------------          {{{
" To prevent vimwiki from using a particular binding we can provide our own
" binding first. We have to do so before vimwiki/ftplugin/vimwiki.vim is
" sourced.
augroup filetype_vimwiki
    autocmd!
    autocmd FileType vimwiki nmap <buffer> <A-TAB> <Plug>VimwikiNextLink
    autocmd FileType vimwiki nmap <buffer> <S-A-TAB> <Plug>VimwikiPrevLink
augroup END
" Other filesettings in after-ftplugin:
" ~/.vim/after/ftplugin/vimwiki.vim
" END Vimwiki.FileSettings }}}

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.pdc set filetype=markdown.pandoc
augroup END

" END.FileSettings }}}

" Section: CoCSettings =====================================          {{{
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)
" }}}

" Section: UNSORTED {{{

" guioptions -------------------------------------------------------------- {{{
" Use <C-L> to clear some highlighting
nnoremap <silent> <C-L> :silent! call matchdelete(b:ring)<CR>:nohlsearch<CR><C-L>

" Scrollbars: Remove both right and left hand scrollbars....           {{{
if has("gui")
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    set guifont=Ubuntu\ Mono\ 11
endif
" }}}
" END.guioptions }}}

" Cursor: Stop cursor blinking..............................           {{{
if has("gui")
    exe "set guicursor+=a:blinkon0"
endif
" END.Cursor }}}

" {{{ Stuff
" }}}

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

" Plugins: -----------------------------------------------          {{{
let g:calendar_views = ['year', 'month', 'week', 'day_4', 'day', 'clock', 'event', 'agenda']


" }}}


" FROM: https://coderwall.com/p/lxajqq/vim-function-to-unminify-javascript
" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction

command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis

nnoremap <localleader>fileline :let @+ = expand('%:p') . ":" . line('.')<CR>


" Insert current date in the format, e.g., 2015-05-30
inoremap <localleader>date <C-r>=strftime("%Y-%m-%d")<CR>
" Insert localtime (seconds since 'epoch')
inoremap <LocalLeader>time <C-r>=localtime()<CR>

" calendar.vim --------------------------------------------          {{{
augroup filetype_calendar
    autocmd!
    autocmd FileType calendar nnoremap <buffer> <CR> :<C-u>call vimwiki#diary#calendar_action(b:calendar.day().get_day(), b:calendar.day().get_month(), b:calendar.day().get_year(), b:calendar.day().week(), "V")<CR>
    autocmd FileType calendar nnoremap <buffer> fj :echo SWONK<CR>
augroup END
" END.calendar.vim }}}
" END.Unsorted }}}

" Define an empty augroup for ad hoc use
augroup adhoc
    autocmd!
augroup END


"" Aesthetics ----------------------------------------------          {{{
" Display highlight group tree for character under cursor
nnoremap <leader>ch :echo JJHiTrace()<CR>
" Display where the color was last set for character under cursor
nnoremap <leader>C :echo JJFindColorScheme()<CR>
" Edit colorscheme for last color set under cursor
nnoremap <leader>ce :exec "vsplit " . JJFindColorScheme()<CR>
" Reload current colorscheme
nnoremap <leader>cc :exec "colorscheme " . colors_name<CR>

function! JJFindColorScheme() "{{{
    let colorschemename = g:colors_name
    redir => ex_result
        silent! verbose hi normal
    redir END
    let colorscheme_file = matchstr(ex_result, '\f*' . g:colors_name . '.vim')
    if empty(colorscheme_file)
        echohl WarningMsg
        echo "No color scheme found! (".g:colors_name.")"
        echohl Normal
    endif
    return colorscheme_file
endfunction "}}}

" Copy of HiLinkTrace() from hilinks.vim -- read hilink info into @a
"
" HiLinkTrace() echoes (as opposed to returns) its output. Normally one could
" catch that with a :redir, but the function itself uses :redir and nested
" :redir is not possible
" (http://stackoverflow.com/questions/16626155/in-vim-how-do-i-redirect-the-output-of-a-vimscript-function)
"
" This function is identical except it returns the output.
function! JJHiTrace() " {{{
    if !exists("g:hilinks_fmtwidth")
         let g:hilinks_fmtwidth= 35
     endif

    redir @a
    silent! highlight
    redir END

    let firstlink = synIDattr(synID(line("."),col("."),1),"name")
    let lastlink  = synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
    let translink = synIDattr(synID(line("."),col("."),0),"name")
    " if transparent link isn't the same as the top highlighting link,
    " then indicate it with a leading "T:"
    if firstlink != translink
        let hilink= "T:".translink."->".firstlink
    else
        let hilink= firstlink
    endif

    " trace through the linkages
    if firstlink != lastlink
        let no_overflow= 0
        let curlink    = firstlink
        while curlink != lastlink && no_overflow < 10
            let no_overflow = no_overflow + 1
            let nxtlink     = substitute(@a,'^.*\<'.curlink.'\s\+xxx links to \(\a\+\).*$','\1','')
            if nxtlink =~ '\<start=\|\<cterm[fb]g=\|\<gui[fb]g='
                let nxtlink= substitute(nxtlink,'^[ \t\n]*\(\S\+\)\s\+.*$','\1','')
                let hilink = hilink ."->". nxtlink
                break
            endif
            let hilink      = hilink ."->". nxtlink
            let curlink     = nxtlink
        endwhile
    endif

    " Use new synstack() function, available with 7.1 and patch#215
    if v:version > 701 || ( v:version == 701 && has("patch215"))
        let syntaxstack = ""
        let isfirst     = 1
        let idlist      = synstack(line("."),col("."))
        if !empty(idlist)
            for id in idlist
                if isfirst
                    let syntaxstack= syntaxstack." ".synIDattr(id,"name")
                    let isfirst = 0
                else
                    let syntaxstack= syntaxstack."->".synIDattr(id,"name")
                endif
            endfor
        endif
    endif

    " display hilink traces
    redraw
    let synid= hlID(lastlink)
    if !exists("syntaxstack")
        return printf("HltTrace: %-".g:hilinks_fmtwidth."s fg<%s> bg<%s>",hilink,synIDattr(synid,"fg"),synIDattr(synid,"bg"))
    else
        return printf("SynStack: %-".g:hilinks_fmtwidth."s  HltTrace: %-".g:hilinks_fmtwidth."s fg<%s> bg<%s>",syntaxstack,hilink,synIDattr(synid,"fg"),synIDattr(synid,"bg"))
    endif

endfunction "}}}

nnoremap <leader>cr :let @a=JJHiTrace()<CR>
"" END Aesthetics }}}

nnoremap <localleader>]c :SearchNextDiff f<CR>
nnoremap <localleader>[c :SearchNextDiff b<CR>
command! -nargs=1 SearchNextDiff call SearchNextDiff(<f-args>)
function! SearchNextDiff(dir) abort
    if a:dir == 'f'
        call search('^-[^-]', 'w')
    elseif a:dir == 'b'
        call search('^-[^-]', 'wb')
    endif
endfunction

" vim: set fdm=marker:
