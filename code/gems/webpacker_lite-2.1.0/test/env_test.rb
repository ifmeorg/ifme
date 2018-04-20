require "webpacker_test"

class EnvTest < Minitest::Test
  def test_current_env
    assert_equal Rails.env, WebpackerLite::Env.current
  end

  def test_file_path
    correct_path = File.join(File.dirname(__FILE__), "test_app", "config", "webpacker_lite.yml").to_s
    assert_equal correct_path, WebpackerLite::Env.file_path.to_s
  end
end
