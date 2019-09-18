App::Config = HashWithIndifferentAccess.new(Rails.application.config_for(:'app-config'))

def build_url()
  if ![443, 80].include?(App::Config[:port].to_i)
    custom_port = ":#{App::Config[:port]}"
  else
    custom_port = nil
  end
  app_path =
  [ App::Config[:protocol],
    "://",
    App::Config[:host],
    custom_port
  ].join('')
end

App::Config[:api_version] ||= 'v1'
App::Config[:host] ||= 'localhost'
App::Config[:url] = build_url