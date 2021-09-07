**Estructura Base para Proyectos Rabbit**
=========================================

**Instalacion** 
```
rvm install 2.3.3
gem install bundle
bundle install
```


**Modo Development** 

Iniciar: `sh rabbit_service.sh start development`

Detener: `sh rabbit_service.sh stop development`

Actualizar: `sh rabbit_service.sh restart development`

Estado: `sh rabbit_service.sh status`


**Modo Produccion** 

Iniciar: `sh rabbit_service.sh start production`

Detener: `sh rabbit_service.sh stop production`

Actualizar: `sh rabbit_service.sh restart production`

Estado: `sh rabbit_service.sh status`
