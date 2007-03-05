'#--
'# Copyright (c) 2006-2007 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
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
