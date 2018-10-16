# frozen_string_literal: true

describe AssetsHelper do
  describe '#inline_js' do
    context 'regular path exists' do
      it 'returns HTML' do
        expect(inline_js('application.js')).to_not be_nil
      end
    end

    context 'webpack bundle path does not exist' do
      it 'returns HTML' do
        expect(inline_js('webpack_bundle.css')).to be_nil
      end
    end

    context 'path does not exist' do
      it 'returns HTML' do
        expect(inline_js('fake.js')).to be_nil
      end
    end
  end

  describe '#inline_css' do
    context 'regular path exists' do
      it 'returns HTML' do
        expect(inline_css('application.css')).to_not be_nil
      end
    end

    context 'webpack bundle path exists' do
      it 'returns HTML' do
        allow(File).to receive('read').and_return('fake_path')
        expect(inline_css('webpack_bundle.css')).to_not be_nil
      end
    end

    context 'path does not exist' do
      it 'returns HTML' do
        expect(inline_css('fake.css')).to be_nil
      end
    end
  end
end
