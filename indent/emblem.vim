" Language:		Emblem
" Maintainer:	Ed Jones <ed@kcza.net>
" URL:			https://github.com/TheSignPainter98/emblem
" License:		GPL3

if exists('b:did_indent')
	finish
endif

let b:did_indent = 1

" setlocal autoindent
" setlocal indentkeys+=<:>
setlocal indentexpr=GetEmblemIndent(v:lnum)

if exists("*GetEmblemIndent")
	finish
endif
let s:keepcpo = &cpo
set cpo&vim

let s:maxoff = 200

function! GetEmblemIndent(lnum)
	let l:prevlnum = prevnonblank(a:lnum - 1)
	let l:prevline = getline(l:prevlnum)
	if l:prevlnum < 1
		return 0
	elseif l:prevline =~ ':$'
		return indent(l:prevlnum) + shiftwidth()
	else
		return indent(l:prevlnum)
	endif
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo
