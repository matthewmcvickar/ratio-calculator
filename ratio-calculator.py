#!/usr/bin/python

import argparse
import sys
import re

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


parser.add_argument('-d',
                    '--empty_decimals',
                    action='store_true',
                    default=False,
                    help='Includes the decimal point and trailing zeroes in an integer. Off by default. E.g.: 5.00.')

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
a, b, c, d = arguments.numbers

# Round to the decimal specified in the argument.
def round_to_specified_decimal(number):
    result = ('%.' + str(arguments.round) + 'f') % number

    # Remove trailing zero and decimal if it's just an integer, unless otherwise flagged.
    if arguments.empty_decimals:
        return result
    else:
        return result.rstrip('0').rstrip('.')

# Calculate value of missing number.
def calculate_ratio_via_multiplication(x, y, z):
    result = float(x)*(float(y)/float(z))
    return round_to_specified_decimal(result)

def calculate_ratio_via_division(x, y, z):
    result = float(x)/(float(y)/float(z))
    return round_to_specified_decimal(result)

# Add brackets around text.
def bracket(text):
    return '[' + str(text) + ']'

# Return the equation with the result included (in brackets).
def verbose_result(w, x, y, z):
    return w + '/' + x + ' = ' + y + '/' + z

# Find which of the four numbers is missing.
for index, number in enumerate(arguments.numbers):

    # Check for which part of the series isn't a number.
    if not re.search('[0-9]+', number):

        # Perform the appropriate calculation.
        if index == 0:
            result = calculate_ratio_via_multiplication(b, c, d)
            verbose_result = verbose_result(bracket(result), b, c, d)

        elif index == 1:
            result = calculate_ratio_via_division(a, c, d)
            verbose_result = verbose_result(a, bracket(result), c, d)

        elif index == 2:
            result = calculate_ratio_via_multiplication(d, a, b)
            verbose_result = verbose_result(a, b, bracket(result), d)

        elif index == 3:
            result = calculate_ratio_via_division(c, a, b)
            verbose_result = verbose_result(a, b, c, bracket(result))

# If the --without_newline flag is turned on, return the result without a newline using sys.stdout.
def print_with_or_without_newline(data):
    if arguments.without_newline:
        sys.stdout.write(data)
    else:
        print(data)

# Print the results to the screen.
def print_result(just_the_missing_number, the_entire_equation):
    if arguments.verbose:
        print_with_or_without_newline(the_entire_equation)
    else:
        print_with_or_without_newline(just_the_missing_number)

print_result(result, verbose_result)
