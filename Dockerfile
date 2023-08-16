################################################## Prepare Stage ##################################################
#FROM node:16-alpine as deps
#RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev > /dev/null 2>&1
#ARG NODE_ENV=production
#ENV NODE_ENV=${NODE_ENV}
#WORKDIR /app
#COPY ./package.json ./
#RUN npm config set network-timeout 600000 -g && npm install --production

################################################## Builder Stage ##################################################
#FROM node:16-alpine as builder
#ENV PATH /app/node_modules/.bin:$PATH
#WORKDIR /app
#COPY --from=deps /app/node_modules ./node_modules
#COPY . .
#RUN npm run build

################################################## Runner Stage ###################################################
#FROM node:16-alpine as runner
#RUN apk add --no-cache vips-dev
#ARG NODE_ENV=production
#ENV NODE_ENV=${NODE_ENV}
#WORKDIR /app
#COPY --from=builder /app/node_modules ./node_modules
#COPY --from=builder /app/package.json ./package.json
#COPY --from=builder /app/dist ./dist
#COPY --from=builder /app/.cache ./.cache
#ENV PATH /app/node_modules/.bin:$PATH

#RUN chown -R node:node /app
#USER node
#EXPOSE 9100
#CMD ["npm", "run", "start"]

FROM node:16 as build
# Installing libvips-dev for sharp Compatibility
# RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev > /dev/null 2>&1
# RUN apt-get update && apt-get install -y --no-install-recommends build-base gcc autoconf automake zlib-dev libpng-dev vips-dev > /dev/null 2>&1
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
WORKDIR /opt/
COPY ./package.json ./
ENV PATH /opt/node_modules/.bin:$PATH
RUN yarn config set network-timeout 600000 -g && yarn install --production
WORKDIR /opt/app
COPY ./ .
RUN yarn build

FROM node:16
#RUN apk add --no-cache vips-dev
#RUN apt-get install --no-install-recommends libvips
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
WORKDIR /opt/app
COPY --from=build /opt/node_modules ./node_modules
ENV PATH /opt/node_modules/.bin:$PATH
COPY --from=build /opt/app ./
EXPOSE 9100
CMD ["yarn", "start"]
