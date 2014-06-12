#!/usr/bin/env ruby

require 'optparse'

# Declare option defaults.
options                 = {}
options.round           = 2
options.empty_decimals  = false
options.verbose         = false
options.without_newline = false

# Set up options.
OptionParser.new do |opts|
  opts.banner = 'Calculate the missing number in a ratio equation.'

  opts.separator ''
  opts.separator 'Usage: ratio-calculator.rb [options] 2 4 ? 10'

  opts.separator ''
  opts.separator 'Specific options:'

  opts.on('numbers N',
          'An integer in the ratio equation. There must be three numbers and either an x or a ? in the set to calculate the missing value. E.g.: 2 4 ? 10') do |numbers|
    options.numbers = numbers
  end

  opts.on('-r N',
          '--round N',
          Integer,
          'How many decimal places to which the result will be rounded (up). Default: 2') do |n|
    options.round = n
  end

  opts.on('-d',
          '--empty_decimals',
          'Includes the decimal point and trailing zeroes in an integer. Off by default. E.g.: 5.00.') do |d|
    options.empty_decimals = d
  end

  opts.on('-v',
          '--verbose',
          'Returns ratio equation with missing ratio highlighted, instead of just missing number. E.g.: 1/2 [2]/4') do |v|
    options.verbose = v
  end

  opts.on('-w',
          '--without_newline',
          'Returns result without a newline at the end. Useful for piping into other programs.') do |w|
  end

  opts.on_tail('-h', '--help', 'Show this message') do
    puts opts
    exit
  end

  opt_parser.parse!(args)
  options
end

# Extract numbers from arguments.
a, b, c, d = options.numbers.each

# Round to the decimal specified in the argument.
def round_to_specified_decimal(number)
  result = ('%.' + str(arguments.round) + 'f') % number

  # Remove trailing zero and decimal if it's just an integer, unless otherwise flagged.
  if arguments.empty_decimals
    return result
  else
    return result.rstrip('0').rstrip('.')
  end
end

# Calculate value of missing number.
def calculate_ratio_via_multiplication(x, y, z)
  result = float(x)*(float(y)/float(z))
  return round_to_specified_decimal(result)
end

def calculate_ratio_via_division(x, y, z)
  result = float(x)/(float(y)/float(z))
  return round_to_specified_decimal(result)
end

# Add brackets around text.
def bracket(text)
  return '[' + str(text) + ']'
end

# Return the equation with the result included (in brackets).
def verbose_result(w, x, y, z)
  return w + '/' + x + ' = ' + y + '/' + z
end

# Find which of the four numbers is missing.
for index, number in enumerate(arguments.numbers)

  # Check for which part of the series isn't a number.
  if not re.search('[0-9]+', number)

    # Perform the appropriate calculation.
    if index == 0
      result = calculate_ratio_via_multiplication(b, c, d)
      verbose_result = verbose_result(bracket(result), b, c, d)

    elsif index == 1
      result = calculate_ratio_via_division(a, c, d)
      verbose_result = verbose_result(a, bracket(result), c, d)

    elsif index == 2
      result = calculate_ratio_via_multiplication(d, a, b)
      verbose_result = verbose_result(a, b, bracket(result), d)

    elsif index == 3
      result = calculate_ratio_via_division(c, a, b)
      verbose_result = verbose_result(a, b, c, bracket(result))

    end

  end
end

# If the --without_newline flag is turned on, return the result without a newline using sys.stdout.
def print_with_or_without_newline(data)
  if arguments.without_newline
    p data
  else
    p data
  end
end

# Print the results to the screen.
def print_result(just_the_missing_number, the_entire_equation)
  if arguments.verbose
    print_with_or_without_newline(the_entire_equation)
  else
    print_with_or_without_newline(just_the_missing_number)
  end
end

print_result(result, verbose_result)
