'#--
'# Copyright (c) 2006-2007 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly.bi"
#include once "testly-internals.bi"

namespace Suite_Test_Assertions
    function setup() as boolean
        assert_pass("just testing assertions in setup()")
        return true
    end function
    
    function teardown() as boolean
        assert_pass("pass assertion in teardown()")
        return true
    end function
    
    sub test_simple
        assert_true(true)
    end sub
    
    private sub register() constructor
        add_suite("Suite_Test_Assertions", @setup, @teardown)
        add_test("test_simple", @test_simple)
    end sub
end namespace
