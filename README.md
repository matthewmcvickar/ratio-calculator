# ratio-calculator.py

Need to find the missing value in a ratio? This Python script will help you do that quickly.


## Usage

Give numeric arguments in a series of three numbers with a `?`, `x`, or **any** non-number to indicate the missing value.

### Example

Solve for x: 2/4 = x/10

```
python ratio-calculator.py 2 4 ? 10
```

Returns:

```
5
```

### Flags

#### -r [number], --round [number]

Round the result to `[number]` decimal places. Default: 2

```
~ python ratio-calculator.py 12 345 x 678
23.58

~ python ratio-calculator.py 12 345 x 678 -r 6
23.582609
```

#### -v, --verbose

Instead of just returning the missing number, return the entire ratio as a string with the missing number plugged in.

```
~ python ratio-calculator.py -v 2 4 ? 10
2/4 [5]/10
```

#### -n, --without_newline

Returns result without a newline at the end. Useful for piping into other programs.

For example, copying the result to the clipboard on OS X:

```
~ python ratio-calculator.py 12 345 x 678 -n | pbcopy
```


## Copy to Clipboard

Use the `--without_newline` flag to remove the newline that would otherwise be printed to the terminal, then pipe the result to `pbcopy` to copy the result to your clipboard, ready for pasting. (This only works on OS X.)

```
python ratio-calculator.py --without_newline 2 4 ? 10 | pbcopy
```

If you want to see the result as well as copy to the clipboard ([source](http://stackoverflow.com/questions/5677201)):

```
python ratio-calculator.py --without_newline 2 4 ? 10 | tee /dev/tty | pbcopy
```

## Thanks

- [Justin Falcone](http://github.com/modernserf) and [Cody Robbins](http://github.com/codyrobbins) for code review
