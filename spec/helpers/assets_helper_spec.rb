# frozen_string_literal: true

describe AssetsHelper do
  describe '#inline_js' do
    context 'path exists' do
      it 'returns HTML' do
        expect(inline_js('application.js')).to_not be_nil
      end
    end

    context 'path does not exist' do
      it 'returns HTML' do
        expect(inline_js('fake.js')).to be_nil
      end
    end
  end

  describe '#inline_css' do
    context 'path exists' do
      it 'returns HTML' do
        expect(inline_css('application.css')).to_not be_nil
      end
    end

    context 'path does not exist' do
      it 'returns HTML' do
        expect(inline_css('fake.css')).to be_nil
      end
    end
  end
end
