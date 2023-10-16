
#build stage
FROM node:18.16.0-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

#production stage
FROM node:18.16.0-alpine

ENV NODE_ENV=${production}

WORKDIR /usr/src/app

COPY /usr/src/app/dist ./dist

COPY package*.json ./

RUN npm install --only=production

RUN rm package*.json

EXPOSE 3000

CMD ["node" , "dist/main.js"]