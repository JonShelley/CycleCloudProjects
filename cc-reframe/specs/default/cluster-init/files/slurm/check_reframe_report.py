#!/usr/bin/env python3
import json as js
import re
import argparse
import string

#####################################################################################
parser = argparse.ArgumentParser(description='Check reframe output')
parser.add_argument("-f", "--file", help="path to the input file")
args = parser.parse_args()

js_input_file = args.file
#####################################################################################

js_file = open(js_input_file)
vm_report = js.load(js_file)

num_failures = vm_report["session_info"]["num_failures"]
first_failed_test = vm_report["runs"][0]["testcases"][0]["name"]
reason_for_failure = vm_report["runs"][0]["testcases"][0]["fail_reason"]

print("{}:{}:{}".format(num_failures,first_failed_test,reason_for_failure))
