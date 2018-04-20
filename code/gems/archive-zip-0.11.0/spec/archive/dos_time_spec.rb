# encoding: UTF-8

require 'minitest/autorun'

require 'archive/support/time'

describe 'Archive::DOSTime.new' do
  let(:epoc) { 0b0000000_0001_00001_00000_000000_00000 }
  let(:end_times) { 0b1110111_1100_11111_11000_111011_11101 }

  it 'uses the current time when no structure is given' do
    now = Time.now.localtime
    dos_time = Archive::DOSTime.new.to_time

    now.year.must_be_close_to(dos_time.year, 1)
    now.month.must_be_close_to(dos_time.month, 1)
    now.day.must_be_close_to(dos_time.day, 1)
    now.hour.must_be_close_to(dos_time.hour, 1)
    now.min.must_be_close_to(dos_time.min, 1)
    now.sec.must_be_close_to(dos_time.sec, 3)
  end

  it 'accepts valid Integer structures' do
    Archive::DOSTime.new(epoc)
    Archive::DOSTime.new(end_times)
  end

  it 'accepts valid String structures' do
    Archive::DOSTime.new([epoc].pack('V'))
    Archive::DOSTime.new([end_times].pack('V'))
  end

  it 'rejects invalid Integer structures' do
    # Second must not be greater than 29.
    proc {
      Archive::DOSTime.new(epoc | 0b0000000_0000_00000_00000_000000_11110)
    }.must_raise(ArgumentError)

    # Minute must not be greater than 59.
    proc {
      Archive::DOSTime.new(epoc | 0b0000000_0000_00000_00000_111100_00000)
    }.must_raise(ArgumentError)

    # Hour must not be greater than 24.
    proc {
      Archive::DOSTime.new(epoc | 0b0000000_0000_00000_11001_000000_00000)
    }.must_raise(ArgumentError)

    # Day must not be zero.
    proc {
      Archive::DOSTime.new(epoc & 0b1111111_1111_00000_11111_111111_11111)
    }.must_raise(ArgumentError)

    # Month must not be zero.
    proc {
      Archive::DOSTime.new(epoc & 0b1111111_0000_11111_11111_111111_11111)
    }.must_raise(ArgumentError)

    # Month must not be greater than 12.
    proc {
      Archive::DOSTime.new(epoc | 0b0000000_1101_00000_00000_000000_00000)
    }.must_raise(ArgumentError)

    # Year must not be greater than 119.
    proc {
      Archive::DOSTime.new(epoc | 0b1111000_0000_00000_00000_000000_00000)
    }.must_raise(ArgumentError)
  end

  it 'rejects invalid String structures' do
    # Second must not be greater than 29.
    proc {
      packed = [epoc | 0b0000000_0000_00000_00000_000000_11110].pack('V')
      Archive::DOSTime.new(packed)
    }.must_raise(ArgumentError)

    # Minute must not be greater than 59.
    proc {
      packed = [epoc | 0b0000000_0000_00000_00000_111100_00000].pack('V')
      Archive::DOSTime.new(packed)
    }.must_raise(ArgumentError)

    # Hour must not be greater than 24.
    proc {
      packed = [epoc | 0b0000000_0000_00000_11001_000000_00000].pack('V')
      Archive::DOSTime.new(packed)
    }.must_raise(ArgumentError)

    # Day must not be zero.
    proc {
      packed = [epoc & 0b1111111_1111_00000_11111_111111_11111].pack('V')
      Archive::DOSTime.new(packed)
    }.must_raise(ArgumentError)

    # Month must not be zero.
    proc {
      packed = [epoc & 0b1111111_0000_11111_11111_111111_11111].pack('V')
      Archive::DOSTime.new(packed)
    }.must_raise(ArgumentError)

    # Month must not be greater than 12.
    proc {
      packed = [epoc | 0b0000000_1101_00000_00000_000000_00000].pack('V')
      Archive::DOSTime.new(packed)
    }.must_raise(ArgumentError)

    # Year must not be greater than 119.
    proc {
      packed = [epoc | 0b1111000_0000_00000_00000_000000_00000].pack('V')
      Archive::DOSTime.new(packed)
    }.must_raise(ArgumentError)
  end
end
