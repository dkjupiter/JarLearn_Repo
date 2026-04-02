# build frontend
FROM node:18 AS build-frontend
WORKDIR /app
# COPY myapp/package*.json ./myapp/
# RUN cd myapp && npm install --legacy-peer-deps
# COPY myapp ./myapp
COPY myapp ./myapp
RUN cd myapp && npm install --legacy-peer-deps
RUN cd myapp && npm run build

# backend
FROM node:18
WORKDIR /app

COPY server/package*.json ./server/
RUN cd server && npm install --legacy-peer-deps

COPY server ./server

# copy build frontend มาใช้
COPY --from=build-frontend /app/myapp/build ./myapp/build

WORKDIR /app/server

ENV PORT=10000

CMD ["node", "index.js"]