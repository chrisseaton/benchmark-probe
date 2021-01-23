require 'benchmark/probe'

# Let's pretend we don't control this code
def my_framework
  loop do
    yield
  end
end

def fib(n)
  if n <= 2
    n
  else
    fib(n - 1) + fib(n - 2)
  end
end

my_framework do
  Benchmark.probe
  fib(20)
end
