'#--
'# Copyright (c) 2006-2007 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly.bi"
#include once "testly-internals.bi"

namespace Suite_Test_Counters
    sub test_tests_count()
        assert_equal(2, select_suite("Suite_Working_All")->tests_count)
        assert_equal(1, select_suite("Suite_Test_Failed")->tests_count)
        assert_equal(1, select_suite("Suite_Test_Error")->tests_count)
        assert_equal(1, select_suite("Suite_Test_Error_Jump")->tests_count)
    end sub
    
    sub test_assertions_count()
        assert_equal(3, select_suite("Suite_Working_All")->stats.assertions)
        assert_equal(1, select_suite("Suite_Test_Failed")->stats.assertions)
        assert_equal(1, select_suite("Suite_Test_Error")->stats.assertions)
        assert_equal(1, select_suite("Suite_Test_Error_Jump")->stats.assertions)
    end sub
    
    sub test_failures_count()
        assert_equal(0, select_suite("Suite_Working_All")->stats.failures)
        assert_equal(1, select_suite("Suite_Test_Failed")->stats.failures)
        assert_equal(0, select_suite("Suite_Test_Error")->stats.failures)
        assert_equal(0, select_suite("Suite_Test_Error_Jump")->stats.failures)
    end sub
    
    sub test_errors_count()
        assert_equal(0, select_suite("Suite_Working_All")->stats.errors)
        assert_equal(0, select_suite("Suite_Test_Failed")->stats.errors)
        assert_equal(1, select_suite("Suite_Test_Error")->stats.errors)
        assert_equal(1, select_suite("Suite_Test_Error_Jump")->stats.errors)
    end sub
    
    private sub register() constructor
        add_suite(Suite_Test_Counters)
        add_test(test_tests_count)
        add_test(test_assertions_count)
        add_test(test_failures_count)
        add_test(test_errors_count)
    end sub
    
end namespace

