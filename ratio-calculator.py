#!/usr/bin/python

import argparse
import sys

# Set up and parse arguments.
parser = argparse.ArgumentParser(description='Calculate the missing number in a ratio equation.')

parser.add_argument('numbers',
                    metavar='N',
                    type=str,
                    nargs='+',
                    help='An integer in the ratio equation. There must be three numbers and either an x or a ? in the set to calculate the missing value. E.g.: 2 4 ? 10')

parser.add_argument('-r',
                    '--round',
                    metavar='N',
                    type=int,
                    default=2,
                    help='How many decimal places to which the result will be rounded (up). Default: 2')

parser.add_argument('-v',
                    '--verbose',
                    action='store_true',
                    default=False,
                    help='Returns ratio equation with missing ratio highlighted, instead of just missing number. E.g.: 1/2 [2]/4')

parser.add_argument('-n',
                    '--without_newline',
                    action='store_true',
                    default=False,
                    help='Returns result without a newline at the end. Useful for piping into other programs.')

arguments = parser.parse_args()

# Extract numbers from arguments.
numbers = { 'a' : arguments.numbers[0],
            'b' : arguments.numbers[1],
            'c' : arguments.numbers[2],
            'd' : arguments.numbers[3] }

# Shorter variables for readability in equations.
a = numbers['a']
b = numbers['b']
c = numbers['c']
d = numbers['d']

# Find which of the four numbers is missing.
for key, value in numbers.items():
    if value == '?' or value == 'x':
        missing_number = key

# Round to the decimal specified in the argument.
def round_to_specified_decimal(number):
    return round(number, arguments.round)

# Remove trailing zero and decimal if it's just an integer.
def remove_trailing_zero(number):
    return str(number).rstrip('0').rstrip('.')

# Perform the appropriate calculation.
if missing_number is 'a':
    result = float(b)*(float(c)/float(d))
    result = remove_trailing_zero(round_to_specified_decimal(result))
    verbose_result = '[' + str(result) + ']' + '/' + b + ' = ' + c + '/' + d

if missing_number is 'b':
    result = float(a)/(float(c)/float(d))
    result = remove_trailing_zero(round_to_specified_decimal(result))
    verbose_result = a + '/' + '[' + str(result) + ']' + ' = ' + c + '/' + d

if missing_number is 'c':
    result = float(d)*(float(a)/float(b))
    result = remove_trailing_zero(round_to_specified_decimal(result))
    verbose_result = a + '/' + b + ' = ' + '[' + str(result) + ']' + '/' + d

if missing_number is 'd':
    result = float(c)/(float(a)/float(b))
    result = remove_trailing_zero(round_to_specified_decimal(result))
    verbose_result = a + '/' + b + ' = ' + c + '/' + '[' + str(result) + ']'

# If the simple flag is turned on, return the result without a newline.
def print_with_or_without_newline(data):
    if arguments.without_newline:
        sys.stdout.write(data)
    else:
        print(data)

# If verbose output was requested, give it. If not, just give the number.
# Use sys.stdout to avoid the newline that would otherwise be printed in the output.
if arguments.verbose:
    print_with_or_without_newline(verbose_result)
else:
    print_with_or_without_newline(result)
