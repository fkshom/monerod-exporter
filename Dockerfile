FROM node:16-alpine3.14 as build-env

ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json
ADD index.js /app/index.js
WORKDIR /app

RUN npm ci --only=production

FROM node:16-alpine3.14
COPY --from=build-env /app /app
WORKDIR /app

EXPOSE 18083/tcp
ENV PORT=18083
ENV DAEMON_HOST=http://localhost:18081

USER nonroot
CMD [ "index.js" ]