if exists("g:loaded_unite_uri")
   finish
endif
let g:loaded_unite_uri = 1
let s:save_cpo = &cpo
set cpo&vim

let g:uripath = fnamemodify(expand('<sfile>'), ':h').'/uri'

let g:uri_unite_source = {
  \ 'name': 'uri',
  \ 'description': 'open uri',
  \ 'action_table': {
  \   'open_uri': {
  \     'description': 'open uri'
  \   }
  \ }, 
  \ 'default_action':'open_uri'
  \ }

function! g:uri_unite_source.action_table.open_uri.func(candidate)
  call system("xdg-open " . a:candidate.action__uri)
endfunction

function! g:uri_unite_source.gather_candidates(args, context)
  let l:uris = system(g:uripath . " " . bufname("%"))
  let g:ret = map(split(l:uris, "\n"), 
    \ '{ "word": v:val, "action__uri": join(split(v:val, ":")[1:],":") }')
  return g:ret
endfunction

function! g:unite#sources#uri#define()
  return g:uri_unite_source
endfunction

call unite#define_source(g:uri_unite_source)

let &cpo = s:save_cpo

