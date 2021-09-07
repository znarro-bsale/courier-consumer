Carpeta orientada agrupar todos las clases que se conectarán a las distintas colas de RabbitMQ

Cada Servicio rabbit tendra 2 partes:

**Consumer:** Orientado a conectarse al a cola rabbit y obtener el mensaje para pasarlo al "runner".

Todo consumer se compone del siguiente codigo:

```
require File.expand_path('../../../../config/rabbit_environment.rb', __FILE__)
$mq_connection = RabbitConnector.connect($settings['example_mq'])

class ExampleMq
  def self.process
    begin
      $mq_connection = RabbitConnector.connect($settings['example_mq']) if $mq_connection.nil?
      unless $mq_connection.nil?
        ch = $mq_connection.create_channel
        ch.prefetch(1)
        q = ch.queue('example_queue', :durable => true)
        q.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
          begin
            data = JSON.parse(body, :symbolize_names => true) rescue nil
            #Si el payload se pudo parsear, y se logra autentificar
            if authenticate!(data[:access_token].to_s)
              begin
              #se deja un tiempo maximo de ejecucion de 10 mins
                Timeout.timeout(600) do
                  begin
                    #tarea a ejecutar....                    
                  rescue Exception => ex
                    # ErrorTrack.push('ExampleMq', "Msg: #{body}<br/>Error: #{ex.message}<br/>Backtrace: #{ex.backtrace}")
                    # NotifyTrack.push('ChilexpressTrackingMq', "Msg: #{data}<br/>Error: #{I18n.t('access_token_error')}")
                    NotifyTrack.push('ChilexpressTrackingMq', "Msg: #{data}<br/>Error: #{ex.backtrace}")
                  end
                end
              rescue Timeout::Error
              end              
            end unless data.nil?
            ch.ack(delivery_info.delivery_tag)
          rescue Exception => e
            # ErrorTrack.push('ExampleMQ', "Msg: #{body}<br/>Error: #{e.message}<br/>Backtrace: #{e.backtrace}")
            # NotifyTrack.push('ChilexpressTrackingMq', "Msg: #{data}<br/>Error: #{I18n.t('access_token_error')}")
            NotifyTrack.push('ChilexpressTrackingMq', "Msg: #{data}<br/>Error: #{ex.backtrace}")
          ensure
            GC.start
          end
        end
      end
    rescue Interrupt => _
      $mq_connection.close
      $mq_connection = nil
      GC.start
    end 
  end
end

ExampleMq.process
```

**Deamon:** Clase que **debera tener el mismo nombre que el consumer**, orientada a dejarlo como demonio del S.O.

Todo demonio se compone del siguiente codigo:

```
require 'daemons'
require 'rubygems'
options = {
           :dir => File.expand_path('/tmp/pids', __FILE__),
           :app_name   => "#{File.basename(__FILE__)}",
           :monitor    => true,
           :multiple   => true
}
Daemons.run(File.expand_path("../../consumers/#{File.basename(__FILE__)}", __FILE__), options)
```
