" Vim syntax file
" Language:             Python
" Current Maintainer:   Damon Kelley <damon dot kelley at gmail dot com>
" Original Maintainer:  Neil Schemenauer <nas at python dot ca>
" URL:                  https://github.com/damonkelley/python-syntax
" Last Change:          2015-09-25
" Filenames:            *.py
" Version:              0.1.0
"
" Based on python.vim (from Vim 6.1 distribution)
" by Neil Schemenauer <nas at python dot ca>
"
" Also based on the python-syntax plugin by Dmitry Vasiliev
" (http://github.com/hdima/python-syntax)
"
"
" Option to select Python version
" -------------------------------
"
"    python_version_2                       Enable highlighting for Python 2
"                                           (Python 3 highlighting is enabled
"                                           by default). Can also be set as
"                                           a buffer (b:python_version_2)
"                                           variable.
"
"    You can also use the following local to buffer commands to switch
"    between two highlighting modes:
"
"    :Python2Syntax                         Switch to Python 2 highlighting
"                                           mode
"    :Python3Syntax                         Switch to Python 3 highlighting
"                                           mode
"

" For version 5.x: Clear all syntax items
" For versions greater than 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

"
" Commands
"
command! -buffer Python2Syntax let b:python_version_2 = 1 | let &syntax=&syntax
command! -buffer Python3Syntax let b:python_version_2 = 0 | let &syntax=&syntax

" Check if option is enabled
function! s:Enabled(name)
  return exists(a:name) && {a:name}
endfunction

" Is it Python 2 syntax?
function! s:Python2Syntax()
  if exists("b:python_version_2")
      return b:python_version_2
  endif
  return s:Enabled("g:python_version_2")
endfunction


"
" Keywords
"
syn keyword pythonStatement     break continue del
syn keyword pythonStatement     return
syn keyword pythonStatement     pass raise
syn keyword pythonStatement     global assert
syn keyword pythonStatement     lambda
syn keyword pythonStatement     with
syn keyword pythonStatement     def class nextgroup=pythonFunction skipwhite
syn keyword pythonRepeat        for while
syn keyword pythonConditional   if elif else
syn keyword pythonImport        import
syn keyword pythonException     try except finally
syn keyword pythonOperator      and in is not or

syn match pythonStatement   "\<yield\>" display
syn match pythonImport      "\<from\>" display

if s:Python2Syntax()
  syn keyword pythonImport      as
  syn match   pythonFunction    "[a-zA-Z_][a-zA-Z0-9_]*" display contained
  syn keyword pythonStatement   print
else
  syn keyword pythonStatement   exec
  syn keyword pythonStatement   as nonlocal None
  syn match   pythonStatement   "\<yield\s\+from\>" display
  syn keyword pythonBoolean     True False
  syn match   pythonFunction    "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
  syn keyword pythonStatement   await
  syn match   pythonStatement   "\<async\s\+def\>" display nextgroup=pythonFunction skipwhite
  syn match   pythonStatement   "\<async\s\+with\>" display
  syn match   pythonStatement   "\<async\s\+for\>" display
  syn match   pythonStatement   "\<async\s\+with\>" display
endif

"
" Decorators 
"
syn match   pythonDecorator	"@" display nextgroup=pythonDottedName skipwhite
if s:Python2Syntax()
  syn match   pythonDottedName "[a-zA-Z_][a-zA-Z0-9_]*\%(\.[a-zA-Z_][a-zA-Z0-9_]*\)*" display contained
else
  syn match   pythonDottedName "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\%(\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\)*" display contained
endif
syn match   pythonDot        "\." display containedin=pythonDottedName

"
" Comments
"
syn match   pythonComment	"#.*$" display contains=pythonTodo,@Spell
syn match   pythonRun		"\%^#!.*$"
syn match   pythonCoding	"\%^.*\%(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$"
syn keyword pythonTodo		TODO FIXME XXX contained

"
" Errors
"
syn match pythonError		"\<\d\+\D\+\>" display
syn match pythonError		"[$?]" display
syn match pythonError		"[&|]\{2,}" display
syn match pythonError		"[=]\{3,}" display

" Mixing spaces and tabs also may be used for pretty formatting multiline
" statements
syn match pythonIndentError	"^\s*\%( \t\|\t \)\s*\S"me=e-1 display

" Trailing space errors
syn match pythonSpaceError	"\s\+$" display

"
" Strings
"
if s:Python2Syntax()
  " Python 2 strings
  syn region pythonString   start=+[bB]\='+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,@Spell
  syn region pythonString   start=+[bB]\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,@Spell
  syn region pythonString   start=+[bB]\="""+ end=+"""+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,pythonDocTest2,pythonSpaceError,@Spell
  syn region pythonString   start=+[bB]\='''+ end=+'''+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,pythonDocTest,pythonSpaceError,@Spell
else
  " Python 3 byte strings
  syn region pythonBytes		start=+[bB]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesError,pythonBytesContent,@Spell
  syn region pythonBytes		start=+[bB]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesError,pythonBytesContent,@Spell
  syn region pythonBytes		start=+[bB]"""+ end=+"""+ keepend contains=pythonBytesError,pythonBytesContent,pythonDocTest2,pythonSpaceError,@Spell
  syn region pythonBytes		start=+[bB]'''+ end=+'''+ keepend contains=pythonBytesError,pythonBytesContent,pythonDocTest,pythonSpaceError,@Spell

  syn match pythonBytesError    ".\+" display contained
  syn match pythonBytesContent  "[\u0000-\u00ff]\+" display contained contains=pythonBytesEscape,pythonBytesEscapeError
endif

syn match pythonBytesEscape       +\\[abfnrtv'"\\]+ display contained
syn match pythonBytesEscape       "\\\o\o\=\o\=" display contained
syn match pythonBytesEscapeError  "\\\o\{,2}[89]" display contained
syn match pythonBytesEscape       "\\x\x\{2}" display contained
syn match pythonBytesEscapeError  "\\x\x\=\X" display contained
syn match pythonBytesEscape       "\\$"

syn match pythonUniEscape         "\\u\x\{4}" display contained
syn match pythonUniEscapeError    "\\u\x\{,3}\X" display contained
syn match pythonUniEscape         "\\U\x\{8}" display contained
syn match pythonUniEscapeError    "\\U\x\{,7}\X" display contained
syn match pythonUniEscape         "\\N{[A-Z ]\+}" display contained
syn match pythonUniEscapeError    "\\N{[^A-Z ]\+}" display contained

if s:Python2Syntax()
  " Python 2 Unicode strings
  syn region pythonUniString  start=+[uU]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,@Spell
  syn region pythonUniString  start=+[uU]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,@Spell
  syn region pythonUniString  start=+[uU]"""+ end=+"""+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,pythonDocTest2,pythonSpaceError,@Spell
  syn region pythonUniString  start=+[uU]'''+ end=+'''+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,pythonDocTest,pythonSpaceError,@Spell
else
  " Python 3 strings
  syn region pythonString   start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,@Spell
  syn region pythonString   start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,@Spell
  syn region pythonString   start=+"""+ end=+"""+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,pythonDocTest2,pythonSpaceError,@Spell
  syn region pythonString   start=+'''+ end=+'''+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,pythonDocTest,pythonSpaceError,@Spell
endif

if s:Python2Syntax()
  " Python 2 Unicode raw strings
  syn region pythonUniRawString start=+[uU][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,pythonUniRawEscape,pythonUniRawEscapeError,@Spell
  syn region pythonUniRawString start=+[uU][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,pythonUniRawEscape,pythonUniRawEscapeError,@Spell
  syn region pythonUniRawString start=+[uU][rR]"""+ end=+"""+ keepend contains=pythonUniRawEscape,pythonUniRawEscapeError,pythonDocTest2,pythonSpaceError,@Spell
  syn region pythonUniRawString start=+[uU][rR]'''+ end=+'''+ keepend contains=pythonUniRawEscape,pythonUniRawEscapeError,pythonDocTest,pythonSpaceError,@Spell

  syn match  pythonUniRawEscape       "\([^\\]\(\\\\\)*\)\@<=\\u\x\{4}" display contained
  syn match  pythonUniRawEscapeError  "\([^\\]\(\\\\\)*\)\@<=\\u\x\{,3}\X" display contained
endif

" Python 2/3 raw strings
if s:Python2Syntax()
  syn region pythonRawString  start=+[bB]\=[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,@Spell
  syn region pythonRawString  start=+[bB]\=[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,@Spell
  syn region pythonRawString  start=+[bB]\=[rR]"""+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell
  syn region pythonRawString  start=+[bB]\=[rR]'''+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell
else
  syn region pythonRawString  start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,@Spell
  syn region pythonRawString  start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,@Spell
  syn region pythonRawString  start=+[rR]"""+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell
  syn region pythonRawString  start=+[rR]'''+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell

  syn region pythonRawBytes  start=+[bB][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,@Spell
  syn region pythonRawBytes  start=+[bB][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,@Spell
  syn region pythonRawBytes  start=+[bB][rR]"""+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell
  syn region pythonRawBytes  start=+[bB][rR]'''+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell
endif

syn match pythonRawEscape +\\['"]+ display transparent contained

" % operator string formatting
if s:Python2Syntax()
  syn match pythonStrFormatting	"%\%(([^)]\+)\)\=[-#0 +]*\d*\%(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonUniRawString,pythonRawString
  syn match pythonStrFormatting	"%[-#0 +]*\%(\*\|\d\+\)\=\%(\.\%(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonUniRawString,pythonRawString
else
  syn match pythonStrFormatting	"%\%(([^)]\+)\)\=[-#0 +]*\d*\%(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonRawString
  syn match pythonStrFormatting	"%[-#0 +]*\%(\*\|\d\+\)\=\%(\.\%(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonRawString
endif

" str.format syntax
if s:Python2Syntax()
  syn match pythonStrFormat "{{\|}}" contained containedin=pythonString,pythonUniString,pythonUniRawString,pythonRawString
  syn match pythonStrFormat	"{\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)\=\%(\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\[\%(\d\+\|[^!:\}]\+\)\]\)*\%(![rsa]\)\=\%(:\%({\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)}\|\%([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*,\=\%(\.\d\+\)\=[bcdeEfFgGnosxX%]\=\)\=\)\=}" contained containedin=pythonString,pythonUniString,pythonUniRawString,pythonRawString
else
  syn match pythonStrFormat "{{\|}}" contained containedin=pythonString,pythonRawString
  syn match pythonStrFormat	"{\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)\=\%(\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\[\%(\d\+\|[^!:\}]\+\)\]\)*\%(![rsa]\)\=\%(:\%({\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)}\|\%([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*,\=\%(\.\d\+\)\=[bcdeEfFgGnosxX%]\=\)\=\)\=}" contained containedin=pythonString,pythonRawString
endif

" string.Template format
if s:Python2Syntax()
  syn match pythonStrTemplate	"\$\$" contained containedin=pythonString,pythonUniString,pythonUniRawString,pythonRawString
  syn match pythonStrTemplate	"\${[a-zA-Z_][a-zA-Z0-9_]*}" contained containedin=pythonString,pythonUniString,pythonUniRawString,pythonRawString
  syn match pythonStrTemplate	"\$[a-zA-Z_][a-zA-Z0-9_]*" contained containedin=pythonString,pythonUniString,pythonUniRawString,pythonRawString
else
  syn match pythonStrTemplate	"\$\$" contained containedin=pythonString,pythonRawString
  syn match pythonStrTemplate	"\${[a-zA-Z_][a-zA-Z0-9_]*}" contained containedin=pythonString,pythonRawString
  syn match pythonStrTemplate	"\$[a-zA-Z_][a-zA-Z0-9_]*" contained containedin=pythonString,pythonRawString
endif

" DocTests
syn region pythonDocTest	start="^\s*>>>" end=+'''+he=s-1 end="^\s*$" contained
syn region pythonDocTest2	start="^\s*>>>" end=+"""+he=s-1 end="^\s*$" contained

"
" Numbers (ints, longs, floats, complex)
"
if s:Python2Syntax()
  syn match   pythonHexError	"\<0[xX]\x*[g-zG-Z]\+\x*[lL]\=\>" display
  syn match   pythonOctError	"\<0[oO]\=\o*\D\+\d*[lL]\=\>" display
  syn match   pythonBinError	"\<0[bB][01]*\D\+\d*[lL]\=\>" display

  syn match   pythonHexNumber	"\<0[xX]\x\+[lL]\=\>" display
  syn match   pythonOctNumber "\<0[oO]\o\+[lL]\=\>" display
  syn match   pythonBinNumber "\<0[bB][01]\+[lL]\=\>" display

  syn match   pythonNumberError	"\<\d\+\D[lL]\=\>" display
  syn match   pythonNumber	"\<\d[lL]\=\>" display
  syn match   pythonNumber	"\<[0-9]\d\+[lL]\=\>" display
  syn match   pythonNumber	"\<\d\+[lLjJ]\>" display

  syn match   pythonOctError	"\<0[oO]\=\o*[8-9]\d*[lL]\=\>" display
  syn match   pythonBinError	"\<0[bB][01]*[2-9]\d*[lL]\=\>" display
else
  syn match   pythonHexError	"\<0[xX]\x*[g-zG-Z]\x*\>" display
  syn match   pythonOctError	"\<0[oO]\=\o*\D\+\d*\>" display
  syn match   pythonBinError	"\<0[bB][01]*\D\+\d*\>" display

  syn match   pythonHexNumber	"\<0[xX]\x\+\>" display
  syn match   pythonOctNumber "\<0[oO]\o\+\>" display
  syn match   pythonBinNumber "\<0[bB][01]\+\>" display

  syn match   pythonNumberError	"\<\d\+\D\>" display
  syn match   pythonNumberError	"\<0\d\+\>" display
  syn match   pythonNumber	"\<\d\>" display
  syn match   pythonNumber	"\<[1-9]\d\+\>" display
  syn match   pythonNumber	"\<\d\+[jJ]\>" display

  syn match   pythonOctError	"\<0[oO]\=\o*[8-9]\d*\>" display
  syn match   pythonBinError	"\<0[bB][01]*[2-9]\d*\>" display
endif

syn match   pythonFloat		"\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match   pythonFloat		"\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
syn match   pythonFloat		"\<\d\+\.\d*\%([eE][+-]\=\d\+\)\=[jJ]\=" display

"
" Builtin objects and types
"
if s:Python2Syntax()
  syn keyword pythonBuiltinObj	None
  syn keyword pythonBoolean		True False
endif
syn keyword pythonBuiltinObj	Ellipsis NotImplemented
syn keyword pythonBuiltinObj	__debug__ __doc__ __file__ __name__ __package__

" Custom
"
syn keyword pythonSelf self cls

syn keyword pythonStatement class nextgroup=pythonClass skipwhite
syn match pythonClass "\%(\%(class\s\)\s*\)\@<=\h\%(\w\|\.\)*" contained nextgroup=pythonClassVars
syn region pythonClassVars start="(" end=")" contained contains=pythonClassParameters transparent keepend
syn match pythonClassParameters "[^,\*]*" contained contains=pythonBuiltin,pythonBuiltinObj,pythonBuiltinType,pythonExtraOperatorpythonStatement,pythonBrackets,pythonString,pythonComment skipwhite

"
" Type-like builtin functions
"
if s:Python2Syntax()
  syn keyword pythonBuiltinType basestring unicode buffer
  syn keyword pythonBuiltinType unichr file long unichr
else
  syn keyword pythonBuiltinType bytes
endif
syn keyword pythonBuiltinType type object
syn keyword pythonBuiltinType str bytearray chr dict int list tuple
syn keyword pythonBuiltinType bool float complex set frozenset
syn keyword pythonBuiltinType super

"
" Builtin functions
"
if s:Python2Syntax()
  syn keyword pythonBuiltinFunc	apply callable coerce
  syn keyword pythonBuiltinFunc	execfile help intern raw_input
  syn keyword pythonBuiltinFunc	reduce reload xrange
else
  syn keyword pythonBuiltinFunc	ascii memoryview print
endif
syn keyword pythonBuiltinFunc	__import__ abs all any
syn keyword pythonBuiltinFunc	bin bytearray 
syn keyword pythonBuiltinFunc	callable classmethod cmp compile 
syn keyword pythonBuiltinFunc	delattr dir divmod enumerate eval
syn keyword pythonBuiltinFunc	filter format getattr
syn keyword pythonBuiltinFunc	globals hasattr hash help hex id
syn keyword pythonBuiltinFunc	input isinstance
syn keyword pythonBuiltinFunc	issubclass iter len locals map max
syn keyword pythonBuiltinFunc	min next oct open ord
syn keyword pythonBuiltinFunc	pow property range
syn keyword pythonBuiltinFunc	repr reversed round setattr
syn keyword pythonBuiltinFunc	slice sorted staticmethod sum 
syn keyword pythonBuiltinFunc	vars zip

"
" Builtin exceptions and warnings
"
if s:Python2Syntax()
  syn keyword pythonExClass	StandardError
else
  syn keyword pythonExClass	BlockingIOError ChildProcessError
  syn keyword pythonExClass	ConnectionError BrokenPipeError
  syn keyword pythonExClass	ConnectionAbortedError ConnectionRefusedError
  syn keyword pythonExClass	ConnectionResetError FileExistsError
  syn keyword pythonExClass	FileNotFoundError InterruptedError
  syn keyword pythonExClass	IsADirectoryError NotADirectoryError
  syn keyword pythonExClass	PermissionError ProcessLookupError TimeoutError

  syn keyword pythonExClass	ResourceWarning
endif
syn keyword pythonExClass	BaseException
syn keyword pythonExClass	Exception ArithmeticError
syn keyword pythonExClass	LookupError EnvironmentError

syn keyword pythonExClass	AssertionError AttributeError BufferError EOFError
syn keyword pythonExClass	FloatingPointError GeneratorExit IOError
syn keyword pythonExClass	ImportError IndexError KeyError
syn keyword pythonExClass	KeyboardInterrupt MemoryError NameError
syn keyword pythonExClass	NotImplementedError OSError OverflowError
syn keyword pythonExClass	ReferenceError RuntimeError StopIteration
syn keyword pythonExClass	SyntaxError IndentationError TabError
syn keyword pythonExClass	SystemError SystemExit TypeError
syn keyword pythonExClass	UnboundLocalError UnicodeError
syn keyword pythonExClass	UnicodeEncodeError UnicodeDecodeError
syn keyword pythonExClass	UnicodeTranslateError ValueError VMSError
syn keyword pythonExClass	WindowsError ZeroDivisionError

syn keyword pythonExClass	Warning UserWarning BytesWarning DeprecationWarning
syn keyword pythonExClass	PendingDepricationWarning SyntaxWarning
syn keyword pythonExClass	RuntimeWarning FutureWarning
syn keyword pythonExClass	ImportWarning UnicodeWarning


" This is fast but code inside triple quoted strings screws it up. It
" is impossible to fix because the only way to know if you are inside a
" triple quoted string is to start from the beginning of the file.
syn sync match pythonSync grouphere NONE "):$"
syn sync maxlines=200


hi def link pythonStatement        Statement
hi def link pythonImport           Include
hi def link pythonFunction         Function
hi def link pythonConditional      Conditional
hi def link pythonRepeat           Repeat
hi def link pythonException        Exception
hi def link pythonOperator         Operator
hi def link pythonClass            Type
hi def link pythonSelf             Identifier

hi def link pythonDecorator        Define
hi def link pythonDottedName       Function
hi def link pythonDot              Normal

hi def link pythonComment          Comment
hi def link pythonCoding           Special
hi def link pythonRun              Special
hi def link pythonTodo             Todo

hi def link pythonError            Error
hi def link pythonIndentError      Error
hi def link pythonSpaceError       Error

hi def link pythonString           String
hi def link pythonRawString        String

hi def link pythonUniEscape        Special
hi def link pythonUniEscapeError   Error

if s:Python2Syntax()
    hi def link pythonUniString          String
    hi def link pythonUniRawString       String
    hi def link pythonUniRawEscape       Special
    hi def link pythonUniRawEscapeError  Error
else
    hi def link pythonBytes              String
    hi def link pythonRawBytes           String
    hi def link pythonBytesContent       String
    hi def link pythonBytesError         Error
    hi def link pythonBytesEscape        Special
    hi def link pythonBytesEscapeError   Error
endif

hi def link pythonStrFormatting    Special
hi def link pythonStrFormat        Special
hi def link pythonStrTemplate      Special

hi def link pythonDocTest          Special
hi def link pythonDocTest2         Special

hi def link pythonNumber           Number
hi def link pythonHexNumber        Number
hi def link pythonOctNumber        Number
hi def link pythonBinNumber        Number
hi def link pythonFloat            Float
hi def link pythonNumberError      Error
hi def link pythonOctError         Error
hi def link pythonHexError         Error
hi def link pythonBinError         Error

hi def link pythonBoolean          Boolean

hi def link pythonBuiltinObj       Structure
hi def link pythonBuiltinFunc      Function
hi def link pythonBuiltinType      Type

hi def link pythonExClass          Structure

let b:current_syntax = "python"
