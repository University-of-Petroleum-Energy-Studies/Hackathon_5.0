#Build stage.
FROM node:15.8.0-stretch

WORKDIR /build

COPY package.json package-lock.json ./

RUN npm install opencv-build

RUN npm install opencv4nodejs

RUN npm ci

COPY . .

#Runtime container
FROM node:15.8.0-alpine3.10

USER node

RUN mkdir /home/node/emailer

WORKDIR /home/node/emailer

COPY --from=0 --chown=node:node /build .

CMD ["node", "server.js"]