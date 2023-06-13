################################################## Prepare Stage ##################################################
FROM node:16-alpine as deps
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev > /dev/null 2>&1
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
WORKDIR /app
COPY ./package.json ./
RUN npm config set network-timeout 600000 -g && npm install --production

################################################## Builder Stage ##################################################
FROM node:16-alpine as builder
ENV PATH /app/node_modules/.bin:$PATH
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

################################################## Runner Stage ###################################################
FROM node:16-alpine as runner
RUN apk add --no-cache vips-dev
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/.cache ./.cache
ENV PATH /app/node_modules/.bin:$PATH

RUN chown -R node:node /app
USER node
EXPOSE 9100
CMD ["npm", "run", "start"]
