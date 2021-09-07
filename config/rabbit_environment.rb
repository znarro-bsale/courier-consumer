#Deja los archivos ubicados en 'app' en el PATH
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'bunny'
require 'yaml'
require 'oj'
require 'oj_mimic_json'
require 'i18n'
require 'i18n/backend/fallbacks'
require 'active_support/all'

I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.load_path = Dir[File.expand_path('../locales/*.yml', __FILE__)]
I18n.backend.load_translations
I18n.enforce_available_locales = true

#se activa el GC
GC.enable
GC.start
# Se define el enviroment antes que se carguen los modelos
$environment = ENV['RABBIT_ENV'] || 'development'
$settings = YAML.load_file(File.expand_path('../settings.yml', __FILE__))[$environment]

Dir[File.expand_path('../../app/helpers/*.rb', __FILE__)].each do |f|
  require f
end

Dir[File.expand_path('../../app/helpers/libs/*.rb', __FILE__)].each do |f|
  require f
end

#carga la API, Modelos, Serializadores y Drivers
Dir[File.expand_path('../../app/models/*.rb', __FILE__)].each do |f|
  require f
end

Dir[File.expand_path('../../app/drivers/*.rb', __FILE__)].each do |f|
  require f
end

require File.expand_path('../../app/rabbit/rabbit_connector.rb', __FILE__)