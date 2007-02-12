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
