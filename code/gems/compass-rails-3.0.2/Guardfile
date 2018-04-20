# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :test, :cli => '-v v' do
  watch(%r{^lib/(.+)\.rb$})     { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch('test/test_helper.rb')  { "test" }

end
