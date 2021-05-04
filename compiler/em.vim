" Language:		Emblem
" Maintainer:	Ed Jones <ed@kcza.net>
" URL:			https://github.com/TheSignPainter98/emblem
" License:		GPL3

if exists('current_compiler') | finish | endif
if !exists("g:emblem_command")
	let g:emblem_command = 'em'
endif
let current_compiler = g:emblem_command

let s:keepcpo=&cpo
set cpo&vim

CompilerSet errorformat=
	\%f:%l:%v:\ %trror:\ %m,
	\%f:%l:%v:\ %tarning:\ %m,
	\%tarning:\ %m,
	\%trror:\ %m,
setlocal makeprg=em\ -C1\ -v1\ %

let &cpo=s:keepcpo
unlet s:keepcpo
