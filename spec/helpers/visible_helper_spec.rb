# frozen_string_literal: true

describe VisibleHelper do
  describe 'get_visible' do
    context 'when visible is true' do
      it 'returns text' do
        expect(get_visible(true)).to eq(t('shared.stats.visible_in_stats'))
      end
    end

    context 'when visible is false' do
      it 'returns text' do
        expect(get_visible(false)).to eq(t('shared.stats.not_visible_in_stats'))
      end
    end
  end
end
