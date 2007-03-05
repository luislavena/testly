'#--
'# Copyright (c) 2006-2007 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly.bi"
#include once "testly-internals.bi"

namespace Suite_Test_Passed_Suites
    sub test_passed_setups()
        assert_false(select_suite("Suite_Working_All")->setup_failed)
        assert_false(select_suite("Suite_Failed_Teardown")->setup_failed)
        assert_false(select_suite("Suite_Without_Teardown")->setup_failed)
    end sub
    
    sub test_failed_setups()
        assert_true(select_suite("Suite_Failed_Setup")->setup_failed)
    end sub
    
    sub test_passed_teardowns()
        assert_false(select_suite("Suite_Working_All")->teardown_failed)
        assert_false(select_suite("Suite_Failed_Setup")->teardown_failed)
        assert_false(select_suite("Suite_Without_Setup")->teardown_failed)
    end sub
    
    sub test_failed_teardownds()
        assert_true(select_suite("Suite_Failed_Teardown")->teardown_failed)
    end sub
    
    private sub register() constructor
        add_suite("Suite_Test_Passed_Suites")
        add_test("test_passed_setups", @test_passed_setups)
        add_test("test_failed_setups", @test_failed_setups)
        add_test("test_passed_teardowns", @test_passed_teardowns)
        add_test("test_failed_teardownds", @test_failed_teardownds)
    end sub
    
end namespace
