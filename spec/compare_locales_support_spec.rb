# frozen_string_literal: true
describe CompareLocalesSupport do
  described_class::ENGLISH_FILES.each do |f|

    context "when comparing #{f}" do

      described_class::NON_ENGLISH_LOCALES.each do |locale|

        locale_file = f.sub(/en\.yml$/, "#{locale}.yml")

        context "with #{locale_file}" do

          it 'should exist' do
            expect(File.exist?(locale_file)).to be true
          end

          it 'should have matching keys' do
            expect(described_class.compare(f, locale_file)).to be_empty
          end

        end
      end
    end
  end
end
