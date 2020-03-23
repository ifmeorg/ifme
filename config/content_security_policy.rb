# frozen_string_literal: true

Rails.application.config.content_security_policy do |policy|
  policy.default_src :none
  policy.connect_src :self
  policy.style_src :unsafe_inline, :self
  policy.font_src :self, 'https://cdn.jsdelivr.net'
  policy.img_src 'https://maps.gstatic.com', 'https://res.cloudinary.com'
  policy.script_src 'self', 'https://js.pusher.com/3.0.0/xhr.min.js',
                    'https://js.pusher.com/3.0/pusher.min.js',
                    'https://maps.googleapis.com/maps/api/js',
                    'https://maps.googleapis.com/maps-api-v3/api/js',
                    'https://maps.googleapis.com/maps/api/place/js'
end
