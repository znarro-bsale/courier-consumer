APP_ROOT=app/rabbit/daemons/*.rb

#Determinar el Entorno de trabajo, por defecto development
MODE=status

case "$1" in
run)
  echo "Modo no disponible para inicio total, deberas inicial el consumer especifico de la siguiente manera:"
  for entry in `ls $APP_ROOT`; do
    echo "export RABBIT_ENV=development|production; ruby $entry run";
  done  
  exit 1
  ;;
'')
  MODE="status"
  ;;  
*)
  MODE=$1
  ;;
esac

case "$2" in
production)
  ENV="production"
  ;;
*)
  ENV="development"
  ;;
esac

echo "Servicios en modo $ENV"

export RABBIT_ENV=$ENV
#Se levantan los servicios disponibles
for entry in `ls $APP_ROOT`; do
  echo "($MODE) $entry"
  ruby $entry $MODE;
done
