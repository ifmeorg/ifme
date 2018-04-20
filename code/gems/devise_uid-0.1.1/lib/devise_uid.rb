require "devise_uid/version"
require "devise"

Devise.add_module :uid, :model => "devise_uid/model"
