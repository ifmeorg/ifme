# frozen_string_literal: true

module CompareLocalesSupport
  LOCALE_1 = './config/locales/en.yml'
  LOCALE_2 = './config/locales/es.yml'

  def self.flatten_keys(hash, prefix = '')
    hash.keys.each_with_object([]) do |key, keys|
      if hash[key].respond_to?(:keys)
        keys.concat(flatten_keys(hash[key], "#{prefix}#{key}."))
      else
        keys << "#{prefix}#{key}"
      end
    end
  end

  def self.compare_locale_hashes(primary_locale, locale_to_compare)
    primary_keys = flatten_keys(primary_locale[primary_locale.keys.first])
    keys_to_compare = flatten_keys(locale_to_compare[locale_to_compare.keys.first])

    primary_keys - keys_to_compare
  end

  def self.compare(primary_locale_file_name, locale_file_name_to_compare)
    primary_locale = YAML.safe_load(File.open(File.expand_path(primary_locale_file_name)))
    locale_to_compare = YAML.safe_load(File.open(File.expand_path(locale_file_name_to_compare)))

    compare_locale_hashes(primary_locale, locale_to_compare)
  end

  # compare(LOCALE_1, LOCALE_2)
  # puts
  # compare(LOCALE_2, LOCALE_1)
end
