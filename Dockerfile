FROM node:lts-alpine as builder
WORKDIR /app
ADD package.json ./
ADD . ./
CMD yarn install && yarn run serve