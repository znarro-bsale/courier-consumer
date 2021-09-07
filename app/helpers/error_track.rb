class ErrorTrack
  def self.push(from, msg)
    begin
      content = {
      	:cpnId => $cpn_id.to_i,
      	:trackType => "RabbitService",
      	:createDate => Time.now.to_i,
      	:trackData => { :msg => msg, :from => from }
      }
      url = "#{$settings['notify_track_url']}/v1/notify_track_application.json"
    	5.times do
    		api_response = Api.call(url, { :method => 'POST', :body => content })
    		break if api_response[:success]
    	end
      return true
    rescue
      return false
    end
  end
end
