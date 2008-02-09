'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
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
    '# testcase prototypes
    type test_func_t as sub()

    declare function custom_assertion(byval as boolean, byref as string, byval as uinteger, _
                                        byref as string, byval as boolean = false) as boolean
    
    '# Helpers simplify the addition of suites and new test to each suite.
    '# you could call them directly, but is recomended (and shorter)
    '# use the defines below in this file.
    namespace Helpers
        declare function add_suite_ex(byref as string) as boolean
        declare function add_suite_hook(byref as string, byref as sub()) as boolean
        declare function add_test_ex(byref as string, byref as test_func_t) as boolean
        declare function run_tests() as boolean
        
        #macro add_if_defined(__sub__)
            #if defined(__sub__)
            Testly.Helpers.add_suite_hook(#__sub__, @##__sub__)
            #endif
        #endmacro
        
        '# add only defined before_ and after_ hooks
        #macro add_suite(__suite__)
            Testly.Helpers.add_suite_ex(#__suite__)
            add_if_defined(before_all)
            add_if_defined(before_each)
            add_if_defined(after_all)
            add_if_defined(after_each)
        #endmacro
        
        '# Helper to simplify adding tests
        #macro add_test(__test_name__)
            #if defined(__test_name__)
            Testly.Helpers.add_test_ex(#__test_name__, @##__test_name__)
            #endif
        #endmacro
    end namespace ' Helpers
end namespace 'Testly

'# Assertion Helpers
#define assert_true(__value__) _
        Testly.custom_assertion((__value__) = (true), __FILE__, __LINE__, ("{" #__value__ "} is not true."))

#define assert_true_error(__value__) _
        if (Testly.custom_assertion((__value__) = (true), __FILE__, __LINE__, ("{" #__value__ "} is not true."), true) = false) then exit sub

#define assert_false(__value__) _
        Testly.custom_assertion((__value__) = (false), __FILE__, __LINE__, ("{" #__value__ "} is not false."))

#define assert_false_error(__value__) _
        if (Testly.custom_assertion((__value__) = (false), __FILE__, __LINE__, ("{" #__value__ "} is not false."), true) = false) then exit sub

'# EQU, NEQ (general)
#define assert_equal(__expected__, __actual__) _
        Testly.custom_assertion((__actual__) = (__expected__), __FILE__, __LINE__, ("expected {" #__expected__ "} but was {" #__actual__ "}"))

#define assert_equal_error(__expected__, __actual__) _
        if (Testly.custom_assertion((__actual__) = (__expected__), __FILE__, __LINE__, ("expected {" #__expected__ "} but was {" #__actual__ "}"), true) = false) then exit sub

#define assert_not_equal(__expected__, __actual__) _
        Testly.custom_assertion((__actual__) <> (__expected__), __FILE__, __LINE__, ("{" #__actual__ "} expected to be != to {" #__expected__ "}"))

#define assert_not_equal_error(__expected__, __actual__) _
        if (Testly.custom_assertion((__actual__) <> (__expected__), __FILE__, __LINE__, ("{" #__actual__ "} expected to be != to {" #__expected__ "}"), true) = false) then exit sub

'# EQU, NEQ (strings)
#define assert_string_equal(__expected__, __actual__) _
        Testly.custom_assertion((str(__actual__) = str(__expected__)), __FILE__, __LINE__, ("expected {" #__expected__ "} but was {" #__actual__ "}"))

#define assert_string_equal_error(__expected__, __actual__) _
        if (Testly.custom_assertion((str(__actual__) = str(__expected__)), __FILE__, __LINE__, ("expected {" #__expected__ "} but was {" #__actual__ "}"), true) = false) then exit sub

#define assert_string_not_equal(__expected__, __actual__) _
        Testly.custom_assertion((str(__actual__) <> str(__expected__)), __FILE__, __LINE__, ("{" #__actual__ "} expected to be != to {" #__expected__ "}"))

#define assert_string_not_equal_error(__expected__, __actual__) _
        if (Testly.custom_assertion((str(__actual__) <> str(__expected__)), __FILE__, __LINE__, ("{" #__actual__ "} expected to be != to {" #__expected__ "}"), true) = false) then exit sub

#define assert_pass(__message__) _
        Testly.custom_assertion((true), __FILE__, __LINE__, __message__)

#define assert_fail(__message__) _
        Testly.custom_assertion((false), __FILE__, __LINE__, __message__)

#define assert_error(__message__) _
        if (Testly.custom_assertion((false), __FILE__, __LINE__, __message__, true) = false) then exit sub

'# includes Testly.Helpers namespace!
using Testly.Helpers

#endif '__TESTLY_BI__
