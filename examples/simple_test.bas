#include once "testly.bi"

namespace Suite1
    function setup() as boolean
        return false
    end function
    
    function teardown() as boolean
        return false
    end function
    
    sub test1()
        assert_true(1=1)
        assert_true(1=0)
    end sub
    
    sub test2()
        assert_false(1<5)
        assert_equal(0,0)
        assert_equal(1,2)
    end sub
    
    sub test3()
        assert_true_error(true)
        assert_true_error(1>5)
    end sub
    
    sub register() constructor
        add_suite("Suite 1", @setup, @teardown)
        add_test("test 1", @test1)
        add_test("test 2", @test2)
        add_test("test 3", @test3)
    end sub
end namespace

'# evaluate the result from run_tests() to
'# return a error to the OS or not.
if (run_tests() = false) then
    end 1
end if
