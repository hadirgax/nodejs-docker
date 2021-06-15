# -------------> The development image
FROM node:lts-alpine AS dev
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
USER node
CMD [ "node", "server.js" ]

# -------------> The build image
# FROM node:lts-alpine AS build
# ARG NPM_TOKEN
# WORKDIR /usr/src/app
# COPY package*.json /usr/src/app
# RUN echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > .npmrc \
#     && npm ci --only=production \
#     && rm -f .npmrc

# -------------> The production image
# FROM node:lts-alpine
# RUN apk add dumb-init
# ENV NODE_ENV production
# USER node
# WORKDIR /usr/src/app
# COPY --chown=node:node --from=build /usr/src/app/node_modules /usr/src/app/node_modules
# COPY --chown=node:node . /usr/src/app
# CMD ["dumb-init", "node", "server.js"]