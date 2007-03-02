'#--
'# Copyright (c) 2006-2007 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
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

namespace Suite_Test_List
    dim shared test_list as Testly.List ptr
    dim shared fake_values_ptr_test(0 to 6) as integer => { 1024, 2048, 4096, 8192, 16384, 32768, 65536 }
    
    function setup() as boolean
        dim result as boolean
        
        test_list = new Testly.List
        if not (test_list = 0) then
            result = true
        else
            result = false
        end if
        
        return result
    end function
    
    function teardown() as boolean
        delete test_list
        return true
    end function
    
    sub test_node_adding()
        dim old_count as uinteger
        
        for idx as integer = 0 to 6
            old_count = test_list->count
            test_list->add(@fake_values_ptr_test(idx))
            assert_not_equal(test_list->count, old_count)
        next idx
        
        assert_equal_error(7, test_list->count)
    end sub
    
    sub test_compare_head()
        assert_not_equal(0, test_list->first)
        assert_equal(@fake_values_ptr_test(0), test_list->first->value)
        assert_equal(fake_values_ptr_test(0), *cast(integer ptr, test_list->first->value))
    end sub
    
    sub test_compare_tail()
        assert_not_equal(0, test_list->last)
        assert_equal(@fake_values_ptr_test(6), test_list->last->value)
        assert_equal(fake_values_ptr_test(6), *cast(integer ptr, test_list->last->value))
    end sub
    
    sub test_traverse_down()
        dim node as Testly.ListNode ptr
        dim idx as integer
        
        node = test_list->first
        assert_not_equal(0, node)
        assert_equal(0, node->previous)
        
        do until (node = 0)
            assert_equal(@fake_values_ptr_test(idx), node->value)
            assert_equal(fake_values_ptr_test(idx), *cast(integer ptr, node->value))
            idx += 1
            node = node->next
        loop
        
        assert_equal(7, idx)
    end sub
    
    sub test_traverse_up()
        dim node as Testly.ListNode ptr
        dim idx as integer
        
        idx = 6
        
        node = test_list->last
        assert_not_equal(0, node)
        assert_equal(0, node->next)
        
        do until (node = 0)
            assert_equal(@fake_values_ptr_test(idx), node->value)
            assert_equal(fake_values_ptr_test(idx), *cast(integer ptr, node->value))
            idx -= 1
            node = node->previous
        loop
        
        assert_equal(-1, idx)
    end sub
    
    sub test_node_shifting()
        dim shifted as any ptr
        dim prev_count as uinteger
        
        for idx as integer = 0 to 6
            prev_count = test_list->count
            shifted = test_list->shift()
            assert_equal(@fake_values_ptr_test(idx), shifted)
            assert_equal(fake_values_ptr_test(idx), *cast(integer ptr, shifted))
            assert_true(test_list->count < prev_count)
        next idx
        
        assert_equal_error(0, test_list->count)
    end sub
    
    sub test_shifting_unexistant_node()
        dim shifted as any ptr
        
        shifted = test_list->shift()
        assert_equal(0, shifted)
    end sub
    
    private sub register() constructor
        add_suite("Suite_Test_List", @setup, @teardown)
        add_test("test_node_adding", @test_node_adding)
        add_test("test_compare_head", @test_compare_head)
        add_test("test_compare_tail", @test_compare_tail)
        add_test("test_traverse_down", @test_traverse_down)
        add_test("test_traverse_up", @test_traverse_up)
        add_test("test_node_shifting", @test_node_shifting)
        add_test("test_shifting_unexistant_node", @test_shifting_unexistant_node)
    end sub
    
end namespace
