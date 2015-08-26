let s:save_cpo = &cpo
set cpo&vim

function! s:remove_ansi_sequences() abort " {{{
  let saved_modifiable = &l:modifiable
  let saved_readonly = &l:readonly
  let saved_modified = &l:modified
  setl modifiable noreadonly
  let saved_pos = getpos('.')
  keepjumps :%s/\C\e\[\d\{1,3}[mK]//ge
  call setpos('.', saved_pos)
  let &l:modifiable = saved_modifiable
  let &l:readonly = saved_readonly
  let &l:modified = saved_modified
endfunction " }}}

function! pager#enable(bang) abort " {{{
  call s:remove_ansi_sequences()
  setlocal tabstop=8
  setlocal nolist nospell nocursorline
  setlocal readonly nomodifiable
  setlocal nomodified
  nnoremap <buffer><silent> <Plug>(pager-close) :<C-u>q<CR>
  nmap q <Plug>(pager-close)
endfunction " }}}

command! -nargs=0 PAGER call pager#enable()

let &cpo = s:save_cpo
" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:
