'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly.bi"
#include once "testly-internals.bi"

namespace Suite_Test_List
    dim shared test_list as Testly.List ptr
    dim shared fake_values_ptr_test(0 to 6) as integer => { 1024, 2048, 4096, 8192, 16384, 32768, 65536 }
    
    sub before_all()
        test_list = new Testly.List
    end sub
    
    sub after_all()
        delete test_list
    end sub
    
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
        add_suite(Suite_Test_List)
        add_test(test_node_adding)
        add_test(test_compare_head)
        add_test(test_compare_tail)
        add_test(test_traverse_down)
        add_test(test_traverse_up)
        add_test(test_node_shifting)
        add_test(test_shifting_unexistant_node)
    end sub
    
end namespace
