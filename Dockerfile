FROM node

MAINTAINER dilmnqvovpnmlib <simplelpmis6@gmail.com>

ENV TZ Asia/Tokyo

# update 
RUN apt-get update -qq
RUN apt-get install -y nginx && apt-get install -y vim && apt-get install -y less && apt-get install -y supervisor 

RUN mkdir /app
WORKDIR /app
ADD ./test .
ADD ./docker-entrypoint.sh .

# install npm packages.
RUN npm install
RUN npm run build

# copy configuration files.
COPY ./conf/supervisord.conf /etc/supervisor/conf.d/superfisord.conf
COPY ./conf/default /etc/nginx/sites-enabled/default

EXPOSE 80

CMD ["bash", "./docker-entrypoint.sh"]

