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

'# this module defines a few Suites that will be excluded
'# from the results, but used as base of correct functionality of 
'# the library

'# to exclude the suite, we must use the following syntax:
'# with *select_suite("Suite_Name")
'#     .exclude = true
'# end with

'# Also, remember that setup and teardown functions
'# must return true in case of success (or false if they failed).

namespace Suite_Working_All
    function setup() as boolean
        return true
    end function
    
    function teardown() as boolean
        return true
    end function
    
    sub one_test_one_assert()
        assert_true(true)
    end sub
    
    sub other_test_two_asserts()
        assert_true(true)
        assert_false(false)
    end sub
    
    private sub register() constructor
        add_suite("Suite_Working_All", @setup, @teardown)
        add_test("one_test_one_assert", @one_test_one_assert)
        add_test("other_test_two_asserts", @other_test_two_asserts)
        
        '# exclude from results
        select_suite("Suite_Working_All")->exclude = true
    end sub
end namespace

namespace Suite_Failed_Setup
    function setup() as boolean
        return false
    end function
    
    function teardown() as boolean
        return true
    end function
    
    sub one_test_one_assert()
        assert_true(true)
    end sub
   
    private sub register() constructor
        add_suite("Suite_Failed_Setup", @setup, @teardown)
        add_test("one_test_one_assert", @one_test_one_assert)
        
        '# exclude from results
        select_suite("Suite_Failed_Setup")->exclude = true
    end sub
end namespace

namespace Suite_Without_Setup
    function teardown() as boolean
        return true
    end function
    
    sub one_test_one_assert()
        assert_true(true)
    end sub
   
    private sub register() constructor
        add_suite("Suite_Without_Setup", 0, @teardown)
        add_test("one_test_one_assert", @one_test_one_assert)
        
        '# exclude from results
        select_suite("Suite_Without_Setup")->exclude = true
    end sub
end namespace

namespace Suite_Failed_Teardown
    function setup() as boolean
        return true
    end function
    
    function teardown() as boolean
        return false
    end function
    
    sub one_test_one_assert()
        assert_true(true)
    end sub
   
    private sub register() constructor
        add_suite("Suite_Failed_Teardown", @setup, @teardown)
        add_test("one_test_one_assert", @one_test_one_assert)
        
        '# exclude from results
        select_suite("Suite_Failed_Teardown")->exclude = true
    end sub
end namespace

namespace Suite_Without_Teardown
    function setup() as boolean
        return true
    end function
    
    sub one_test_one_assert()
        assert_true(true)
    end sub
   
    private sub register() constructor
        add_suite("Suite_Without_Teardown", @setup)
        add_test("one_test_one_assert", @one_test_one_assert)
        
        '# exclude from results
        select_suite("Suite_Without_Teardown")->exclude = true
    end sub
end namespace

namespace Suite_Failed_Setup_And_Teardown
    function setup() as boolean
        return false
    end function
    
    function teardown() as boolean
        return false
    end function
    
    sub one_test_one_assert()
        assert_true(true)
    end sub
   
    private sub register() constructor
        add_suite("Suite_Failed_Setup_And_Teardown", @setup, @teardown)
        add_test("one_test_one_assert", @one_test_one_assert)
        
        '# exclude from results
        select_suite("Suite_Failed_Setup_And_Teardown")->exclude = true
    end sub
end namespace

namespace Suite_Without_Setup_Or_Teardown
    sub one_test_one_assert()
        assert_true(true)
    end sub
   
    private sub register() constructor
        add_suite("Suite_Without_Setup_Or_Teardown")
        add_test("one_test_one_assert", @one_test_one_assert)
        
        '# exclude from results
        select_suite("Suite_Without_Setup_Or_Teardown")->exclude = true
    end sub
end namespace

namespace Suite_Test_Failed
    sub failed_test()
        assert_true(false)
    end sub
    
    private sub register() constructor
        add_suite("Suite_Test_Failed")
        add_test("failed_test", @failed_test)
        
        '# exclude from results
        select_suite("Suite_Test_Failed")->exclude = true
    end sub
end namespace

namespace Suite_Test_Error
    sub error_test()
        assert_true_error(false)
    end sub
    
    private sub register() constructor
        add_suite("Suite_Test_Error")
        add_test("error_test", @error_test)
        
        '# exclude from results
        select_suite("Suite_Test_Error")->exclude = true
    end sub
end namespace
