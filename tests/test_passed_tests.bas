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

namespace Suite_Test_Passed_Tests
    sub test_passed_tests()
        select_suite("Suite_Working_All")
        assert_true(select_test("one_test_one_assert")->test_passed)
        
        select_suite("Suite_Failed_Setup")
        assert_true(select_test("one_test_one_assert")->test_passed)
        
        select_suite("Suite_Without_Setup")
        assert_true(select_test("one_test_one_assert")->test_passed)
        
        select_suite("Suite_Failed_Teardown")
        assert_true(select_test("one_test_one_assert")->test_passed)
        
        select_suite("Suite_Without_Teardown")
        assert_true(select_test("one_test_one_assert")->test_passed)
        
        select_suite("Suite_Without_Setup_Or_Teardown")
        assert_true(select_test("one_test_one_assert")->test_passed)
    end sub
    
    sub test_failed_tests()
        select_suite("Suite_Test_Failed")
        assert_false(select_test("failed_test")->test_passed)
        
        select_suite("Suite_Test_Error")
        assert_false(select_test("error_test")->test_passed)
    end sub
    
    private sub register() constructor
        add_suite("Suite_Test_Passed_Tests")
        add_test("test_passed_tests", @test_passed_tests)
        add_test("test_failed_tests", @test_failed_tests)
    end sub
end namespace

