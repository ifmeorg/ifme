require "webpacker_test"

class HelperTest < ActionView::TestCase
  def setup
    @view = ActionView::Base.new
    @view.extend WebpackerLite::Helper
  end

  def test_pack_path
    assert_equal @view.pack_path("bootstrap.js"), "/webpack/test/bootstrap-300631c4f0e0f9c865bc.js"
    assert_equal @view.pack_path("bootstrap.css"), "/webpack/test/bootstrap-c38deda30895059837cf.css"
  end

  def test_asset_pack_path
    assert_equal @view.asset_pack_path("bootstrap.js"), "/webpack/test/bootstrap-300631c4f0e0f9c865bc.js"
    assert_equal @view.asset_pack_path("bootstrap.css"), "/webpack/test/bootstrap-c38deda30895059837cf.css"
  end

  def test_javascript_pack_tag
    script = %(<script src="/webpack/test/bootstrap-300631c4f0e0f9c865bc.js"></script>)
    assert_equal @view.javascript_pack_tag("bootstrap.js"), script
  end

  def test_stylesheet_pack_tag
    expected_style = %(<link rel="stylesheet" media="screen" href="/webpack/test/bootstrap-c38deda30895059837cf.css" />)
    assert_equal @view.stylesheet_pack_tag("bootstrap.css"), expected_style
  end
end
