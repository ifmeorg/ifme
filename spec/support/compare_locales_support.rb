module CompareLocalesSupport

  LOCALE_1 = "./config/locales/en.yml"
  LOCALE_2 = "./config/locales/es.yml"

  require 'yaml'

  def self.flatten_keys(hash, prefix="")
    keys = []
    hash.keys.each do |key|
      if hash[key].is_a? Hash
        current_prefix = prefix + "#{key}."
        keys << flatten_keys(hash[key], current_prefix)
      else
        keys << "#{prefix}#{key}"
      end
    end
    prefix == "" ? keys.flatten : keys
  end

  def self.compare_locale_hashes(primary_locale, locale_to_compare)
    primary_keys = flatten_keys(primary_locale[primary_locale.keys.first])
    keys_to_compare = flatten_keys(locale_to_compare[locale_to_compare.keys.first])

    primary_keys - keys_to_compare
  end

  def self.compare(locale_1, locale_2)
    yaml_1 = YAML.load(File.open(File.expand_path(locale_1)))
    yaml_2 = YAML.load(File.open(File.expand_path(locale_2)))

    keys_1 = flatten_keys(yaml_1[yaml_1.keys.first])
    keys_2 = flatten_keys(yaml_2[yaml_2.keys.first])

    missing = keys_2 - keys_1
    # binding.pry
    file = locale_1.split('/').last
    if missing.any?
      puts "Missing from #{file}:"
      missing.each { |key| puts "  - #{key}" }
    else
      puts "Nothing missing from #{file}."
    end
  end

  # compare(LOCALE_1, LOCALE_2)
  # puts
  # compare(LOCALE_2, LOCALE_1)
end
