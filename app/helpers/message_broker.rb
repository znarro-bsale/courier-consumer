# clase orientada para la publicacion de mensaje delegados
class MessageBroker

  # metodo: post
  # params: vhost: el host de mensajes del rabbit
  #         queue: cola en la que queda el mensaje
  #         data: mensaje a publicar
  # return: boolean, indica el estado de la publicacion
   def self.post(vhost, queue, data)
     posted = false
     url = "#{$settings['message_broker']}/v1/enqueue/#{vhost}/#{queue}.json"
     begin
       5.times do
         response = Api.call(url, { :method => "POST", :body => data, :timeout => 10 })
         posted = response[:success]
         NotifyTrack.push("message_broker", "Msg: #{response}<br/>Queue: #{vhost}-#{queue}<br/>Data: #{data}") unless posted
         break if posted
       end
     rescue
       posted = false
     end
     return posted
   end

   # metodo: post
   # params: vhost: el host de mensajes del rabbit
   #         queue: cola en la que queda el mensaje
   #         data: mensaje a publicar
   #         delay: tiempo en el cual quedara disponible el mensaje que se envia
   # return: boolean, indica el estado de la publicacion
   def self.post_delayed(vhost, queue, data, delay = 0)
     posted = false
     url = "#{$settings['message_broker']}/v1/enqueue/delayed/#{vhost}/#{queue}/#{delay}.json"
     begin
       5.times do
         response = Api.call(url, { :method => "POST", :body => data, :headers => { :access_token => $access_token }, :timeout => 10 })
         posted = response[:success]
         NotifyTrack.push("message_broker", "Msg: #{response}<br/>Queue: #{vhost}-#{queue}<br/>Data: #{data}") unless posted
         break if posted
       end
     rescue
       posted = false
     end
     return posted
   end
end
