require 'openssl'
if RUBY_VERSION > "2"
  require "ostruct"
else
  require "cloudinary/ostruct2"
end


module Cloudinary
  module AuthToken
    SEPARATOR = '~'

    def self.generate(options = {})
      key = options[:key]
      raise "Missing auth token key configuration" unless key
      name = options[:token_name] || "__cld_token__"
      start = options[:start_time]
      expiration = options[:expiration]
      ip = options[:ip]
      acl = options[:acl]
      duration = options[:duration]
      url = options[:url]
      start = Time.new.getgm.to_i if start == 'now'
      if expiration.nil? || expiration == 0
        if !(duration.nil? || duration == 0)
          expiration = (start || Time.new.getgm.to_i) + duration
        else
          raise 'Must provide either expiration or duration'
        end
      end

      token = []
      token << "ip=#{ip}" if ip
      token << "st=#{start}" if start
      token << "exp=#{expiration}"
      token << "acl=#{escape_to_lower(acl)}" if acl
      to_sign = token.clone
      to_sign << "url=#{escape_to_lower(url)}" if url
      auth = digest(to_sign.join(SEPARATOR), key)
      token << "hmac=#{auth}"
      "#{name}=#{token.join(SEPARATOR)}"
    end


    # Merge token2 to token1 returning a new
    # Requires to support Ruby 1.9
    def self.merge_auth_token(token1, token2)
      token1 = token1 || {}
      token2 = token2 || {}
      token1 = token1.respond_to?( :to_h) ? token1.to_h : token1
      token2 = token2.respond_to?( :to_h) ? token2.to_h : token2
      token1.merge(token2)
    end

    private

    # escape URI pattern using lowercase hex. For example "/" -> "%2f".
    def self.escape_to_lower(url)
      CGI::escape(url).gsub(/%../) { |h| h.downcase }
    end

    def self.digest(message, key)
      bin_key = Array(key).pack("H*")
      digest = OpenSSL::Digest::SHA256.new
      OpenSSL::HMAC.hexdigest(digest, bin_key, message)
    end
  end
end