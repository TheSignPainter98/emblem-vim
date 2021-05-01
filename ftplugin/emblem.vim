" Language:		Emblem
" Maintainer:	Ed Jones <ed@kcza.net>
" URL:			https://github.com/TheSignPainter98/emblem
" License:		GPL3

if exists("b:did_ftplugin")
	finish
endif

let b:did_ftplugin = 1

setlocal formatoptions-=t
setlocal comments=://
setlocal commendstring=//\ %s

let b:undo_ftplugin = "setlocal commentstring< comments< formatoptions<"
