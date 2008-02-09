'#--
'# Copyright (c) 2006-2007 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly.bi"
#include once "testly-internals.bi"

namespace Suite_Test_Suites
    '# here is defined a empty test for the testing suite
    declare sub fake_test()
    
    dim shared previous_suite as Testly.Suite ptr
    dim shared previous_test as Testly.TestCase ptr
    
    sub before_all()
        previous_suite = Testly.Helpers.CURRENT_SUITE
        previous_test = Testly.Helpers.CURRENT_TEST
    end sub
    
    sub after_all()
        Testly.Helpers.CURRENT_SUITE = previous_suite
        Testly.Helpers.CURRENT_TEST = previous_test
    end sub
    
    sub test_suite_add()
        assert_equal(previous_suite, Testly.Helpers.CURRENT_SUITE)
        
        '# try adding a new suite (will be a fake one)
        add_suite_ex("fake_test_suite")
        
        assert_not_equal(previous_suite, Testly.Helpers.CURRENT_SUITE)
        assert_equal(0, Testly.Helpers.CURRENT_TEST)
        
        '# don't forget to exclude this suite from totals!
        select_suite("fake_test_suite")->exclude = true
    end sub
    
    sub test_test_add()
        assert_equal(0, Testly.Helpers.CURRENT_TEST)
        
        '# add the fake test
        add_test_ex("fake_test", @fake_test)
        
        assert_not_equal(0, Testly.Helpers.CURRENT_TEST)
        assert_not_equal(previous_test, Testly.Helpers.CURRENT_TEST)
    end sub
    
    '# fake test
    sub fake_test()
    end sub
    
    private sub register() constructor
        add_suite(Suite_Test_Suites)
        add_test(test_suite_add)
        add_test(test_test_add)
    end sub
end namespace
