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

let s:concealends = ' '
if has('conceal') && get(g:, 'emblem_syntax_conceal', 1) == 1
	let s:concealends = ' concealends'
endif

hi def emblemStyleBold                term=bold cterm=bold gui=bold
hi def emblemStyleBoldUnderline       term=bold,underline cterm=bold,underline gui=bold,underline
hi def emblemStyleBoldItalic          term=bold,italic cterm=bold,italic gui=bold,italic
hi def emblemStyleBoldUnderlineItalic term=bold,italic,underline cterm=bold,italic,underline gui=bold,italic,underline
hi def emblemStyleUnderline           term=underline cterm=underline gui=underline
hi def emblemStyleUnderlineItalic     term=italic,underline cterm=italic,underline gui=italic,underline
hi def emblemStyleItalic              term=italic cterm=italic gui=italic
if v:version > 800 || v:version == 800 && has("patch1038")
	hi def emblemStyleStrike          term=strikethrough cterm=strikethrough gui=strikethrough
else
    hi def emblemStyleStrike          term=underline cterm=underline gui=underline
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

exe "syn region emblemItalicRegion matchgroup=conceal start='_' end='_' keepend oneline" . s:concealends
" exe "syn region emblemItalicRegion matchgroup=conceal start='*' end='*' keepend oneline" . s:concealends
hi def link emblemItalicRegion emblemStyleItalic

exe "syn region emblemBoldRegion matchgroup=conceal start='__' end='__' keepend oneline" . s:concealends
" exe "syn region emblemBoldRegion matchgroup=conceal start='**' end='**' keepend oneline" . s:concealends
hi def link emblemBoldRegion emblemStyleBold

exe "syn region emblemSmallCapRegion matchgroup=conceal start='=' end='=' keepend oneline" . s:concealends
hi def link emblemSmallCapRegion emblemStyleUnderline

exe "syn region emblemMonoRegion matchgroup=conceal start='`' end='`' keepend oneline" . s:concealends
hi def link emblemMonoRegion emblemStyleUnderline

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

syn match emblemLexerDirective /^:line/ nextgroup=emblemFileName skipwhite
syn match emblemFileName /\v"(\\.|[^"])*"/ contains=emblemFileNameEscape nextgroup=emblemLineNumber skipwhite contained
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
