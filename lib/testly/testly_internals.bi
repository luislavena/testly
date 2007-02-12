'#--
'# Copyright (c) 2006-2007 Luis Lavena, Multimedia systems
'#
'# Permission is hereby granted, free of charge, to any person obtaining
'# a copy of this software and associated documentation files (the
'# "Software"), to deal in the Software without restriction, including
'# without limitation the rights to use, copy, modify, merge, publish,
'# distribute, sublicense, and/or sell copies of the Software, and to
'# permit persons to whom the Software is furnished to do so, subject to
'# the following conditions:
'#
'# The above copyright notice and this permission notice shall be
'# included in all copies or substantial portions of the Software.
'#
'# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
'# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
'# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
'# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
'# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
'# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
'# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'#++

#ifndef __TESTLY_INTERNALS_BI__
#define __TESTLY_INTERNALS_BI__

#include once "testly_case.bi"
#include once "testly_suite.bi"

namespace Testly
    '# Helpers simplify the addition of suites and new test to each suite.
    '# you could call them directly, but is recomended (and shorter)
    '# use the defines below in this file.
    namespace InternalHelpers
        declare function suite_defined(byref as string) as boolean
        declare function test_defined(byref as string) as boolean
        declare function select_suite(byref as string) as Suite ptr
        declare function select_test(byref as string) as TestCase ptr
        
        declare function current_suite_name() as string
        declare function current_test_name() as string
        
        '# SELECTED_SUITE
        extern SELECTED_SUITE as Suite ptr
        
        '# SELECTED_TEST
        extern SELECTED_TEST as TestCase ptr
        
    end namespace 'InternalHelpers
end namespace 'Testly

#endif '__TESTLY_INTERNALS_BI__
