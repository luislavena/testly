'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly.bi"
#include once "testly-internals.bi"

namespace Suite_Test_Passed_Tests
    sub test_passed_tests()
        select_suite("Suite_Working_All")
        assert_true(select_test("one_test_one_assert")->test_passed)
    end sub
    
    sub test_failed_tests()
        select_suite("Suite_Test_Failed")
        assert_false(select_test("failed_test")->test_passed)
        
        select_suite("Suite_Test_Error")
        assert_false(select_test("error_test")->test_passed)

        select_suite("Suite_Test_Error_Jump")
        assert_false(select_test("test_assertion_jump")->test_passed)
    end sub
    
    private sub register() constructor
        add_suite(Suite_Test_Passed_Tests)
        add_test(test_passed_tests)
        add_test(test_failed_tests)
    end sub
end namespace

