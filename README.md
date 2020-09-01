# LedgerToTaskjuggler

If you track your time using the ledger format with [ledger-cli](https://www.ledger-cli.org) or [hledger](https://hledger.org) and you need to convert that to [taskjuggler](https://taskjuggler.org) bookings format, this tool is for you.


## Requirements
- Install Swift 5.2: https://swift.org/download/ 
- Install hledger (for CSV generation)

## Installing
A `makefile` with an install command is in this repo. By default it installs the program in `~/.local/bin`. If you use this default location, make sure it is in your path.

To install with the default prefix:
```sh
make install
```

Install in a different folder (change the variable value to whatever you want):
```sh
make install PREFIX=~/testPrefix
```

## Running
```sh
l2tj LEDGERACCOUNTPREFIX LEVEL myfile.timeclock 2020-08-25 2020-08-30
```

- `LEDGERACCOUNTPREFIX`: used to filter accounts on the ledger file
- `LEVEL`: passed as is to `hledger`. You can use `-2`, `-3`, `-4` or similar depending on the max level you want to use in the conversion.

The output will be the bookings in the standard output.
