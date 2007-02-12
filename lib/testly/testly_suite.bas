'#--
'# Copyright (c) 2006-2007 Luis Lavena, Multimedia systems
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

#include once "testly_suite.bi"
#include once "testly_case.bi"

namespace Testly
    '#############################################################
    '# Suite
    '# default ctor()
    constructor Suite(byref new_name as string = "", byref new_setup_func as suite_func_t = 0, byref new_teardown_func as suite_func_t = 0)
        '# assign the suite properties
        suite_name = new_name
        
        setup_func = new_setup_func
        teardown_func = new_teardown_func
        
        tests_list = new List
    end constructor
    
    '# dtor()
    destructor Suite()
        dim test as TestCase ptr
        
        '# remove the Suite tests
        do while (tests_list->count > 0)
            test = cast(TestCase ptr, tests_list->shift())
            delete test
        loop
    end destructor
    
    '# property tests_count as uinteger
    property Suite.tests_count as uinteger
        return tests_list->count
    end property
    
end namespace 'Testly
