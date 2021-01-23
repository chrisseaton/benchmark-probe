require 'benchmark/ips'

def fib(n)
  if n <= 2
    n
  else
    fib(n - 1) + fib(n - 2)
  end
end

Benchmark.ips do |x|
  x.report('fib') do
    fib(14)
  end
end
