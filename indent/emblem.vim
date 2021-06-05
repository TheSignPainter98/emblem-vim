" Language:		Emblem
" Maintainer:	Ed Jones <ed@kcza.net>
" URL:			https://github.com/TheSignPainter98/emblem
" License:		GPL3

if exists('b:did_indent')
	finish
endif

let b:did_indent = 1

if exists("*GetEmblemIndent")
	finish
endif
let s:keepcpo = &cpo
set cpo&vim

" setlocal autoindent
setlocal indentkeys+=o,O,<:>,0}
setlocal indentexpr=GetEmblemIndent(v:lnum)

let s:maxoff = 200

function! GetEmblemIndent(lnum)
	let l:curr_line = getline(a:lnum)
	if l:curr_line =~ '\v^[ \t]*:($|[^:])'
		return 0
	endif
	let l:prevlnum = prevnonblank(a:lnum - 1)
	let l:prevline = getline(l:prevlnum)
	while l:prevline =~ '^:[^ \t]'
		let l:prevlnum = l:prevlnum - 1
		let l:prevline = getline(l:prevlnum)
	endwhile
	let l:indended_indent
	if l:prevlnum < 1
		l:intended_indent = 0
	elseif l:prevline =~ '[:\{]$'
		let l:intended_indent = indent(l:prevlnum) + shiftwidth()
	else
		let l:intended_indent = indent(l:prevlnum)
	endif
	if l:curr_line =~ '\v^[ \t]*(}|::$)'
		return l:intended_indent - shiftwidth()
	endif
	return l:intended_indent
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo
