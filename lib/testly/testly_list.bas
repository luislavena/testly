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

#include once "testly_list.bi"

namespace Testly
    '#############################################################
    '# List
    '# dtor()
    destructor List()
        this.clear()
    end destructor
    
    '# add(byval as any ptr)
    sub List.add(byval value as any ptr)
        dim new_node as ListNode ptr
        
        new_node = new ListNode
        
        '# to head of tail?
        if (first = 0) then
            first = new_node
        else
            last->next = new_node
        end if
        
        '# assign the node values
        with *new_node
            .previous = last
            .value = value
            .next = 0               '# this is the last node!
        end with
        
        '# increment counter
        _counter += 1
        
        '# set tail
        last = new_node
    end sub
    
    '# add(byval as any ptr)
    function List.shift() as any ptr
        dim result as any ptr
        dim new_next as ListNode ptr
        
        '# empty list?
        if (first = 0) then
            result = 0
        else
            '# get values
            with *first
                result = .value
                new_next = .next
            end with
            
            '# assign the new first
            delete first
            first = new_next
            
            '# emtpy nodes? fix the last one then
            if (first = 0) then
                last = 0
            end if
            
            '# decrement counter
            _counter -= 1
        end if
        
        return result
    end function
    
    '# count as uinteger
    property List.count as uinteger
        return _counter
    end property
    
    '# clear()
    sub List.clear()
        dim value as any ptr
        
        value = shift()
        do while not (value = 0)
            value = shift()
        loop
    end sub
    
end namespace 'Testly
