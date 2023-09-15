nnoremap <localleader>]c :SearchNextDiff f<CR>
nnoremap <localleader>[c :SearchNextDiff b<CR>
vnoremap <localleader>]c :SearchNextDiff f<CR>
vnoremap <localleader>[c :SearchNextDiff b<CR>
command! -nargs=1 SearchNextDiff call SearchNextDiff(<f-args>)
function! SearchNextDiff(dir) abort
    if a:dir == 'f'
        call search('^-[^-]', 'w')
    elseif a:dir == 'b'
        call search('^-[^-]', 'wb')
    endif
endfunction
