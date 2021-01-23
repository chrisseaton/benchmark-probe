require 'concurrent-ruby'

module Benchmark
  module Probe
    ITERATION_COUNTER = Concurrent::AtomicFixnum.new

    def self.monitor
      Thread.new do
        start = time
        loop do
          sleep 0.3
          
          now = time
          elapsed = now - start
          start = now

          iterations = read_iteration_counter
          # need to handle less than one iteration per second
          ips = iterations / elapsed

          $stderr.printf "[%.2f i/s]\n", ips
        end
      end
    end

    def self.read_iteration_counter
      loop do
        value = ITERATION_COUNTER.value
        if ITERATION_COUNTER.compare_and_set(value, 0)
          return value
        end
      end
    end

    def self.time
      Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end
  end

  def self.probe
    Probe::ITERATION_COUNTER.increment
  end
end

Benchmark::Probe.monitor
