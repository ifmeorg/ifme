require "webpacker_test"

class ConfigurationTest < Minitest::Test
  def test_manifest_path
    manifest_path = File.join(File.dirname(__FILE__), "test_app/public/webpack/test", "manifest.json").to_s
    assert_equal manifest_path, WebpackerLite::Configuration.manifest_path.to_s
  end

  def test_output_path
    output_path = File.join(File.dirname(__FILE__), "test_app/public/webpack/test").to_s
    assert_equal output_path, WebpackerLite::Configuration.webpack_public_output_dir.to_s
  end
end
