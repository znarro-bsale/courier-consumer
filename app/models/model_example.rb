# clase orientada a la construcción del formato de chilexpress para generar un envio
class ModelExample
  # propiedades de ejemplo. Reemplace con las correspondientes segun entidad a obtener
  attr_accessor :id,
                :a_property,
                :other_property,
                :response

  def initialize
    @id             = nil
    @a_property     = nil
    @other_property = nil
    @headers        = nil
    @response       = nil
  end

  # metodo: genera el formato del json entrada para este modelo
  def serialize()
    {
      data:[{
        property: @a_property,
        other_property: @other_property
    }],
    header: @headers
  }
  end


  # método: get
  # objetivo: Obtiene de llamada api recurso solicitado
  # return Arreglo con lista del recurso solicitado. En caso de no encontrar devuelve arreglo vacio
  def get(token)
    resource_list = []
    data_remaining = true
    limit  = 25
    offset = 0

    while data_remaining do
      response = nil
      url = "#{$settings['api_identifier']}/v1/resource.json" 
      
      response = Api.call(url, { method: 'GET', headers: { access_token: token } })
      response[:items].each do |element|
        resource = Resource.new
        resource.id = element[:resource][:id].to_i
        resource.a_property = element[:resource][:a_property].to_s
        resource.other_property = element[:resource][:other_property].to_s
        resource_list.push(resource)
      end
      data_remaining = false if response[:next].nil?
      offset += limit
    end
    return resource_list
  end


  # metodo: post
  # objetivo: Crear un recurso
  # return: json, en caso de falla o no encontrar el codigo de cobertura buscado retorna nil
  def post(token)
    url = "#{$settings['api_identifier']}/api/v1/resource"
    response = Api.call(url, { method: 'POST', headers: { 'Ocp-Apim-Subscription-Key': token.to_s }, body: serialize})
    @response = nil unless response[:success]
    @response = response[:data] rescue nil
  end

end
