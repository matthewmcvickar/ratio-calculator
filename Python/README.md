
---

**PLEASE NOTE:** Though this script works perfectly as is, it is no longer maintained. The current implementation of this script is a [functionally identical version written in Ruby](../../../).

---

# ratio-calculator.py

Need to find the missing value in a ratio? This Python script will help you do that quickly.

## Usage

Give numeric arguments in a series of three numbers with a `?`, `x`, or **any** non-number to indicate the missing value.

### Example

Solve for x: 2/4 = x/10

```
~ python ratio-calculator.py 2 4 ? 10
5
```

Two decimal places are included in default usage. Trailing zeroes and decimal points in the case of integers like the `5` above will be trimmed. See the `-r` flag below to change the number of included decimal places.

### Flags

#### -r [number], --round [number]

Round the result to `[number]` decimal places. Default: 2

```
~ python ratio-calculator.py 12 345 ? 678
23.58

~ python ratio-calculator.py 12 345 ? 678 -r 6
23.582609
```

#### -d, --empty_decimals

By default, integers are returned without a decimal point and two trailing zeroes, even though values are calculated as floating point numbers and rounded to two decimal places.

Use this flag if you *want* two empty decimal places to be returned.

```
~ python ratio-calculator.py 2 4 ? 10 -d
5.00
```

#### -v, --verbose

Instead of just returning the missing number, return the entire ratio as a string with the missing number plugged in.

```
~ python ratio-calculator.py -v 2 4 ? 10
2/4 [5]/10
```

#### -w, --without_newline

Returns result without a newline at the end. Useful for piping into other programs.

For example, copying the result to the clipboard on OS X:

```
~ python ratio-calculator.py 2 4 ? 10 -n | pbcopy
```


## Copy to Clipboard

Use the `--without_newline` flag to remove the newline that would otherwise be printed to the terminal, then pipe the result to `pbcopy` to copy the result to your clipboard, ready for pasting. (This only works on OS X.)

```
~ python ratio-calculator.py --without_newline 2 4 ? 10 | pbcopy
```

If you want to see the result as well as copy to the clipboard ([source](http://stackoverflow.com/questions/5677201)):

```
~ python ratio-calculator.py --without_newline 2 4 ? 10 | pbcopy | tee /dev/tty
5
```

## Thanks

- [Justin Falcone](http://github.com/modernserf) and [Cody Robbins](http://github.com/codyrobbins) for code review
