# frozen_string_literal: true
require './config/locale'

module CompareLocalesSupport
  LOCALES_DIR = './config/locales'
  ENGLISH_FILES = Dir.glob("#{LOCALES_DIR}/**/*en.yml")
  NON_ENGLISH_LOCALES = Locale.available_locales
  NON_ENGLISH_LOCALES.delete('en')

  def self.flatten_keys(hash, prefix = '')
    hash.keys.each_with_object([]) do |key, keys|
      if hash[key].respond_to?(:keys)
        keys.concat(flatten_keys(hash[key], "#{prefix}#{key}."))
      else
        keys << "#{prefix}#{key}"
      end
    end
  end

  def self.compare_locale_hashes(primary_locale, comparison_locale)
    primary_keys = flatten_keys(primary_locale[primary_locale.keys.first])
    keys_to_compare = flatten_keys(comparison_locale[comparison_locale.keys.first])

    primary_keys - keys_to_compare
  end

  def self.compare(primary_locale_path, comparison_locale_path)
    primary_locale = YAML.safe_load(File.read(primary_locale_path))
    comparison_locale = YAML.safe_load(File.read(comparison_locale_path))

    compare_locale_hashes(primary_locale, comparison_locale)
  end
end
