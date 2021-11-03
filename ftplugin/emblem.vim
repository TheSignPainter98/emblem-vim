" Language:		Emblem
" Maintainer:	Ed Jones <ed@kcza.net>
" URL:			https://github.com/TheSignPainter98/emblem
" License:		GPL3

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin=1
let s:keepcpo=&cpo
set cpo&vim

setlocal formatoptions-=t
setlocal formatoptions+=onj
setlocal comments=bOn://,nsr:/*,mr:*,nexl:*/
setlocal commentstring=//%s
setlocal iskeyword+=.,*,-,~,:

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal completefunc=syntaxcomplete#Complete
setlocal foldmethod=indent
setlocal foldignore=""

if !exists('g:emblem_command')
	let g:emblem_command = 'em'
endif

fun! EmblemCompile()
	call EmblemCompileFile()
endfun

fun! EmblemCompileFile()
	if getline(1) =~ '^#!'
		let l:emblem_command = getline(1)[2:]
	else
		let l:emblem_command = g:emblem_command
	endif
	let l:compile_command = join([l:emblem_command, bufname('%')], ' ')
	execute '!' . l:compile_command
endfun

fun! s:EmblemNextSection(type, backwards)
	if a:type == 1
		let l:pattern =	'^\s*\(#\+\ \|\.h[0-9]\)'
	elseif a:type == 2
		let l:pattern = '^\s*\..*:$'
	endif
	let l:search_flags = 'W'
	if a:backwards
		let l:search_flags.='b'
	endif
	call search(l:pattern, l:search_flags)
endfun

noremap <script> <silent> ]] :call <sid>EmblemNextSection(1, 0)<cr>
noremap <script> <silent> [[ :call <sid>EmblemNextSection(1, 1)<cr>
noremap <script> <silent> ][ :call <sid>EmblemNextSection(2, 0)<cr>
noremap <script> <silent> [] :call <sid>EmblemNextSection(2, 1)<cr>

let b:undo_ftplugin = "setlocal commentstring< comments< formatoptions< completefunc< shiftwidth< softtabstop< tabstop< iskeyword< foldignore< foldmethod<"

let &cpo=s:keepcpo
unlet s:keepcpo
