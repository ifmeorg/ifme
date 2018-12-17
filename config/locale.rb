module Locale
  def Locale.available_locales()
    # The available locales to be used by the app.  Unit tests are dynamically
    # generated from this array.  If adding a new locale, be sure to refer to
    # any failures when running rspec spec/compare_locales_support_spec.rb
    # to see what keys and files are missing that need to be added.
    ['en', 'es', 'de', 'it', 'nb', 'nl', 'pt-BR', 'sv', 'vi', 'fr', 'ja']
  end  
end
