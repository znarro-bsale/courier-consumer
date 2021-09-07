#########################################################
# Modelo Chilexpress
#########################################################
class Chilexpress

  attr_accessor :origin_county_code,
                :destination_county_code,
                :package,
                :product_type,
                :content_type,
                :declared_worth,
                :delivery_time,
                :response

  def initialize
    @origin_county_code      = nil
    @destination_county_code = nil
    @package                 = nil
    @product_type            = nil
    @content_type            = nil
    @declared_worth          = nil
    @delivery_time           = nil
    @response                = nil
  end

  #########################################################
  # Método que genera el formato del json entrada para este modelo
  #########################################################
  def serialize()
    {
      originCountyCode: @origin_county_code,
      destinationCountyCode: @destination_county_code,
      package: @package,
      productType: @product_type,
      contentType: @content_type,
      declaredWorth: @declared_worth,
      deliveryTime: @delivery_time
    }
  end


  #########################################################
  # Metodo que obtiene lista de archivos
  # @params: token (string), token de acceso
  # @params: mk_id (number), Market ID
  # @return: Array de archivos
  #########################################################
  def self.get_shipping(origin_zone, destination_zone)
    base_url = "https://testservices.wschilexpress.com/rating/api/v1.0/rates/courier"
    # base_url = "#{$settings['bsale_market_api']}/v1/admin/file/#{mk_id}.json"
    response = {}
    3.times do
      response = Api.call(url, { method: 'POST', headers: { 'access_token': token.to_s }, body: serialize})
      break if response[:success]
      sleep 0.5
    end
    return {
      data: response[:data],
      request: {url: url, method: 'POST', body: serialize},
      response: response
    }
  end


  #########################################################
  # Metodo para crear un archivo
  # @params: token (string), token de acceso
  # @params: mk_id (number), Market ID
  # @return: archivo creado
  #########################################################
  def post(token, mk_id)
    # url = "#{$settings['bsale_market_api']}/v1/admin/file/#{mk_id}.json"
    # response = {}
    # 3.times do
    #   response = Api.call(url, { method: 'POST', headers: { 'access_token': token.to_s }, body: serialize})
    #   break if response[:success]
    #   sleep 0.5
    # end
    # return {
    #   data: response[:data],
    #   request: {url: url, method: 'POST', body: serialize},
    #   response: response
    # }
  end


  #########################################################
  # Metodo que elimina un archivo
  # @params: token (string), token de acceso
  # @params: mk_id (number), Market ID
  # @params: fl_id (number), id del archivo que se desea eliminar
  # @return: hash
  #########################################################
  def self.delete(token, mk_id, fl_id)
    # url = "#{$settings['bsale_market_api']}/v1/admin/file/#{mk_id}/#{fl_id}.json"
    # response = Api.call(url, { method: 'DELETE', headers: { access_token: token } })
    # return {
    #   data: response[:data],
    #   request: {url: url, method: 'DELETE'},
    #   response: response
    # }
  end

end