# frozen_string_literal: true
module CompareLocalesSupport
  LOCALES_DIR = './config/locales'
  LOCALES_FILES = {
    english: "#{LOCALES_DIR}/en.yml",
    spanish: "#{LOCALES_DIR}/es.yml",
    portuguese: "#{LOCALES_DIR}/pt-BR.yml",
    swedish: "#{LOCALES_DIR}/sv.yml",
    norwegian: "#{LOCALES_DIR}/nb.yml",
    dutch: "#{LOCALES_DIR}/nl.yml",
    italian: "#{LOCALES_DIR}/it.yml",
    vietnamese: "#{LOCALES_DIR}/vi.yml",
    german: "#{LOCALES_DIR}/de.yml",
    french: "#{LOCALES_DIR}/fr.yml",
    japanese: "#{LOCALES_DIR}/ja.yml",
    devise_english: "#{LOCALES_DIR}/devise.en.yml",
    devise_spanish: "#{LOCALES_DIR}/devise.es.yml",
    devise_portuguese: "#{LOCALES_DIR}/devise.pt-BR.yml",
    devise_swedish: "#{LOCALES_DIR}/devise.sv.yml",
    devise_norwegian: "#{LOCALES_DIR}/devise.nb.yml",
    devise_dutch: "#{LOCALES_DIR}/devise.nl.yml",
    devise_italian: "#{LOCALES_DIR}/devise.it.yml",
    devise_vietnamese: "#{LOCALES_DIR}/devise.vi.yml",
    devise_german: "#{LOCALES_DIR}/devise.de.yml",
    devise_french: "#{LOCALES_DIR}/devise.fr.yml",
    devise_japanese: "#{LOCALES_DIR}/devise.ja.yml",
    devise_invitable_english: "#{LOCALES_DIR}/devise_invitable.en.yml",
    devise_invitable_spanish: "#{LOCALES_DIR}/devise_invitable.es.yml",
    devise_invitable_portuguese: "#{LOCALES_DIR}/devise_invitable.pt-BR.yml",
    devise_invitable_swedish: "#{LOCALES_DIR}/devise_invitable.sv.yml",
    devise_invitable_norwegian: "#{LOCALES_DIR}/devise_invitable.nb.yml",
    devise_invitable_dutch: "#{LOCALES_DIR}/devise_invitable.nl.yml",
    devise_invitable_italian: "#{LOCALES_DIR}/devise_invitable.it.yml",
    devise_invitable_vietnamese: "#{LOCALES_DIR}/devise_invitable.vi.yml",
    devise_invitable_german: "#{LOCALES_DIR}/devise_invitable.de.yml",
    devise_invitable_french: "#{LOCALES_DIR}/devise_invitable.fr.yml",
    devise_invitable_japanese: "#{LOCALES_DIR}/devise_invitable.ja.yml",
    kaminari_english: "#{LOCALES_DIR}/kaminari.en.yml",
    kaminari_spanish: "#{LOCALES_DIR}/kaminari.es.yml",
    kaminari_portuguese: "#{LOCALES_DIR}/kaminari.pt-BR.yml",
    kaminari_swedish: "#{LOCALES_DIR}/kaminari.sv.yml",
    kaminari_norwegian: "#{LOCALES_DIR}/kaminari.nb.yml",
    kaminari_dutch: "#{LOCALES_DIR}/kaminari.nl.yml",
    kaminari_italian: "#{LOCALES_DIR}/kaminari.it.yml",
    kaminari_vietnamese: "#{LOCALES_DIR}/kaminari.vi.yml",
    kaminari_german: "#{LOCALES_DIR}/kaminari.de.yml",
    kaminari_french: "#{LOCALES_DIR}/kaminari.fr.yml",
    kaminari_japanese: "#{LOCALES_DIR}/kaminari.ja.yml"
  }.freeze

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

  def self.compare(primary_locale_path, comparison_locale_symbol)
    primary_locale = YAML.safe_load(File.read(primary_locale_path))
    comparison_locale_path = LOCALES_FILES[comparison_locale_symbol]
    comparison_locale = YAML.safe_load(File.read(comparison_locale_path))

    compare_locale_hashes(primary_locale, comparison_locale)
  end
end
