#Deja los archivos ubicados en 'app' en el PATH
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'bunny'
require 'yaml'

#se activa el GC
GC.enable
GC.start
# Se define el enviroment antes que se carguen los modelos
$environment = ENV['RABBIT_ENV'] || 'development'
$db = YAML.load_file(File.expand_path('../database.yml', __FILE__))[$environment]
$settings = YAML.load_file(File.expand_path('../settings.yml', __FILE__))[$environment]

require File.expand_path('../../app/rabbit/rabbit_connector.rb', __FILE__)
