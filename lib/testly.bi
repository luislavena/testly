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

#ifndef __TESTLY_BI__
#define __TESTLY_BI__

#inclib "testly"

#ifndef BOOLEAN
type BOOLEAN as byte
#undef FALSE
const FALSE as byte = 0
#undef TRUE
const TRUE as byte = not FALSE
#endif 'BOOLEAN

namespace Testly
    '# setup/teardown and testcase prototypes
    type suite_func_t as function() as boolean
    type test_func_t as sub()
    
    declare sub custom_assertion(byval as boolean, byref as string, byval as uinteger, _
                                    byref as string, byval as boolean = false)
    
    '# Helpers simplify the addition of suites and new test to each suite.
    '# you could call them directly, but is recomended (and shorter)
    '# use the defines below in this file.
    namespace Helpers
        declare function add_suite(byref as string, byref as suite_func_t = 0, byref as suite_func_t = 0) as boolean
        declare function add_test(byref as string, byref as test_func_t) as boolean
        declare function run_tests() as boolean
    end namespace ' Helpers
end namespace 'Testly

'# Assertion Helpers
#define assert_true(__value__) _
        Testly.custom_assertion((__value__) = (true), __FILE__, __LINE__, ("{" #__value__ "} is not true."))

#define assert_true_error(__value__) _
        Testly.custom_assertion((__value__) = (true), __FILE__, __LINE__, ("{" #__value__ "} is not true."), true)

#define assert_false(__value__) _
        Testly.custom_assertion((__value__) = (false), __FILE__, __LINE__, ("{" #__value__ "} is not false."))

#define assert_false_error(__value__) _
        Testly.custom_assertion((__value__) = (false), __FILE__, __LINE__, ("{" #__value__ "} is not false."), true)

#define assert_equal(__expected__, __actual__) _
        Testly.custom_assertion((__actual__) = (__expected__), __FILE__, __LINE__, ("expected {" #__expected__ "} but was {" #__actual__ "}"))

#define assert_equal_error(__expected__, __actual__) _
        Testly.custom_assertion((__actual__) = (__expected__), __FILE__, __LINE__, ("expected {" #__expected__ "} but was {" #__actual__ "}"), true)

#define assert_not_equal(__expected__, __actual__) _
        Testly.custom_assertion((__actual__) <> (__expected__), __FILE__, __LINE__, ("{" #__actual__ "} expected to be != to {" #__expected__ "}"))

#define assert_not_equal_error(__expected__, __actual__) _
        Testly.custom_assertion((__actual__) <> (__expected__), __FILE__, __LINE__, ("{" #__actual__ "} expected to be != to {" #__expected__ "}"), true)

#define assert_pass(__message__) _
        Testly.custom_assertion((true), __FILE__, __LINE__, __message__)

#define assert_fail(__message__) _
        Testly.custom_assertion((false), __FILE__, __LINE__, __message__)

#define assert_error(__message__) _
        Testly.custom_assertion((false), __FILE__, __LINE__, __message__, true)

'# includes Testly.Helpers namespace!
using Testly.Helpers

#endif '__TESTLY_BI__
