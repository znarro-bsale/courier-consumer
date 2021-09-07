# clase orientada a la obtención del access Token
class Bway

  # metodo: GET
  # params: cpn_id: identificador de la empresa
  #         user_token: identificador del usuario
  # return: string, credecial del usuario, en caso de no poder obtenerla entrega un nil
  def self.get(cpn_id, user_token)
    url ="#{$settings['bway_api']}/v1/users/find_by_token.json?cpn_id=#{cpn_id}&user_token=#{user_token}"
    response = Api.call(url, { method: 'GET', headers: { app_token: $settings['app_token'] }})
    return nil unless response[:success]
    return response[:accessToken] rescue nil
  end
end