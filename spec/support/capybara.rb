require 'capybara/poltergeist'
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: true, inspector: true)
end

Capybara.server do |app, port|
  require 'puma'
  Puma::Server.new(app).tap do |s|
    s.add_tcp_listener Capybara.server_host, port
  end.run.join
end

Capybara.javascript_driver = :poltergeist