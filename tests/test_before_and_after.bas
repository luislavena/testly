'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly.bi"
#include once "testly-internals.bi"

namespace Suite_Working_All
    extern before_all_count as integer
    extern before_each_count as integer
    extern after_each_count as integer
    extern after_all_count as integer
end namespace

namespace Suite_Test_Before
    sub test_before_count()
        assert_equal(1, Suite_Working_All.before_all_count)
        assert_equal(2, Suite_Working_All.before_each_count)
    end sub

    private sub register() constructor
        add_suite(Suite_Test_Before)
        add_test(test_before_count)
    end sub
end namespace

namespace Suite_Test_After
    sub test_after_count()
        assert_equal(1, Suite_Working_All.after_all_count)
        assert_equal(2, Suite_Working_All.after_each_count)
    end sub

    private sub register() constructor
        add_suite(Suite_Test_After)
        add_test(test_after_count)
    end sub
end namespace
