require 'daemons'
require 'rubygems'
options = {
  :dir => File.expand_path('/tmp/pids', __FILE__),
  :app_name   => "#{File.basename(__FILE__)}",
  :monitor    => true,
  :multiple   => true
}
Daemons.run(File.expand_path("../../consumers/#{File.basename(__FILE__)}", __FILE__), options)