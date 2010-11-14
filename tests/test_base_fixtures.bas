'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
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
    extern before_all_count as integer
    extern before_each_count as integer
    extern after_each_count as integer
    extern after_all_count as integer

    dim shared before_all_count as integer = 0
    dim shared before_each_count as integer = 0
    dim shared after_each_count as integer = 0
    dim shared after_all_count as integer = 0

    sub before_all()
        before_all_count += 1
    end sub

    sub before_each()
        before_each_count += 1
    end sub

    sub after_each()
        after_each_count += 1
    end sub

    sub after_all()
        after_all_count += 1
    end sub

    sub one_test_one_assert()
        assert_true(true)
    end sub

    sub other_test_two_asserts()
        assert_true(true)
        assert_false(false)
    end sub

    private sub register() constructor
        add_suite(Suite_Working_All)
        add_test(one_test_one_assert)
        add_test(other_test_two_asserts)

        '# exclude from results
        select_suite("Suite_Working_All")->exclude = true
    end sub
end namespace

namespace Suite_Test_Failed
    sub failed_test()
        assert_true(false)
    end sub

    private sub register() constructor
        add_suite(Suite_Test_Failed)
        add_test(failed_test)

        '# exclude from results
        select_suite("Suite_Test_Failed")->exclude = true
    end sub
end namespace

namespace Suite_Test_Error
    sub error_test()
        assert_true_error(false)
    end sub

    private sub register() constructor
        add_suite(Suite_Test_Error)
        add_test(error_test)

        '# exclude from results
        select_suite("Suite_Test_Error")->exclude = true
    end sub
end namespace

namespace Suite_Test_Error_Jump
    sub test_assertion_jump()
        '# assertions after this never get evaluated!
        assert_true_error(false)

        assert_true(true)
    end sub

    private sub register() constructor
        add_suite(Suite_Test_Error_Jump)
        add_test(test_assertion_jump)

        '# exclude from results
        select_suite("Suite_Test_Error_Jump")->exclude = true
    end sub
end namespace
