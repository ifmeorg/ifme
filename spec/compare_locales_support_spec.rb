# frozen_string_literal: true
describe CompareLocalesSupport do
  describe 'check non english locales include all keys' do
    context 'when the source is english' do
      let(:source) { described_class::LOCALES_FILES[:english] }

      context 'when comparing to spanish' do
        subject { described_class.compare(source, :spanish) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to portuguese' do
        subject { described_class.compare(source, :portuguese) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to swedish' do
        subject { described_class.compare(source, :swedish) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to dutch' do
        subject { described_class.compare(source, :dutch) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to italian' do
        subject { described_class.compare(source, :italian) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to norwegian' do
        subject { described_class.compare(source, :norwegian) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to vietnamese' do
        subject { described_class.compare(source, :vietnamese) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to german' do
        subject { described_class.compare(source, :german) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to french' do
        subject { described_class.compare(source, :french) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to japanese' do
        subject { described_class.compare(source, :japanese) }
        it { is_expected.to be_empty }
      end
    end
  end

  describe 'check non english devise locales include all keys' do
    context 'when the source is devise_english' do
      let(:source) { described_class::LOCALES_FILES[:devise_english] }

      context 'when comparing to devise_spanish' do
        subject { described_class.compare(source, :devise_spanish) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_portuguese' do
        subject { described_class.compare(source, :devise_portuguese) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_swedish' do
        subject { described_class.compare(source, :devise_swedish) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_dutch' do
        subject { described_class.compare(source, :devise_dutch) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_italian' do
        subject { described_class.compare(source, :devise_italian) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_norwegian' do
        subject { described_class.compare(source, :devise_norwegian) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_vietnamese' do
        subject { described_class.compare(source, :devise_vietnamese) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_german' do
        subject { described_class.compare(source, :devise_german) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_french' do
        subject { described_class.compare(source, :devise_french) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_japanese' do
        subject { described_class.compare(source, :devise_japanese) }
        it { is_expected.to be_empty }
      end
    end
  end

  describe 'check non english devise_invitable locales include all keys' do
    context 'when the source is devise_invitable_english' do
      let(:source) { described_class::LOCALES_FILES[:devise_invitable_english] }

      context 'when comparing to devise_invitable_spanish' do
        subject { described_class.compare(source, :devise_invitable_spanish) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_invitable_portuguese' do
        subject { described_class.compare(source, :devise_invitable_portuguese) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_invitable_swedish' do
        subject { described_class.compare(source, :devise_invitable_swedish) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_invitable_dutch' do
        subject { described_class.compare(source, :devise_invitable_dutch) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_invitable_italian' do
        subject { described_class.compare(source, :devise_invitable_italian) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_invitable_norwegian' do
        subject { described_class.compare(source, :devise_invitable_norwegian) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_invitable_vietnamese' do
        subject { described_class.compare(source, :devise_invitable_vietnamese) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_invitable_german' do
        subject { described_class.compare(source, :devise_invitable_german) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_invitable_french' do
        subject { described_class.compare(source, :devise_invitable_french) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to devise_invitable_japanese' do
        subject { described_class.compare(source, :devise_invitable_japanese) }
        it { is_expected.to be_empty }
      end
    end
  end

  describe 'check non english kaminari_english locales include all keys' do
    context 'when the source is kaminari_spanish' do
      let(:source) { described_class::LOCALES_FILES[:kaminari_english] }

      context 'when comparing to kaminari_portuguese' do
        subject { described_class.compare(source, :kaminari_spanish) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to kaminari_portuguese' do
        subject { described_class.compare(source, :kaminari_portuguese) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to kaminari_swedish' do
        subject { described_class.compare(source, :kaminari_swedish) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to kaminari_dutch' do
        subject { described_class.compare(source, :kaminari_dutch) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to kaminari_italian' do
        subject { described_class.compare(source, :kaminari_italian) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to kaminari_norwegian' do
        subject { described_class.compare(source, :kaminari_norwegian) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to kaminari_vietnamese' do
        subject { described_class.compare(source, :kaminari_vietnamese) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to kaminari_german' do
        subject { described_class.compare(source, :kaminari_german) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to kaminari_french' do
        subject { described_class.compare(source, :kaminari_french) }
        it { is_expected.to be_empty }
      end

      context 'when comparing to kaminari_japanese' do
        subject { described_class.compare(source, :kaminari_japanese) }
        it { is_expected.to be_empty }
      end
    end
  end

  describe 'check all locale files for missing tests' do
    subject { Dir.glob("#{described_class::LOCALES_DIR}/*.yml") }
    it { is_expected.to match_array(described_class::LOCALES_FILES.values) }
  end
end
