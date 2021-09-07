require File.expand_path('../../../../config/rabbit_environment.rb', __FILE__)
$mq_connection = RabbitConnector.connect($settings['example_mq'])

class CloneMarketMq
  def self.process
    begin
      $mq_connection = RabbitConnector.connect($settings['example_mq']) if $mq_connection.nil?
      unless $mq_connection.nil?
        ch = $mq_connection.create_channel
        ch.prefetch(1)
        q = ch.queue('courier_shipping', :durable => true)
        q.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
          begin
            data = JSON.parse(body, :symbolize_names => true) rescue nil
            p data
            #Si el payload se pudo parsear, y se logra autentificar

            begin
              #tarea a ejecutar....
              # if data.nil?
              #   NotifyTrack.push('CloneMarketMq.process', "Data: #{data}<br/>Error: #{I18n.t('notify_error.process_nil')}")
              #   return false
              # end

              # if data[:originAccessToken].nil? || data[:destinationAccessToken].nil?
              #   NotifyTrack.push('CloneMarketMq.process', "Msg: #{data}<br/>Error: #{I18n.t('notify_error.access_token_error')}")
              #   return false
              # end

              if data
                chilexpress = Transaction::Chilexpress.process(data)
                # clone_success?('menus', menus_cloned[:success])
              end

              puts "Chilexpress has finished"
            rescue Exception => ex
              # ErrorTrack.push('CloneMarketMq', "Msg: #{body}<br/>Error: #{ex.message}<br/>Backtrace: #{ex.backtrace}")
              # NotifyTrack.push('ChilexpressTrackingMq', "Msg: #{data}<br/>Error: #{I18n.t('access_token_error')}")
              NotifyTrack.push('CloneMarketMq', "Msg: #{data}<br/>Error: #{ex.backtrace}")
            end

            ch.ack(delivery_info.delivery_tag)
          rescue Exception => e
            # ErrorTrack.push('CloneMarketMq', "Msg: #{body}<br/>Error: #{e.message}<br/>Backtrace: #{e.backtrace}")
            # NotifyTrack.push('ChilexpressTrackingMq', "Msg: #{data}<br/>Error: #{I18n.t('access_token_error')}")
            NotifyTrack.push('CloneMarketMq', "Msg: #{data}<br/>Error: #{e.backtrace}")
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

CloneMarketMq.process