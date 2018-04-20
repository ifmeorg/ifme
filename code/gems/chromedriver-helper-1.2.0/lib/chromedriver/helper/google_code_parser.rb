require 'nokogiri'
require 'open-uri'

module Chromedriver
  class Helper
    class GoogleCodeParser
      BUCKET_URL = 'https://chromedriver.storage.googleapis.com'

      attr_reader :source, :platform

      def initialize(platform, open_uri_provider=OpenURI)
        @platform = platform
        @source = open_uri_provider.open_uri(BUCKET_URL)
      end

      def downloads
        @downloads ||= begin
          doc = Nokogiri::XML.parse(source)
          items = doc.css("Contents Key").collect {|k| k.text }
          items.reject! {|k| !(/chromedriver_#{platform}/===k) }
          items.map {|k| "#{BUCKET_URL}/#{k}"}
        end
      end

      def newest_download_version
        @newest_download_version ||= downloads.map { |download| version_of(download) }.max
      end

      def version_download_url(version)
        gem_version = Gem::Version.new(version)
        downloads.find { |download_url| version_of(download_url) == gem_version }
      end

      private

      def version_of url
        Gem::Version.new grab_version_string_from(url)
      end

      def grab_version_string_from url
        # assumes url is of form similar to http://chromedriver.storage.googleapis.com/2.3/chromedriver_mac32.zip
        url.split("/")[3]
      end
    end
  end
end
