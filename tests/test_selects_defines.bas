'#--
'# Copyright (c) 2006-2007 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly.bi"
#include once "testly-internals.bi"

namespace Suite_Test_Selects_Defines
    sub test_defined_suites()
        assert_true(suite_defined("Suite_Working_All"))
        assert_true(suite_defined("Suite_Failed_Setup"))
        assert_true(suite_defined("Suite_Without_Setup"))
        assert_true(suite_defined("Suite_Failed_Teardown"))
        assert_true(suite_defined("Suite_Without_Teardown"))
        assert_true(suite_defined("Suite_Without_Setup_Or_Teardown"))
        assert_true(suite_defined("Suite_Test_Failed"))
        assert_true(suite_defined("Suite_Test_Error"))
    end sub
    
    sub test_select_suite()
        assert_not_equal(0, select_suite("Suite_Working_All"))
        assert_not_equal(0, select_suite("Suite_Failed_Setup"))
        assert_not_equal(0, select_suite("Suite_Without_Setup"))
        assert_not_equal(0, select_suite("Suite_Failed_Teardown"))
        assert_not_equal(0, select_suite("Suite_Without_Teardown"))
        assert_not_equal(0, select_suite("Suite_Without_Setup_Or_Teardown"))
        assert_not_equal(0, select_suite("Suite_Test_Failed"))
        assert_not_equal(0, select_suite("Suite_Test_Error"))
    end sub
    
    sub test_select_suite_compare_titles()
        assert_equal("Suite_Working_All", select_suite("Suite_Working_All")->suite_name)
        assert_not_equal("Suite_Without_Teardown", select_suite("Suite_Without_Setup")->suite_name)
    end sub
    
    sub test_defined_test()
        with *select_suite("Suite_Working_All")
            assert_true(test_defined("one_test_one_assert"))
        end with
        
        with *select_suite("Suite_Working_All")
            assert_false(test_defined("non_existant_test"))
        end with
    end sub
    
    sub test_select_test()
        select_suite("Suite_Working_All")
        assert_not_equal(0, select_test("one_test_one_assert"))
        
        select_suite("Suite_Failed_Setup")
        assert_not_equal(0, select_test("one_test_one_assert"))
        
        select_suite("Suite_Without_Setup")
        assert_not_equal(0, select_test("one_test_one_assert"))
        
        select_suite("Suite_Failed_Teardown")
        assert_not_equal(0, select_test("one_test_one_assert"))
        
        select_suite("Suite_Without_Teardown")
        assert_not_equal(0, select_test("one_test_one_assert"))
        
        select_suite("Suite_Without_Setup_Or_Teardown")
        assert_not_equal(0, select_test("one_test_one_assert"))
        
        select_suite("Suite_Test_Failed")
        assert_not_equal(0, select_test("failed_test"))
        
        select_suite("Suite_Test_Error")
        assert_not_equal(0, select_test("error_test"))
    end sub
    
    private sub register() constructor
        add_suite("Suite_Test_Selects_Defines")
        add_test("test_defined_suites", @test_defined_suites)
        add_test("test_select_suite", @test_select_suite)
        add_test("test_select_suite_compare_titles", @test_select_suite_compare_titles)
        add_test("test_defined_test", @test_defined_test)
        add_test("test_select_test", @test_select_test)
    end sub
end namespace
