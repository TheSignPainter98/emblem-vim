" Language:		Emblem
" Maintainer:	Ed Jones <ed@kcza.net>
" URL:			https://github.com/TheSignPainter98/emblem
" License:		GPL3

autocmd BufNewFile,BufRead *.em setlocal filetype=emblem

function! s:DetectEmblem()
	if getline(1) =~ '^#!.*\<em\>'
		setlocal filetype=emblem
	endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectEmblem()
