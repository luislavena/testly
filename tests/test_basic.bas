'#--
'# Copyright (c) 2006-2007 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly.bi"
#include once "testly-internals.bi"

namespace Test_Suites
    sub test_suite_exist()
        assert_true(suite_defined("Test_Suites"))
    end sub
    
    sub test_suite_properties()
        with *select_suite("Test_Suites")
            assert_equal("Test_Suites", .suite_name)
            assert_equal(0, .setup_func)
            assert_equal(0, .teardown_func)
            assert_equal(5, .tests_count)
        end with
    end sub
    
    sub test_has_test()
        with *select_suite("Test_Suites")
            assert_true(test_defined("test_has_test"))
            assert_true(test_defined("test_current_test"))
            assert_false(test_defined("test_unknown"))
        end with
    end sub
    
    sub test_current_suite()
        assert_equal("Test_Suites", current_suite_name())
    end sub
    
    sub test_current_test()
        assert_equal("test_current_test", current_test_name())
    end sub
    
    sub register() constructor
        add_suite("Test_Suites")
        add_test("test_suite_exist", @test_suite_exist)
        add_test("test_suite_properties", @test_suite_properties)
        add_test("test_has_test", @test_has_test)
        add_test("test_current_suite", @test_current_suite)
        add_test("test_current_test", @test_current_test)
    end sub
end namespace