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

namespace Suite_Test_Counters
    sub test_tests_count()
        assert_equal(2, select_suite("Suite_Working_All")->tests_count)
        assert_equal(1, select_suite("Suite_Failed_Setup")->tests_count)
        assert_equal(1, select_suite("Suite_Without_Setup")->tests_count)
        assert_equal(1, select_suite("Suite_Failed_Teardown")->tests_count)
        assert_equal(1, select_suite("Suite_Without_Teardown")->tests_count)
        assert_equal(1, select_suite("Suite_Failed_Setup_And_Teardown")->tests_count)
        assert_equal(1, select_suite("Suite_Without_Setup_Or_Teardown")->tests_count)
        assert_equal(1, select_suite("Suite_Test_Failed")->tests_count)
        assert_equal(1, select_suite("Suite_Test_Error")->tests_count)
    end sub
    
    sub test_assertions_count()
        assert_equal(3, select_suite("Suite_Working_All")->stats.assertions)
        assert_equal(1, select_suite("Suite_Failed_Setup")->stats.assertions)
        assert_equal(1, select_suite("Suite_Without_Setup")->stats.assertions)
        assert_equal(1, select_suite("Suite_Failed_Teardown")->stats.assertions)
        assert_equal(1, select_suite("Suite_Without_Teardown")->stats.assertions)
        assert_equal(1, select_suite("Suite_Failed_Setup_And_Teardown")->stats.assertions)
        assert_equal(1, select_suite("Suite_Without_Setup_Or_Teardown")->stats.assertions)
        assert_equal(1, select_suite("Suite_Test_Failed")->stats.assertions)
        assert_equal(1, select_suite("Suite_Test_Error")->stats.assertions)
    end sub
    
    sub test_failures_count()
        assert_equal(0, select_suite("Suite_Working_All")->stats.failures)
        assert_equal(0, select_suite("Suite_Failed_Setup")->stats.failures)
        assert_equal(0, select_suite("Suite_Without_Setup")->stats.failures)
        assert_equal(0, select_suite("Suite_Failed_Teardown")->stats.failures)
        assert_equal(0, select_suite("Suite_Without_Teardown")->stats.failures)
        assert_equal(0, select_suite("Suite_Failed_Setup_And_Teardown")->stats.failures)
        assert_equal(0, select_suite("Suite_Without_Setup_Or_Teardown")->stats.failures)
        assert_equal(1, select_suite("Suite_Test_Failed")->stats.failures)
        assert_equal(0, select_suite("Suite_Test_Error")->stats.failures)
    end sub
    
    sub test_errors_count()
        assert_equal(0, select_suite("Suite_Working_All")->stats.errors)
        assert_equal(1, select_suite("Suite_Failed_Setup")->stats.errors)
        assert_equal(0, select_suite("Suite_Without_Setup")->stats.errors)
        assert_equal(1, select_suite("Suite_Failed_Teardown")->stats.errors)
        assert_equal(0, select_suite("Suite_Without_Teardown")->stats.errors)
        assert_equal(2, select_suite("Suite_Failed_Setup_And_Teardown")->stats.errors)
        assert_equal(0, select_suite("Suite_Without_Setup_Or_Teardown")->stats.errors)
        assert_equal(0, select_suite("Suite_Test_Failed")->stats.errors)
        assert_equal(1, select_suite("Suite_Test_Error")->stats.errors)
    end sub
    
    private sub register() constructor
        add_suite("Suite_Test_Counters")
        add_test("test_tests_count", @test_tests_count)
        add_test("test_assertions_count", @test_assertions_count)
        add_test("test_failures_count", @test_failures_count)
        add_test("test_errors_count", @test_errors_count)
    end sub
    
end namespace

