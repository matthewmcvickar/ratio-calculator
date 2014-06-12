#!/usr/bin/env ruby

require 'optparse'

# Declare option defaults.
$options                   = {}
$options[:round]           = 2
$options[:empty_decimals]  = false
$options[:verbose]         = false
$options[:without_newline] = false

# Set up options.
opt_parser = OptionParser.new do |opt|
  opt.banner = 'Usage: ratio-calculator [OPTIONS] [NUMBERS]'

  opt.separator ''
  opt.separator 'Example: ratio-calculator 2 4 ? 10'
  opt.separator 'Returns: 5'
  opt.separator ''
  opt.separator 'Options:'

  opt.on('numbers N',
         'A string containing three numbers and a non-number (e.g., x or ?) that represents a ratio calculation in the form of a/b = c/d. E.g.: 2 4 ? 10') do
  end

  opt.on('-r N', '--round N',
         'How many decimal places to which the result will be rounded (up). Default: 2') do |n|
    $options[:round] = n
  end

  opt.on('-d', '--empty_decimals',
         'Includes the decimal point and trailing zeroes in an integer. Off by default. E.g.: 5.00.') do |d|
    $options[:empty_decimals] = d
  end

  opt.on('-v', '--verbose',
         'Returns ratio equation with missing ratio highlighted, instead of just missing number. E.g.: 1/2 [2]/4') do |v|
    $options[:verbose] = v
  end

  opt.on('-w', '--without_newline',
         'Returns result without a newline at the end. Useful for piping into other programs.') do |w|
  end

  opt.on_tail('-h', '--help', 'Show this message') do
    puts opt
    exit
  end
end

# Get options.
opt_parser.parse!

# Extract numbers from arguments remaining after the options specified above.
a, b, c, d = ARGV

# Round to the decimal specified in the argument.
def round_to_specified_decimal(number)
  result = sprintf('%.' + $options[:round].to_s + 'f', number)

  # Remove trailing zero and decimal if it's just an integer, unless otherwise flagged.
  if $options[:empty_decimals]
    return result
  else
    return result.chomp('.00')
  end
end

# Calculate value of missing number.
def calculate_ratio_via_multiplication(x, y, z)
  result = x.to_f*(y.to_f/z.to_f)
  return round_to_specified_decimal(result)
end

def calculate_ratio_via_division(x, y, z)
  result = x.to_f/(y.to_f/z.to_f)
  return round_to_specified_decimal(result)
end

# Add brackets around text.
def bracket(text)
  return '[' + text.to_s + ']'
end

# Return the equation with the result included (in brackets).
def verbose_result(w, x, y, z)
  return w + '/' + x + ' = ' + y + '/' + z
end

result         = nil
verbose_result = ''

# Find which of the four numbers is missing.
ARGV.each_with_index do |number, index|

  # Check for which part of the series isn't a number.
  if not (/[0-9]+/).match(number.to_s)

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

# p result
# p verbose_result

# If the --without_newline flag is turned on, return the result without a newline using `print` instead of `puts`.
def print_with_or_without_newline(data)
  if $options[:without_newline]
    print data
  else
    puts data
  end
end

# Print the results to the screen.
if $options[:verbose]
  print_with_or_without_newline(verbose_result)
else
  print_with_or_without_newline(result)
end
