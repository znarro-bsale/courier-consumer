def authenticate!(access_token)
  response = Api.call("#{$settings['bway_api']}/instances/token/#{access_token}.json")
  return false unless response[:success]
  
  $cpn_id = response[:cpn][:id]
  $usr_token = response[:usr][:userToken]
 
  return true
end

