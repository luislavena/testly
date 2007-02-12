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

namespace Suite_Test_Suites
    '# here is defined a empty test for the testing suite
    declare sub fake_test()
    
    dim shared previous_suite as Testly.Suite ptr
    dim shared previous_test as Testly.TestCase ptr
    
    function setup() as boolean
        previous_suite = Testly.Helpers.CURRENT_SUITE
        previous_test = Testly.Helpers.CURRENT_TEST
        
        return true
    end function
    
    function teardown() as boolean
        Testly.Helpers.CURRENT_SUITE = previous_suite
        Testly.Helpers.CURRENT_TEST = previous_test
        
        return true
    end function
    
    sub test_suite_add()
        assert_equal(previous_suite, Testly.Helpers.CURRENT_SUITE)
        
        '# try adding a new suite (will be a fake one)
        add_suite("fake_test_suite")
        
        assert_not_equal(previous_suite, Testly.Helpers.CURRENT_SUITE)
        assert_equal(0, Testly.Helpers.CURRENT_TEST)
        
        '# don't forget to exclude this suite from totals!
        select_suite("fake_test_suite")->exclude = true
    end sub
    
    sub test_test_add()
        assert_equal(0, Testly.Helpers.CURRENT_TEST)
        
        '# add the fake test
        add_test("fake_test", @fake_test)
        
        assert_not_equal(0, Testly.Helpers.CURRENT_TEST)
        assert_not_equal(previous_test, Testly.Helpers.CURRENT_TEST)
    end sub
    
    '# fake test
    sub fake_test()
    end sub
    
    private sub register() constructor
        add_suite("Suite_Test_Suites", @setup, @teardown)
        add_test("test_suite_add", @test_suite_add)
        add_test("test_test_add", @test_test_add)
    end sub
end namespace
