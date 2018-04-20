require 'pry'
require 'nokogiri'
require 'yaml'
require 'date'

class OSVDB
  attr_accessor :osvdb, :cve, :title, :description, :date, :cvss_v2, :gem, :url, :patched_versions, :page
  def initialize(osvdb)
    self.osvdb = osvdb
    self.url = "http://osvdb.org/show/osvdb/#{self.osvdb}"
    scrape!
    parse!
  end

  def scrape!
    html = `bash --login -c "python cf_scrape.py #{self.url}"`
    doc = Nokogiri::XML(html) do |config|
      config.nonet.noent
    end

    self.page = doc
  end

  def parse!
    page.search(".show_vuln_table").search("td ul li").each do |li|
      case li.children[0].text.strip
      when "CVE ID:"
        self.cve = li.children[1].text
      when "Vendor URL:"
        self.set_gem(li.children[1].text)
      end
    end

    self.description = page.search(".show_vuln_table").search("tr td tr .white_content p")[0].text
    self.date = page.search(".show_vuln_table").search("tr td tr .white_content tr td")[0].text
    self.title = page.search("title").text.gsub(/\d+: /, "")
    if cvss_p = page.search(".show_vuln_table").search("tr td tr .white_content div p")[0]
      self.set_cvss(cvss_p.children[0].text)
    end
  end

  def set_gem(vendortext)
    ["https://rubygems.org/gems/", "http://rubygems.org/gems/"].each do |str|
      if vendortext.match(str)
        self.gem = vendortext.gsub(str,"")
      end
    end
  end

  def set_cvss(text)
    self.cvss_v2 = text.strip.gsub("CVSSv2 Base Score = ", "")
  end

  def date
    Date.parse(@date)
  end

  def cvss_v2
    @cvss_v2.nil? ? nil : @cvss_v2.to_f
  end

  def gem
    @gem.nil? ? "unknown" : @gem
  end

  def to_yaml
    { 'gem' => gem,
      'cve' => cve,
      'osvdb' => osvdb.to_i,
      'url' => url,
      'title' => title,
      'date' => date,
      'description' => description,
      'cvss_v2' => cvss_v2,
      'patched_versions' => patched_versions
    }.to_yaml(options = { line_width: 80 })
  end

  def filename
    "OSVDB-#{osvdb}.yml"
  end

  def to_advisory!
    gems_path = File.join(File.dirname(__FILE__), "..", "gems")
    adv_path = File.absolute_path(File.join(gems_path, self.gem))

    FileUtils.mkdir(adv_path) unless File.exists?(adv_path)
    File.open(File.join(adv_path, filename), "w") do |io|
      io.puts self.to_yaml
    end
  end
end
