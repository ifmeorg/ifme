# frozen_string_literal: true

describe ProfilePicture do
  subject { described_class }

  describe '.fetch' do
    before do
      allow(ProfilePicture).to receive(:avatar_url).and_return('some_avatar_url')
    end

    it 'returns some HTML with the class name and the avatar path' do
      expect(subject.fetch('some_avatar_url', 'some_class')).to eq(
        "<div class='some_class' style='background: url(some_avatar_url)'></div>"
      )
    end
  end

  describe '.avatar_url' do
    context 'when avatar is present' do
      context 'and is a contributor avatar' do
        let(:avatar) { '/assets/contributors/yugi-mutoh' }

        it 'returns the avatar as-is' do
          expect(subject.send(:avatar_url, avatar)).to eq(avatar)
        end
      end

      context 'and is not a contributor avatar' do
        let(:avatar) { 'http://www.if-me.org/totally-valid' }

        before do
          response_double = double('Net::HTTPResponse', code: response_code)
          allow(Net::HTTP).to receive(:get_response).and_return(response_double)
        end

        context 'and URL is valid' do
          let(:response_code) { 200 }

          it 'returns the avatar as-is' do
            expect(subject.send(:avatar_url, avatar)).to eq(avatar)
          end
        end

        context 'and URL is not valid' do
          let(:response_code) { 400 }

          it 'returns the default avatar path' do
            expect(subject.send(:avatar_url, avatar)).to eq(ProfilePicture::DEFAULT_AVATAR)
          end
        end
      end
    end

    context 'when avatar is not present' do
      let(:avatar) { nil }

      it 'returns the default avatar path' do
        expect(subject.send(:avatar_url, avatar)).to eq(ProfilePicture::DEFAULT_AVATAR)
      end
    end
  end
end
