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
syn match emblemWordEscape /\\[<!{}"':\\=*_`\-,.<>]/
hi def link emblemWordEscape SpecialChar
syn match emblemWord /[^ \\\t\n]\+/ contains=@spell,emblemWordEscape,emblemInvalidWordEscape
hi def link emblemWord Word

syn match emblemCitation /\[[^ \t\r\n\]]\+\]/
hi def link emblemCitation String

syn match emblemAnchor /@[^ \t\r\n[\]{}]\+/
hi def link emblemAnchor Identifier

syn match emblemReference /#[^ \t\r\n[\]{}]\+/
hi def link emblemReference PreProc

syn match emblemDirective /\.[^ \t\r\n:{}]\+/
hi def link emblemDirective StorageClass

exe "syn region emblemItalicRegion matchgroup=conceal start='_' end='_' keepend oneline" . s:concealends
exe "syn region emblemItalicRegion matchgroup=conceal start='*' end='*' keepend oneline" . s:concealends
hi def link emblemItalicRegion emblemStyleItalic

exe "syn region emblemBoldRegion matchgroup=conceal start='__' end='__' keepend oneline" . s:concealends
" exe "syn region emblemBoldRegion matchgroup=conceal start='**' end='**' keepend oneline" . s:concealends
hi def link emblemBoldRegion emblemStyleBold

exe "syn region emblemSmallCapRegion matchgroup=conceal start='=' end='=' keepend oneline" . s:concealends
hi def link emblemSmallCapRegion Underlined

exe "syn region emblemMonoRegion matchgroup=conceal start='`' end='`' keepend oneline" . s:concealends
hi def link emblemMonoRegion Constant

syn match emblemVariableReference /![^ \t\r\n]\+/ contains=@spell nextgroup=emblemVariableAssignment,emblemAll skipwhite
syn match emblemVariableAssignment /<-/ contained
hi def link emblemVariableReference Identifier
hi def link emblemVariableAssignment Statement

syn match emblemBuiltinDirective /\.toc\s*$/
syn match emblemBuiltinDirective /\.flush[_-]left/
syn match emblemBuiltinDirective /\.flush[_-]right/
syn keyword emblemBuiltinDirective .bib .cite .anchor .ref .h1 .h2 .h3 .h4 .h5 .h6 .h1* .h2* .h3* .h4* .h5* .h6* .it .bf .tt .sc .af .title .centre .center .justify
hi def link emblemBuiltinDirective emblemKnownDirective
hi def link emblemKnownDirective Constant

syn keyword emblemBuiltinFunc .call .defined .exists .help
syn match emblemBuiltinFunc /\.set[_-]var/
syn match emblemBuiltinFunc /\.get[_-]var/
syn match emblemBuiltinFunc /\.def/
syn match emblemBuiltinFunc /\.undef/
syn match emblemBuiltinFunc /\.echo/
syn match emblemBuiltinFunc /\.echo[_-]on/
syn match emblemBuiltinFunc /\.error/
syn match emblemBuiltinFunc /\.error[_-]on/
syn match emblemBuiltinFunc /\.warn/
syn match emblemBuiltinFunc /\.warn[_-]on/
syn match emblemBuiltinFunc /\.curr[_-]version/
syn match emblemBuiltinFunc /\.known[_-]directives/
hi def link emblemBuiltinFunc emblemBuiltinScriptDirective

syn keyword emblemMathsFunc .add .div .idiv .mod .mul .pow .sign .sub
hi def link emblemMathsFunc String
syn keyword emblemBooleanFunc .and .impl .not .or .xor
hi def link emblemBooleanFunc Type
syn keyword emblemInequalityFunc .ge .gt .le .lt .eq
hi def link emblemEqualityFunc emblemInequalityFunc
syn keyword emblemInequalityFunc .eq .numeq .streq
hi def link emblemInequalityFunc Identifier

syn keyword emblemBuiltinScriptDirective .if .ifelse .case .while .foreach .include .include*
hi def link emblemBuiltinScriptDirective Statement

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
hi def link emblemArgDelimiter Structure

syn region emblemCommentRegion matchgroup=Comment extend start="/\*" end="\*/" fold contains=emblemCommentRegion,emblemTodo
hi def link emblemCommentRegion Comment

syn match emblemListEnum /\v^\s*[-*](\s|$)/
hi def link emblemListEnum Constant
syn match emblemListEnum /\v^\s*[0-9]+\.(\s|$)/
hi def link emblemListEnum Constant

syn match emblemLexerDirective /^\s*:line/ nextgroup=emblemFileName skipwhite
syn match emblemLexerDirective /^\s*:include/ nextgroup=emblemFileName skipwhite
syn match emblemFileName /\v"(\\.|[^"])*"/ contains=emblemFileNameEscape nextgroup=emblemLineNumber skipwhite contained " Yeah, this isn't great
syn match emblemFileNameEscape /\\./ contained
syn match emblemLineNumber /\v[0-9]+/ nextgroup=emblemColumnNumber skipwhite contained
syn match emblemColumnNumber /\v[0-9]+/ contained
hi def link emblemLexerDirective PreProc
hi def link emblemFileName String
hi def link emblemFileNameEscape SpecialChar
hi def link emblemLineNumber Number
hi def link emblemColumnNumber Number

syn cluster emblemAll contains=emblemHeader,emblemDirective,emblemKnownDirective,emblemBuiltinDirective,emblemBuiltinFunc,emblemBuiltinScriptDirective,emblemCommentLine,emblemCommentRegion,emblemWord,emblemLexerDirective

if !exists('b:current_syntax')
	let b:current_syntax = 'emblem'
endif
