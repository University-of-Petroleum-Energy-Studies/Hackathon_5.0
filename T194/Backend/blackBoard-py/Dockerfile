#Build stage.
FROM justadudewhohacks/opencv-nodejs

WORKDIR /build

COPY package.json package-lock.json ./

RUN npm install -g nodemon && npm install

COPY . .

#Runtime container
FROM justadudewhohacks/opencv-nodejs

WORKDIR /nodeCv

COPY --from=0  /build .

CMD ["node", "server.js"]