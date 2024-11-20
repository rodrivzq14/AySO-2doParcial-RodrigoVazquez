mkdir docker2Parcial
mkdir -p appHomeBanking
echo "<html><body><h1>Bienvenido al Home Banking</h1></body></html>" > appHomeBanking/index.html
echo "<html><body><h1>Contacto</h1></body></html>" > appHomeBanking/contacto.html
vim dockerfile
	FROM nginx:latest
	COPY /appHomeBanking /usr/share/nginx/html
docker login -u rodrivzq
pongopassword
docker build -t rodrivzq/2parcial-ayso:v1.0 .
docker image list
docker push rodrivzq/2parcial-ayso:v1.0
docker run -d -p 8080:80 rodrivzq/2parcial-ayso:v1.0
docker container ls
http://192.168.56.2:8080/index.html
http://192.168.56.2:8080/contacto.html


imagen en docker hub: rodrivzq/2parcial-ayso:v1.0
