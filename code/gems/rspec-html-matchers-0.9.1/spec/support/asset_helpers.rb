module AssetHelpers

  ASSETS = File.expand_path('../../fixtures/%s.html',__FILE__)

  def asset name
    f = fixtures[name] ||= IO.read(ASSETS%name)
    let(:rendered) { f }
  end

  private

  def fixtures
    @assets ||= {}
  end

end
