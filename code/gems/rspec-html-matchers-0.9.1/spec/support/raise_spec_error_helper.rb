RSpec::Matchers.define :raise_spec_error do |expected_exception_msg|
  define_method :actual_msg do
    @actual_msg
  end

  define_method :catched_exception do
    @catched_exception
  end

  match do |block|
    begin
      block.call
      false
    rescue RSpec::Expectations::ExpectationNotMetError => rspec_error
      @actual_msg = rspec_error.message

      case expected_exception_msg
      when String
        actual_msg == expected_exception_msg
      when Regexp
        actual_msg =~ expected_exception_msg
      end
    rescue StandardError => e
      @catched_exception = e
      false
    end
  end

  supports_block_expectations

  failure_message do |block|
    if actual_msg
<<MSG
expected RSpec::Expectations::ExpectationNotMetError with message:
#{expected_exception_msg}

got:
#{actual_msg}

Diff:
#{RSpec::Support::Differ.new.diff_as_string(actual_msg,expected_exception_msg.to_s)}
MSG
    elsif catched_exception
      "expected RSpec::Expectations::ExpectationNotMetError, but was #{catched_exception.inspect}"
    else
      "expected RSpec::Expectations::ExpectationNotMetError, but was no exception"
    end
  end
end
