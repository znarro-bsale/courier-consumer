def to_utf8(text)
  return text.to_s.force_encoding('utf-8')
end

def string_to_array(cadena)
  respuesta = cadena.strip.gsub('[', '').gsub(']', '').split(',')
  return respuesta
end
