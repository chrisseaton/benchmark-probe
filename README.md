Have you ever wanted to benchmark a system in the style of `benchmark-ips`, but the loop for the system was in code that you didn't control, such as a web framework or routing library? `benchmark-probe` could help you do that.

Instead of writing:

```ruby
require 'benchmark/ips'

Benchmark.ips do |x|
  x.report('...') do
    ... my code
  end
end
```

You write:

```ruby
require 'benchmark/probe'

my_framework do
  Benchmark.probe
  ... my code
end
```

You can put `Benchmark.probe` anywhere you want in your program and the number of times per second it is hit will be reported while your program runs.

```
[4019.76 i/s]
[2899.57 i/s]
[2867.24 i/s]
[2893.48 i/s]
[2869.34 i/s]
```
