let s:save_cpo = &cpo
set cpo&vim

function! s:remove_ansi_sequences() abort " {{{
  let saved_modifiable = &l:modifiable
  let saved_readonly = &l:readonly
  let saved_modified = &l:modified
  setl modifiable noreadonly
  let saved_pos = getpos('.')
  keepjumps :%s/\v\e\[%(%(\d;)?\d{1,2})?[mK]//ge
  call setpos('.', saved_pos)
  let &l:modifiable = saved_modifiable
  let &l:readonly = saved_readonly
  let &l:modified = saved_modified
endfunction " }}}

function! pager#enable() abort " {{{
  if g:pager#use_AnsiEsc && exists(':AnsiEsc')
    AnsiEsc
  else
    call s:remove_ansi_sequences()
  endif
  setlocal tabstop=8
  setlocal nolist nospell nocursorline
  setlocal readonly nomodifiable
  setlocal nomodified
  nnoremap <buffer><silent> <Plug>(pager-close) :<C-u>q<CR>
  nmap <buffer> q <Plug>(pager-close)
endfunction " }}}

command! -nargs=0 PAGER call pager#enable()

let g:pager#use_AnsiEsc = get(g:, 'pager#use_AnsiEsc', 1)

let &cpo = s:save_cpo
" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:
