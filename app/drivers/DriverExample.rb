# DriverExample
# Ejemplo de clase driver
class DriverExample

  # Obtiene los recursos modelExample
  # return: modelExample[]|false
  def self.modelExample(data)
    access_token = Bway.get(data[:cpnId],data[:userToken])
    
    if access_token == nil
      # Notifique al canal corrrespondiente un mensaje internacionalizado con I18nt
      # usando el ejemplo siguiente reemplazando `channel` y `access_token_error` por lo que corresponda
      NotifyTrack.push('channel', "Msg: #{data}<br/>Error: #{I18n.t('access_token_error')}")
      return false
    end

    model_example = ModelExample.get(data[:resourceId], access_token)

    if model_example == nil
      # Notifique al canal corrrespondiente un mensaje internacionalizado con I18nt
      # usando el ejemplo siguiente reemplazando `channel` y `model_example_nil` por lo que corresponda
      NotifyTrack.push('channel', "Data: #{data}<br/>Error: #{I18n.t('model_example_nil')}")
      return false
    end

    return model_example
  end  
end