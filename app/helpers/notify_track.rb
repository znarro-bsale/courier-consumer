# clase orientada a generar los procesos de notificacion de errores de la aplicacion
class NotifyTrack
# metodo: push
# param: from: consumidor de origen en el cual se genero el error
#        msg: detalles del error producido
# retorna: boolen, si es que pudo registrar el error
  def self.push(from, msg)
    unless $environment.to_s == 'production'
      p "From: #{from}"
      msg.split("<br/>").each do |m|
        p m
      end
      return
    end
    begin
      content = {
        :cpnId => $cpn_id.to_i,
        :trackType => "ExampleService",
        :createDate => Time.now.to_i,
        :trackData => { :msg => msg, :from => from }
      }
      url = "#{$settings['notify_track_api']}/v1/notify_track_application.json"
    	5.times do
    		response = Api.call(url, { :method => 'POST', :body => content })
    		break if response[:success]
    	end
      return true
    rescue
      return false
    end
  end
end
