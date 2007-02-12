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

#include once "testly.bi"
#include once "testly_helpers.bi"
#include once "testly_common.bi"
#include once "crt.bi"

namespace Testly
    namespace Helpers
        dim shared CURRENT_SUITE as Suite ptr
        dim shared CURRENT_TEST as TestCase ptr
        
        '#############################################################
        '# suite and test adding helpers
        '# these helpers provide functionality to register a new suite 
        '# in the SUITES_LIST and set the references for use with 
        '# add_test_helper
        function add_suite(byref suite_name as string, byref setup_func as suite_func_t = 0, byref teardown_func as suite_func_t = 0) as boolean
            dim result as boolean
            dim new_suite as Suite ptr
            
            '# verify if that suite is already registered
            if (find_suite(SUITES_LIST, suite_name) = 0) then
                '# is not, so add a new one
                new_suite = new Suite(suite_name, setup_func, teardown_func)
                
                SUITES_LIST->add(new_suite)
                
                '# adjust the CURRENT_ for this new suite
                CURRENT_SUITE = new_suite
                CURRENT_TEST = 0
                result = true
            else
                '# its already defined, what is supposed to happen?
                result = false
            end if
            
            return result
        end function
        
        
        '# add_test_helper will try to add a new test in the CURRENT_SUITE
        '# only if isn't defined already (another test with the same name
        function add_test(byref test_name as string, byref test_func as test_func_t) as boolean
            dim result as boolean
            dim new_test as TestCase ptr
            
            '# check if this suite contains a test with that name
            if (find_test(CURRENT_SUITE->tests_list, test_name) = 0) then
                '# no test registered with that name, adding a new one
                new_test = new TestCase(test_name, test_func)
                
                CURRENT_SUITE->tests_list->add(new_test)
                
                '# adjust the CURRENT_TEST to reflect this addition
                CURRENT_TEST = new_test
                result = true
            else
                '# there exist a test with this name
                result = false
            end if
            
            return result
        end function
        
        
        '# run_tests_helper() will loop for the suites, executing
        '# their setup and teardown functions and collect assertions information
        '# that later will be shown in the summary
        '# suites marked with exclude = true will be executed but
        '# the results of them will not be referenced in the totals
        function run_tests() as boolean
            dim result as boolean
            dim suite_node as ListNode ptr
            dim test_node as ListNode ptr
            dim success as boolean
            
            dim failure_node as ListNode ptr
            dim failure as FailureLog ptr
            dim message1 as string
            dim message2 as string
            
            dim before as AssertCount
            dim collect as AssertCount
            dim suites_count as uinteger
            dim tests_count as uinteger
            
            dim begin_time as double
            dim end_time as double
            
            print !"\r\nStarted"
            '# We must record the running time of all the suites
            begin_time = timer
            
            '# clear stats
            suites_count = 0
            tests_count = 0
            
            '# iterate thru SUITES_LIST
            suite_node = SUITES_LIST->first
            do until (suite_node = 0)
                '# adjust RUNNING_SUITE
                RUNNING_SUITE = cast(Suite ptr, suite_node->value)
                '# clear RUNNING_TEST
                RUNNING_TEST = 0
                
                '# now do initialization of the suite
                if not (RUNNING_SUITE->setup_func = 0) then
                    success = RUNNING_SUITE->setup_func()
                    
                    if (success = false) then
                        RUNNING_SUITE->setup_failed = true
                        '# stats information should always be collected, excluding the suite or not
                        RUNNING_SUITE->stats.errors += 1
                        if (RUNNING_SUITE->exclude = false) then
                            log_failure(RUNNING_SUITE->suite_name, "", "", 0, "Failed suite setup.", true)
                        end if
                    end if
                end if
                
                '# iterate thru the suite tests
                test_node = RUNNING_SUITE->tests_list->first
                do until (test_node = 0)
                    RUNNING_TEST = cast(TestCase ptr, test_node->value)
                    
                    '# record the number of assertions prior executing the test
                    before = RUNNING_SUITE->stats
                    
                    '# now execute the test
                    RUNNING_TEST->test_func()
                    
                    '# compare the results and print the success or failure
                    with RUNNING_SUITE->stats
                        if (.failures = before.failures) and (.errors = before.errors) then
                            '# test passed
                            RUNNING_TEST->test_passed = true
                            
                            '# only show if suite isn't excluded
                            if (RUNNING_SUITE->exclude = false) then
                                print ".";
                            end if
                        else
                            '# test failed, give errors priority over failures
                            RUNNING_TEST->test_passed = false
                            
                            '# only show if suite isn't excluded
                            if (RUNNING_SUITE->exclude = false) then
                                if not (.errors = before.errors) then
                                    print "E";
                                else
                                    print "F";
                                end if
                            end if
                        end if
                    end with
                    
                    test_node = test_node->next
                loop
                '# clear RUNNING_TEST before suite teardown
                RUNNING_TEST = 0
                
                '# now do teardown of the suite
                if not (RUNNING_SUITE->teardown_func = 0) then
                    success = RUNNING_SUITE->teardown_func()
                    
                    if (success = false) then
                        RUNNING_SUITE->teardown_failed = true
                        '# stats information should always be collected, excluding the suite or not
                        RUNNING_SUITE->stats.errors += 1
                        if (RUNNING_SUITE->exclude = false) then
                            log_failure(RUNNING_SUITE->suite_name, "", "", 0, "Failed suite teardown.", true)
                        end if
                    end if
                end if
                
                '# collect the results prior jumping next suite
                if (RUNNING_SUITE->exclude = false) then
                    '# increment the counters
                    suites_count += 1
                    tests_count += RUNNING_SUITE->tests_count
                    
                    '# record/collect the stats
                    with RUNNING_SUITE->stats
                        collect.assertions += .assertions
                        collect.failures += .failures
                        collect.errors += .errors
                    end with
                end if
                
                '# continue to next suite
                suite_node = suite_node->next
            loop
            end_time = timer
            print ""
            
            printf(!"Finished in %.3f seconds.\r\n\r\n", (end_time - begin_time))
            
            '# there are failures/errors?
            if (FAILURES_LIST->count > 0) then
                '# there are, now list them
                result = false
                
                print !"Failures and Errors:\r\n"
                
                failure_node = FAILURES_LIST->first
                do until (failure_node = 0)
                    message1 = ""
                    message2 = ""
                    
                    failure = cast(FailureLog ptr, failure_node->value)
                    message1 += failure->suite_name
                    if (len(failure->test_name) > 0) then
                        message1 += ", " + failure->test_name
                    end if
                    
                    if (failure->is_error = true) then
                        message1 += " with error:"
                    else
                        message1 += " failed:"
                    end if
                    
                    message2 += space(2)
                    if (len(failure->filename) > 0) then
                        message2 += failure->filename + ":" + str(failure->linenumber) + " - "
                    end if
                    
                    message2 += failure->message
                        
                    print message1
                    print message2
                    print ""
                    
                    failure_node = failure_node->next
                loop
            else
                result = true
            end if
            
            with collect
                printf(!"%d suites, %d tests, %d assertions, %d failures, %d errors\r\n", _
                        suites_count, tests_count, .assertions, .failures, .errors)
            end with
            
            return result
        end function
        
    end namespace 'Helpers
end namespace 'Testly
