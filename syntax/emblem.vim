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
syn match emblemWordEscape /\\[<!{}"':\\=*_`\-,.<>[]/
hi def link emblemWordEscape SpecialChar
syn match emblemWord /[^ \\\t\n~]\+/ contains=emblemWordEscape,emblemInvalidWordEscape,@Spell
hi def link emblemWord Word

syn match emblemCitation /\[[^ \t\r\n\]]\+\]/
hi def link emblemCitation String

syn match emblemAnchor /@[^ \t\r\n[\]{}]\+/
hi def link emblemAnchor Identifier

syn match emblemReference /#[^ \t\r\n[\]{}]\+/
hi def link emblemReference PreProc

syn match emblemDirective /\.[^ \t\r\n:{}]\+/
hi def link emblemDirective StorageClass

exe "syn region emblemItalicRegion matchgroup=conceal start='_' end='_' keepend oneline contains=@Spell" . s:concealends
exe "syn region emblemItalicRegion matchgroup=conceal start='*' end='*' keepend oneline contains=@Spell" . s:concealends
hi def link emblemItalicRegion emblemStyleItalic

exe "syn region emblemBoldRegion matchgroup=conceal start='__' end='__' keepend oneline contains=@Spell" . s:concealends
" exe "syn region emblemBoldRegion matchgroup=conceal start='**' end='**' keepend oneline contains=@Spell" . s:concealends
hi def link emblemBoldRegion emblemStyleBold

exe "syn region emblemSmallCapRegion matchgroup=conceal start='=' end='=' keepend oneline" . s:concealends
hi def link emblemSmallCapRegion String

exe "syn region emblemMonoRegion matchgroup=conceal start='`' end='`' keepend oneline" . s:concealends
hi def link emblemMonoRegion Constant

syn match emblemVariableReference /![^ \t\r\n~]\+/ contains=@Spell nextgroup=emblemVariableAssignment,emblemAll skipwhite
syn match emblemVariableAssignment /<--\=\>/ contained
syn match emblemVariableAssignment /<\~\~\=\>/ contained
hi def link emblemVariableReference Identifier
hi def link emblemVariableAssignment Statement

syn match emblemBuiltinDirective /\.toc\s*$/
syn match emblemBuiltinDirective /\.flush[_-]left\>/
syn match emblemBuiltinDirective /\.flush[_-]right\>/
syn keyword emblemBuiltinDirective .bib .cite .anchor .ref .h1 .h2 .h3 .h4 .h5 .h6 .h1* .h2* .h3* .h4* .h5* .h6* .it .bf .tt .sc .df .af .title .centre .center .justify
hi def link emblemBuiltinDirective emblemKnownDirective
hi def link emblemKnownDirective Constant

syn match emblemBuiltinFunc /\.curr[_-]version\>/
syn match emblemBuiltinFunc /\.known[_-]directives\>/
hi def link emblemBuiltinFunc Identifier

syn keyword emblemMathsFunc .add .div .idiv .mod .mul .pow .sign .sub .defined .exists
hi def link emblemMathsFunc String
syn keyword emblemBooleanFunc .and .impl .not .or .xor
hi def link emblemBooleanFunc Type
syn keyword emblemInequalityFunc .ge .gt .le .lt .eq
hi def link emblemEqualityFunc emblemInequalityFunc
syn keyword emblemInequalityFunc .eq .numeq .streq
hi def link emblemInequalityFunc Identifier

syn keyword emblemBuiltinScriptDirective .if .case .while .for .foreach .include .include* .call .help .expr
syn match emblemBuiltinScriptDirective /\.\(find[_-]\)\=set[_-]var\([_-]expr\)\=\>/
syn match emblemBuiltinScriptDirective /\.get[_-]var\>/
syn match emblemBuiltinScriptDirective /\.def\>/
syn match emblemBuiltinScriptDirective /\.undef\>/
syn match emblemBuiltinScriptDirective /\.echo\([_-]on\)\=\>/
syn match emblemBuiltinScriptDirective /\.error\([_-]on\)\=\>/
syn match emblemBuiltinScriptDirective /\.warn\([_-]on\)\=\>/
hi def link emblemBuiltinScriptDirective Statement

syn keyword emblemTodo TODO FIXME XXX contained
hi def link emblemTodo Todo

syn region emblemHeader matchgroup=emblemHeaderDelimiter start="^\s*#\{1,6\}\*\=\s" end="#*\s*$" keepend oneline contains=@Spell
hi def link emblemHeaderDelimiter Type
hi def link emblemHeader Type

syn region emblemInvalidheader matchgroup=emblemInvalidHeaderDelimiter start="#\{7,\}\*\=" end="#*\s*$" keepend oneline contains=@Spell
hi def link emblemInvalidHeader emblemHeader
hi def link emblemInvalidHeaderDelimiter Error

syn match emblemCommentLine /\%1l^#!.*/
syn match emblemCommentLine /\/\/.*/ contains=emblemTodo
hi def link emblemCommentLine Comment

syn match emblemColon /:/
syn match emblemColon /^\s*::\>/
hi def link emblemColon emblemArgDelimiter
syn region emblemGroup matchgroup=emblemCurlyBrace extend start='{' end='}' keepend fold transparent
hi def link emblemCurlyBrace emblemArgDelimiter
hi def link emblemArgDelimiter Structure

syn match emblemGlue /\~/
hi def link emblemGlue Structure

syn region emblemCommentRegion matchgroup=Comment extend start="/\*" end="\*/" fold contains=emblemCommentRegion,emblemTodo,@Spell
hi def link emblemCommentRegion Comment

syn match emblemListEnum /\v^\s*[-*](\s|$)/
hi def link emblemListEnum Constant
syn match emblemListEnum /\v^\s*[0-9]+\.(\s|$)/
hi def link emblemListEnum Constant

syn match emblemLexerDirective /^\s*:line\>/ nextgroup=emblemFileName skipwhite
syn match emblemLexerDirective /^\s*:include\>/ nextgroup=emblemFileName skipwhite
syn match emblemFileName /\v"(\\.|[^"])*"/ contains=emblemFileNameEscape nextgroup=emblemLineNumber skipwhite contained " Yeah, this isn't great
syn match emblemFileNameEscape /\\./ contained
syn match emblemLineNumber /\v[0-9]+/ nextgroup=emblemColumnNumber skipwhite contained
syn match emblemColumnNumber /\v[0-9]+/ contained
hi def link emblemLexerDirective PreProc
hi def link emblemFileName String
hi def link emblemFileNameEscape SpecialChar
hi def link emblemLineNumber Number
hi def link emblemColumnNumber Number

syn cluster emblemAll contains=emblemAnchor,emblemArgDelimiter,emblemBoldRegion,emblemBooleanFunc,emblemBuiltinDirective,emblemBuiltinFunc,emblemBuiltinScriptDirective,emblemCitation,emblemColon,emblemColumnNumber,emblemCommentLine,emblemCommentRegion,emblemCurlyBrace,emblemDirective,emblemEqualityFunc,emblemFileName,emblemFileNameEscape,emblemGroup,emblemHeader,emblemHeaderDelimiter,emblemInequalityFunc,emblemInvalidHeader,emblemInvalidHeaderDelimiter,emblemInvalidWordEscape,emblemItalicRegion,emblemKnownDirective,emblemLexerDirective,emblemLineNumber,emblemListEnum,emblemMathsFunc,emblemMonoRegion,emblemReference,emblemSmallCapRegion,emblemStyleBold,emblemStyleBoldItalic,emblemStyleBoldUnderline,emblemStyleBoldUnderlineItalic,emblemStyleItalic,emblemStyleStrike,emblemStyleUnderline,emblemStyleUnderlineItalic,emblemTodo,emblemVariableAssignment,emblemVariableReference,emblemWord,emblemWordEscape

if !exists('b:current_syntax')
	let b:current_syntax = 'emblem'
endif
