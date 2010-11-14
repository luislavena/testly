#include once "testly.bi"

namespace Suite1
    sub before_each()
    end sub

    sub after_each()
    end sub

    sub test1()
        assert_true(1=1)
        assert_true(1=0)
    end sub

    sub test2()
        assert_false(1<5)
        assert_equal(0,0)
        assert_equal(1,2)
        assert_string_equal("uno", "dos")
    end sub

    sub test3()
        assert_true_error(true)
        assert_true_error(1>5)
    end sub

    sub register() constructor
        add_suite(Suite1)
        add_test(test1)
        add_test(test2)
        add_test(test3)
    end sub
end namespace

'# evaluate the result from run_tests() to
'# return a error to the OS or not.
if (run_tests() = false) then
    end 1
end if
