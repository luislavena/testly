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
