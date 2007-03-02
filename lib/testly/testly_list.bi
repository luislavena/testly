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

#ifndef __TESTLY_LIST_BI__
#define __TESTLY_LIST_BI__

namespace Testly
    '# ListNode represent one item in the linked list
    '# previous and next are used to navigate the
    '# list in both ways
    '# value could contain any kind of pointer
    type ListNode
        previous as ListNode ptr
        value as any ptr
        next as ListNode ptr
    end type
    
    '# Simple implementation of a Linked List
    '# this mimic the ruby Array class
    '# add will put the new element at last
    '# shift will "pop" the first element
    '# there is also first and last ListNodes so
    '# you could navigate it directly.
    '# we only define a destructor to clear()
    '# the nodes.
    type List
        declare destructor()
        
        first as ListNode ptr
        last as ListNode ptr
        
        declare sub add(byval as any ptr)
        declare function shift() as any ptr
        
        declare property count as uinteger
        
        declare sub clear()
        
        private:
            _counter as uinteger
    end type
    
end namespace 'Testly

#endif '__TESTLY_LIST_BI__
