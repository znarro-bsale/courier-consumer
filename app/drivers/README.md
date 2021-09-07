Carpeta orientada a agrupar todas aquellas clases que contentan logica mas compleja, como pudiese ser un proceso transaccional, reporte, etc<br/>

**Convencion de nombre** 

**Transacciones**: `transaction.concepto.rb`, ejemplo: `transaction.giftcard.rb`<br/>
**Reportes**: `report.concepto.rb`, ejemplo: `report.giftcard.rb`<br/>

Las clase estara dentro del modulo asociado al proceso, siguiendo el ejemplo anterior, donde el archivo se llama `transaction.giftcard.rb` seria:

```ruby
module Transaction
  module Giftcard
    def self.nombre_del_metodo(parametro)
    end
  end
end
```

Para luego ser usada como: `Transaction::Giftcard.nombre_del_metodo(1)`