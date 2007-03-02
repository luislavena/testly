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

#ifndef __TESTLY_SUITE_BI__
#define __TESTLY_SUITE_BI__

#include once "testly.bi"
#include once "testly_list.bi"

namespace Testly
    '# AssertCount is used to store results of the Suite
    type AssertCount
        assertions as uinteger
        failures as uinteger
        errors as uinteger
    end type
    
    '# Suite defines a list of test to be processed
    '# also, it could offer a setup and teardown functionality before and after running the
    '# tests defined.
    '# results (counts) are collected in stats (AssertCount)
    '# this suite can also be excluded from results and failures/errors collecting process
    '# useful for internal testing.
    type Suite
        declare constructor(byref as string = "", byref as suite_func_t = 0, byref as suite_func_t = 0)
        declare destructor()
        
        suite_name as string
        
        setup_func as suite_func_t
        setup_failed as boolean
        
        teardown_func as suite_func_t
        teardown_failed as boolean
        
        declare property tests_count as uinteger
        
        exclude as boolean
        tests_list as List ptr
        stats as AssertCount
    end type
    
end namespace 'Testly

#endif '__TESTLY_SUITE_BI__
