# ratio-calculator.rb

Need to find the missing value in a ratio? This script will help you do that quickly.

**Note:** for convenience, I've made this into a [Ratio Calculator Alfred workflow](https://github.com/matthewmcvickar/alfred-ratio-calculator).

## Usage

Give numeric arguments in a series of three numbers with a `?`, `x`, or **any** non-number to indicate the missing value.

### Example

Solve for x: 2/4 = x/10

```
~ ruby ratio-calculator.rb 2 4 ? 10
5
```

Two decimal places are included in default usage. Trailing zeroes and decimal points in the case of integers like the `5` above will be trimmed. See the `-r` flag below to change the number of included decimal places.

### Flags

#### -r [number], --round [number]

Round the result to `[number]` decimal places. Default: 2

```
~ ruby ratio-calculator.rb 12 345 ? 678
23.58

~ ruby ratio-calculator.rb 12 345 ? 678 -r 6
23.582609
```

#### -d, --empty_decimals

By default, integers are returned without a decimal point and two trailing zeroes, even though values are calculated as floating point numbers and rounded to two decimal places.

Use this flag if you *want* two empty decimal places to be returned.

```
~ ruby ratio-calculator.rb 2 4 ? 10 -d
5.00
```

#### -v, --verbose

Instead of just returning the missing number, return the entire ratio as a string with the missing number plugged in.

```
~ ruby ratio-calculator.rb -v 2 4 ? 10
2/4 [5]/10
```

#### -w, --without_newline

Returns result without a newline at the end. Useful for piping into other programs.

For example, copying the result to the clipboard on OS X:

```
~ ruby ratio-calculator.rb 2 4 ? 10 -w | pbcopy
```


## Copy to Clipboard

Use the `--without_newline` flag to remove the newline that would otherwise be printed to the terminal, then pipe the result to `pbcopy` to copy the result to your clipboard, ready for pasting. (This only works on OS X.)

```
~ ruby ratio-calculator.rb --without_newline 2 4 ? 10 | pbcopy
```

If you want to see the result as well as copy to the clipboard ([source](http://stackoverflow.com/questions/5677201)):

```
~ ruby ratio-calculator.rb --without_newline 2 4 ? 10 | pbcopy | tee /dev/tty
5
```

---

## See Also

I've written a [Ratio Calculator Alfred workflow](https://github.com/matthewmcvickar/alfred-ratio-calculator) that uses this script. It is the most convenient application for me.

The current implementation of this script is written in Ruby, but there is an [identical working Python version](/Python) as well.


## Thanks

- [Justin Falcone](http://github.com/modernserf) and [Cody Robbins](http://github.com/codyrobbins) for code review
