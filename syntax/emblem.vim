" Language:		Emblem
" Maintainer:	Ed Jones <ed@kcza.net>
" URL:			https://github.com/TheSignPainter98/emblem
" License:		GPL3

if exists('b:current_syntax') && b:current_syntax == 'emblem'
	finish
endif

b:current_syntax = 'emblem'

if version < 600
	syn clear
endif

" Highlight long strings
syn sync minlines=100

syn keyword emblemColon :
hi def link emblemColon Operator

syn keyword emblemBuildinDirective .toc .bib .h1 .h2 .h3 .h4 .h5 .h6 .h1* .h2* .h3* .h4* .h5* .h6* .it .bf .tt .sc .af
hi def link emblemBuildinDirective Keyword

syn match emblemDirective /\.[a-zA-Z0-9$_@*]/
hi def link emblemDirective Type

" syn match emblemWord // contains=@spell
" hi def link emblemWord Constant

syn keyword emblemTodo TODO FIXME XXX contained
hi def link emblemTodo Todo

syn match emblemCommentLine /\%#!.*/
syn match emblemCommentLine /\/\/.*/ contains=emblemTodo
hi def link emblemCommentLine Comment

syn region emblemCommentRegion start="/*" end="*/" fold transparent

syn cluster emblemAll contains=emblemColon,emblemBuildinDirective,emblemCommentLine,emblemCommentRegion,emblemWord

if !exists('b:current_syntax')
	let b:current_syntax = 'emblem'
endif
