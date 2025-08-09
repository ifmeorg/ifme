# Configuración de Better Errors para desarrollo
if Rails.env.development?
  # Configurar Better Errors
  BetterErrors.application_root = Rails.root
  
  # Permitir acceso desde localhost y direcciones IP locales
  BetterErrors::Middleware.allow_ip! "127.0.0.1"
  BetterErrors::Middleware.allow_ip! "::1"
  BetterErrors::Middleware.allow_ip! "10.0.0.0/8"
  BetterErrors::Middleware.allow_ip! "172.16.0.0/12"
  BetterErrors::Middleware.allow_ip! "192.168.0.0/16"
  
  # Si estás usando Docker o WSL, también permite estas IPs
  BetterErrors::Middleware.allow_ip! "0.0.0.0/0" if ENV['DOCKER'] || ENV['WSL_DISTRO_NAME']
  
  # Configurar el editor (opcional - ajusta según tu editor preferido)
  BetterErrors.editor = :vscode
  BetterErrors.editor = "code://file/%{file}:%{line}"
end