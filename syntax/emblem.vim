" Language:		Emblem
" Maintainer:	Ed Jones <ed@kcza.net>
" URL:			https://github.com/TheSignPainter98/emblem
" License:		GPL3

if exists('b:current_syntax') && b:current_syntax == 'emblem'
	finish
endif

let b:current_syntax = 'emblem'

if version < 600
	syn clear
endif

" Highlight long strings
syn sync minlines=100

syn match emblemInvalidWordEscape /\\./
hi def link emblemInvalidWordEscape Error
syn match emblemWordEscape /\\[{}"':\\=*_`\-,.<>]/
hi def link emblemWordEscape SpecialChar
syn match emblemWord /[^ \\\t\n]\+/ contains=@spell,emblemWordEscape,emblemInvalidWordEscape
hi def link emblemWord Word

syn match emblemDirective /\.[^ \t\r\n:{}]\+/
hi def link emblemDirective Identifier

syn match emblemBuiltinDirective /\.toc\s*$/
syn keyword emblemBuiltinDirective .bib .h1 .h2 .h3 .h4 .h5 .h6 .h1* .h2* .h3* .h4* .h5* .h6* .it .bf .tt .sc .af
hi def link emblemBuiltinDirective emblemKnownDirective
hi def link emblemKnownDirective Statement

syn keyword emblemTodo TODO FIXME XXX contained
hi def link emblemTodo Todo

syn region emblemHeader matchgroup=emblemHeaderDelimiter start="^\s*#\{1,6\}\*\=\s" end="#*\s*$" keepend oneline
hi def link emblemHeaderDelimiter Type
hi def link emblemHeader Type

syn region embleminvalidheader matchgroup=emblemInvalidHeaderDelimiter start="#\{7,\}\*\=" end="#*\s*$" keepend oneline
hi def link emblemInvalidHeader emblemHeader
hi def link emblemInvalidHeaderDelimiter Error

syn match emblemCommentLine /\%1l^#!.*/
syn match emblemCommentLine /\/\/.*/ contains=emblemTodo
hi def link emblemCommentLine Comment

syn match emblemColon /:/
hi def link emblemColon emblemArgDelimiter
syn region emblemGroup matchgroup=emblemCurlyBrace extend start='{' end='}' keepend fold transparent
hi def link emblemCurlyBrace emblemArgDelimiter
hi def link emblemArgDelimiter PreProc

syn region emblemCommentRegion matchgroup=Comment extend start="/\*" end="\*/" fold contains=emblemCommentRegion,emblemTodo
hi def link emblemCommentRegion Comment

syn match emblemLexerDirective /^,line/ nextgroup=emblemFileNameString skipwhite
syn match emblemFileName /\v"(\\.|[^"])*"/ contains=emblemFileNameEscape nextgroup=emblemLineNumber skipwhite
syn match emblemFileNameEscape /\\./ contained
syn match emblemLineNumber /\v[0-9]+/ nextgroup=emblemColumnNumber skipwhite contained
syn match emblemColumnNumber /\v[0-9]+/ contained
hi def link emblemLexerDirective PreProc
hi def link emblemFileName String
hi def link emblemFileNameEscape SpecialChar
hi def link emblemLineNumber Number
hi def link emblemColumnNumber Number

syn cluster emblemAll contains=emblemHeader,emblemDirective,emblemKnownDirective,emblemBuiltinDirective,emblemCommentLine,emblemCommentRegion,emblemWord,emblemLexerDirective

if !exists('b:current_syntax')
	let b:current_syntax = 'emblem'
endif
