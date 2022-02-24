docker create --name=export__ %1
docker export export__ > %2
docker rm export__
