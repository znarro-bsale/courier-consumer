class RabbitConnector
  def self.connect(rabbitmq_config)
    conn = nil
    begin
      conn = Bunny.new({
                           :host      => rabbitmq_config['host'],
                           :port      => rabbitmq_config['port'],
                           :ssl       => false,
                           :vhost     => rabbitmq_config['vhost'],
                           :user      => rabbitmq_config['user'],
                           :pass      => rabbitmq_config['password'],
                           :heartbeat => :server,
                           :frame_max => 131072,
                           :auth_mechanism => 'PLAIN'
                       })
      conn.start
    rescue Exception => e
      # ErrorTrack.push('Reports Service (RabbitConnector)', "#{e.message}<br/>#{e.backtrace}")
      # NotifyTrack.push('ChilexpressTrackingMq', "Msg: #{data}<br/>Error: #{I18n.t('access_token_error')}")
      NotifyTrack.push('Reports Service (RabbitConnector)', "Msg: #{rabbitmq_config}<br/>Error: #{e.message}")
      return nil
    end
    return conn
  end
end