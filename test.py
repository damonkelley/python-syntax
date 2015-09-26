#! /usr/bin/env python
# -*- coding: utf-8 -*-
# Above the run-comment and file encoding comment.

# Comments.

# TODO FIXME XXX

# Keywords.

with break continue del exec return pass print raise global assert lambda yield
for while if elif else import from as try except finally and in is not or

yield from

def functionname
class Classname
def функция
class Класс

async def functionname()
async with ContextManager() as c:
await

# Builtin objects.

True False Ellipsis None NotImplemented

# Builtin function and types.

__import__ abs all any callable classmethod
cmp compile delattr divmod enumerate eval
filter getattr globals hasattr hash help hex id
isinstance issubclass input iter len locals map max min oct
open ord pow property range repr reversed round
setattr slice sorted staticmethod sum vars zip

# Non-essential builtins (Python 2)

apply coerce intern

# Python 2 builtin functions

execfile raw_input reduce reload xrange execfile

# "Types"

basestring bool buffer chr dict complex file float frozenset int list long
object set str super tuple type unichr unicode

# Builtin exceptions and warnings.

BaseException Exception StandardError ArithmeticError LookupError
EnvironmentError

AssertionError AttributeError EOFError FloatingPointError GeneratorExit IOError
ImportError IndexError KeyError KeyboardInterrupt MemoryError NameError
NotImplementedError OSError OverflowError ReferenceError RuntimeError
StopIteration SyntaxError IndentationError TabError SystemError SystemExit
TypeError UnboundLocalError UnicodeError UnicodeEncodeError UnicodeDecodeError
UnicodeTranslateError ValueError WindowsError ZeroDivisionError

Warning UserWarning DeprecationWarning PendingDepricationWarning SyntaxWarning
RuntimeWarning FutureWarning ImportWarning UnicodeWarning

# Decorators.

@ decoratorname
@ object.__init__(arg1, arg2)
@ декоратор
@ декоратор.décorateur

# Numbers

0 1 2 9 10 0x1f .3 12.34 0j 0j 34.2E-3 0b10 0o77 1023434 0x0

# Erroneous numbers

077 100L 0xfffffffL 0L 08 0xk 0x  0b102 0o78 0o123LaB

# Strings

" test " ' test '
"""
  test
"""
'''
  test
'''

" \a\b\c\"\'\n\r \x34\077 \08 \xag"
r" \" \' "

"testтест"

b"test"

b"test\r\n\xffff"

b"тестtest"

br"test"

br"\a\b\n\r"

# Formattings

" %f "
b" %f "

"{0.name!r:b} {0[n]} {name!s:  } {{test}} {{}} {} {.__len__:s}"
b"{0.name!r:b} {0[n]} {name!s:  } {{test}} {{}} {} {.__len__:s}"

"${test} ${test ${test}aname $$$ $test+nope"
b"${test} ${test ${test}aname $$$ $test+nope"

# Doctests.

"""
    Test:
    >>> a = 5
    >>> a
    5

    Test
"""

'''
    Test:
    >>> a = 5
    >>> a
    5

    Test
'''

# Erroneous symbols or bad variable names.

$ ? 6xav

&& || ===

# Indentation errors.

    	    break

# Trailing space errors.

    	
    break	    
"""  	
   	 
    test    	
"""  	
