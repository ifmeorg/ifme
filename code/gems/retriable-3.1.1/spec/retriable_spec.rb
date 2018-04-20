require_relative "spec_helper"

class TestError < Exception; end

describe Retriable do
  subject do
    Retriable
  end

  before do
    srand 0
  end

  describe "with sleep disabled" do
    before do
      Retriable.configure do |c|
        c.sleep_disabled = true
      end
    end

    it "stops at first try if the block does not raise an exception" do
      tries = 0
      subject.retriable do
        tries += 1
      end

      expect(tries).must_equal 1
    end

    it "raises a LocalJumpError if #retriable is not given a block" do
      expect do
        subject.retriable on: StandardError
      end.must_raise LocalJumpError

      expect do
        subject.retriable on: StandardError, timeout: 2
      end.must_raise LocalJumpError
    end

    it "makes 3 tries when retrying block of code raising StandardError with no arguments" do
      tries = 0

      expect do
        subject.retriable do
          tries += 1
          raise StandardError.new, "StandardError occurred"
        end
      end.must_raise StandardError

      expect(tries).must_equal 3
    end

    it "makes only 1 try when exception raised is not ancestor of StandardError" do
      tries = 0

      expect do
        subject.retriable do
          tries += 1
          raise TestError.new, "TestError occurred"
        end
      end.must_raise TestError

      expect(tries).must_equal 1
    end

    it "#retriable with custom exception tries 3 times and re-raises the exception" do
      tries = 0

      expect do
        subject.retriable on: TestError do
          tries += 1
          raise TestError.new, "TestError occurred"
        end
      end.must_raise TestError

      expect(tries).must_equal 3
    end

    it "#retriable tries 10 times" do
      tries = 0

      expect do
        subject.retriable(tries: 10) do
          tries += 1
          raise StandardError.new, "StandardError occurred"
        end
      end.must_raise StandardError

      expect(tries).must_equal 10
    end

    it "#retriable will timeout after 1 second" do
      expect do
        subject.retriable timeout: 1 do
          sleep 1.1
        end
      end.must_raise Timeout::Error
    end

    it "applies a randomized exponential backoff to each try" do
      tries = 0
      time_table = []

      handler = lambda do |exception, _try, _elapsed_time, next_interval|
        expect(exception.class).must_equal ArgumentError
        time_table << next_interval
      end

      expect do
        Retriable.retriable(
          on: [EOFError, ArgumentError],
          on_retry: handler,
          tries: 10,
        ) do
          tries += 1
          raise ArgumentError.new, "ArgumentError occurred"
        end
      end.must_raise ArgumentError

      expect(time_table).must_equal([
        0.5244067512211441,
        0.9113920238761231,
        1.2406087918999114,
        1.7632403621664823,
        2.338001204738311,
        4.350816718580626,
        5.339852157217869,
        11.889873261212443,
        18.756037881636484,
        nil,
      ])

      expect(tries).must_equal(10)
    end

    describe "retries with an on_#retriable handler, 6 max retries, and a 0.0 rand_factor" do
      before do
        tries = 6
        @try_count = 0
        @time_table = {}

        handler = lambda do |exception, try, _elapsed_time, next_interval|
          expect(exception.class).must_equal ArgumentError
          @time_table[try] = next_interval
        end

        Retriable.retriable(
          on: [EOFError, ArgumentError],
          on_retry: handler,
          rand_factor: 0.0,
          tries: tries,
        ) do
          @try_count += 1
          raise ArgumentError.new, "ArgumentError occurred" if @try_count < tries
        end
      end

      it "makes 6 tries" do
        expect(@try_count).must_equal 6
      end

      it "applies a non-randomized exponential backoff to each try" do
        expect(@time_table).must_equal(
          1 => 0.5,
          2 => 0.75,
          3 => 1.125,
          4 => 1.6875,
          5 => 2.53125,
        )
      end
    end

    it "#retriable has a max interval of 1.5 seconds" do
      tries = 0
      time_table = {}

      handler = lambda do |_exception, try, _elapsed_time, next_interval|
        time_table[try] = next_interval
      end

      expect do
        subject.retriable(
          on: StandardError,
          on_retry: handler,
          rand_factor: 0.0,
          tries: 5,
          max_interval: 1.5,
        ) do
          tries += 1
          raise StandardError.new, "StandardError occurred"
        end
      end.must_raise StandardError

      expect(time_table).must_equal(
        1 => 0.5,
        2 => 0.75,
        3 => 1.125,
        4 => 1.5,
        5 => nil,
      )
    end

    it "#retriable with custom defined intervals" do
      intervals = [
        0.5,
        0.75,
        1.125,
        1.5,
        1.5,
      ]
      time_table = {}

      handler = lambda do |_exception, try, _elapsed_time, next_interval|
        time_table[try] = next_interval
      end

      try_count = 0

      expect do
        subject.retriable(
          on_retry: handler,
          intervals: intervals,
        ) do
          try_count += 1
          raise StandardError.new, "StandardError occurred"
        end
      end.must_raise StandardError

      expect(time_table).must_equal(
        1 => 0.5,
        2 => 0.75,
        3 => 1.125,
        4 => 1.5,
        5 => 1.5,
        6 => nil,
      )

      expect(try_count).must_equal(6)
    end

    it "#retriable with a hash exception where the value is an exception message pattern" do
      e = expect do
        subject.retriable on: { TestError => /something went wrong/ } do
          raise TestError, "something went wrong"
        end
      end.must_raise TestError

      expect(e.message).must_equal "something went wrong"
    end

    it "#retriable with a hash exception list matches exception subclasses" do
      class SecondTestError < TestError; end
      class DifferentTestError < Exception; end

      tries = 0
      e = expect do
        subject.retriable on: {
            DifferentTestError => /should never happen/,
            TestError => /something went wrong/,
            DifferentTestError => /also should never happen/,
          }, tries: 4 do
          tries += 1
          raise SecondTestError, "something went wrong"
        end
      end.must_raise SecondTestError

      expect(e.message).must_equal "something went wrong"
      expect(tries).must_equal 4
    end

    it "#retriable with a hash exception list does not retry matching exception subclass but not message" do
      class SecondTestError < TestError; end

      tries = 0
      expect do
        subject.retriable on: { TestError => /something went wrong/ }, tries: 4 do
          tries += 1
          raise SecondTestError, "not a match"
        end
      end.must_raise SecondTestError

      expect(tries).must_equal 1
    end

    it "#retriable with a hash exception list where the values are exception message patterns" do
      tries = 0
      exceptions = []
      handler = lambda do |exception, try, _elapsed_time, _next_interval|
        exceptions[try] = exception
      end

      e = expect do
        subject.retriable tries: 4, on: { StandardError => nil, TestError => [/foo/, /bar/] }, on_retry: handler do
          tries += 1
          case tries
          when 1
            raise TestError, "foo"
          when 2
            raise TestError, "bar"
          when 3
            raise StandardError
          else
            raise TestError, "crash"
          end
        end
      end.must_raise TestError

      expect(e.message).must_equal "crash"
      expect(exceptions[1].class).must_equal TestError
      expect(exceptions[1].message).must_equal "foo"
      expect(exceptions[2].class).must_equal TestError
      expect(exceptions[2].message).must_equal "bar"
      expect(exceptions[3].class).must_equal StandardError
    end

    it "#retriable can be called in the global scope" do
      expect do
        retriable do
          puts "should raise NoMethodError"
        end
      end.must_raise NoMethodError

      require_relative "../lib/retriable/core_ext/kernel"

      tries = 0

      expect do
        retriable do
          tries += 1
          raise StandardError
        end
      end.must_raise StandardError

      expect(tries).must_equal 3
    end
  end

  it "#retriable runs for a max elapsed time of 2 seconds" do
    subject.configure do |c|
      c.sleep_disabled = false
    end

    expect(subject.config.sleep_disabled).must_equal false

    tries = 0
    time_table = {}

    handler = lambda do |_exception, try, elapsed_time, _next_interval|
      time_table[try] = elapsed_time
    end

    expect do
      subject.retriable(
        base_interval: 1.0,
        multiplier: 1.0,
        rand_factor: 0.0,
        max_elapsed_time: 2.0,
        on_retry: handler,
      ) do
        tries += 1
        raise EOFError
      end
    end.must_raise EOFError

    expect(tries).must_equal 2
  end

  it "raises NoMethodError on invalid configuration" do
    assert_raises NoMethodError do
      Retriable.configure { |c| c.does_not_exist = 123 }
    end
  end

  it "raises ArgumentError on invalid option on #retriable" do
    assert_raises ArgumentError do
      Retriable.retriable(does_not_exist: 123)
    end
  end

  describe "#with_context" do
    before do
      Retriable.configure do |c|
        c.sleep_disabled = true
        c.contexts[:sql] = { tries: 1 }
        c.contexts[:api] = { tries: 3 }
      end
    end

    it "sql context stops at first try if the block does not raise an exception" do
      tries = 0
      subject.with_context(:sql) do
        tries += 1
      end

      expect(tries).must_equal 1
    end

    it "with_context respects the context options" do
      tries = 0

      expect do
        subject.with_context(:api) do
          tries += 1
          raise StandardError.new, "StandardError occurred"
        end
      end.must_raise StandardError

      expect(tries).must_equal 3
    end

    it "with_context allows override options" do
      tries = 0

      expect do
        subject.with_context(:sql, tries: 5) do
          tries += 1
          raise StandardError.new, "StandardError occurred"
        end
      end.must_raise StandardError

      expect(tries).must_equal 5
    end

    it "raises an ArgumentError when the context isn't found" do
      tries = 0

      expect do
        subject.with_context(:wtf) do
          tries += 1
        end
      end.must_raise ArgumentError
    end
  end
end
