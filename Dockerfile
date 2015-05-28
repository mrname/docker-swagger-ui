FROM node:0.10

RUN npm update npm 
RUN npm install http-server


RUN mkdir -p /tmp/swagger
ADD https://github.com/swagger-api/swagger-ui/archive/v2.1.0-M2.tar.gz /tmp/swagger/swaggerui.tar.gz
RUN tar --strip-components 1 -C /tmp/swagger -xzf /tmp/swagger/swaggerui.tar.gz 

RUN mkdir -p /swaggerui/dist
RUN mv /tmp/swagger/dist/* /swaggerui/dist
RUN rm -rf /tmp/swagger

RUN echo "'use strict';\
var path = require('path');\
var createServer = require('http-server').createServer;\
var dist = path.join('swaggerui', 'dist');\
var swaggerUI = createServer({ root: dist, cors: true });\
swaggerUI.listen(8888);" > /swaggerui/index.js

EXPOSE 8888
CMD ["node", "/swaggerui/index.js"]