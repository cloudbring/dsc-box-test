# Dollar Shave Club Test

## Assignment

Starting on https://www.dollarshaveclub.com/our-products, write 2 test scripts
using your preferred framework:
 1. Verify that the guest can add two “Magnanimous Post Shave” moisturizers.
 2. Verify that the guest can remove boogies “Dream Hair Cream” from their box

## Setup

These tests use `MiniTest` and `watir-webdriver` to do the assignment above.

```
bundle
```

## Run Tests

```
ruby test/test_cart.rb
```

Output:

```
Run options: --seed 29251

# Running:

..

Finished in 23.098900s, 0.0866 runs/s, 0.1299 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips
```

## Rapid Development

We have a simple development environment setup with `Guard`:

```
guard
```

### Flakiness

Working on this, the flakiness of AJAX requests and async animation updates with
Ember was an issue. I overcame with some fine tuning and strategic spin-waits.
The result, 20 times this code runs without issue.

```
for i in {1..20}; do ruby test/test_cart.rb; done
Run options: --seed 14110

# Running:

..

Finished in 22.941875s, 0.0872 runs/s, 0.1308 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 25531

# Running:

..

Finished in 22.817485s, 0.0877 runs/s, 0.1315 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 43055

# Running:

..

Finished in 21.618667s, 0.0925 runs/s, 0.1388 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 50812

# Running:

..

Finished in 20.379872s, 0.0981 runs/s, 0.1472 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 62812

# Running:

..

Finished in 23.463177s, 0.0852 runs/s, 0.1279 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 60996

# Running:

..

Finished in 22.680055s, 0.0882 runs/s, 0.1323 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 10277

# Running:

..

Finished in 21.174984s, 0.0945 runs/s, 0.1417 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 38171

# Running:

..

Finished in 21.828217s, 0.0916 runs/s, 0.1374 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 15141

# Running:

..

Finished in 22.615008s, 0.0884 runs/s, 0.1327 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 33146

# Running:

..

Finished in 23.637341s, 0.0846 runs/s, 0.1269 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 56383

# Running:

..

Finished in 23.731517s, 0.0843 runs/s, 0.1264 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 19597

# Running:

..

Finished in 23.181315s, 0.0863 runs/s, 0.1294 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 8310

# Running:

..

Finished in 22.801220s, 0.0877 runs/s, 0.1316 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 27636

# Running:

..

Finished in 21.967933s, 0.0910 runs/s, 0.1366 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 7508

# Running:

..

Finished in 23.464710s, 0.0852 runs/s, 0.1279 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 6791

# Running:

..

Finished in 22.295111s, 0.0897 runs/s, 0.1346 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 3554

# Running:

..

Finished in 21.576472s, 0.0927 runs/s, 0.1390 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 13196

# Running:

..

Finished in 21.564246s, 0.0927 runs/s, 0.1391 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 37129

# Running:

..

Finished in 22.927891s, 0.0872 runs/s, 0.1308 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips

Run options: --seed 15134

# Running:

..

Finished in 23.328476s, 0.0857 runs/s, 0.1286 assertions/s.

2 runs, 3 assertions, 0 failures, 0 errors, 0 skips
```
