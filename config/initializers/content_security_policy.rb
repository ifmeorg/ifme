# frozen_string_literal: true

return unless Rails.env.production?

Rails.application.config.content_security_policy do |policy|
  policy.default_src :self
  policy.connect_src :self, 'wss://*.pusher.com', 'https://sockjs.pusher.com',
                     'https://stats.pusher.com'
  policy.font_src    :self, 'https://cdn.jsdelivr.net', 'https://fonts.gstatic.com'
  policy.img_src     :self, :data, 'https://res.cloudinary.com',
                     'https://maps.gstatic.com'
  policy.object_src  :none
  policy.frame_src   'https://www.google.com/recaptcha/'
  # inline_js (production asset inlining) uses a per-request nonce instead of
  # unsafe_inline; see config.content_security_policy_nonce_generator.
  policy.script_src  :self,
                     'https://js.pusher.com/3.0/pusher.min.js',
                     'https://stats.pusher.com',
                     'https://maps.googleapis.com/maps/api/js',
                     'https://maps.googleapis.com/maps-api-v3/api/js',
                     'https://maps.googleapis.com/maps/api/place/js',
                     'https://www.google.com/recaptcha/',
                     'https://www.gstatic.com/recaptcha/'
  policy.style_src   :self, :unsafe_inline, 'https://cdn.jsdelivr.net',
                     'https://fonts.googleapis.com'
end
