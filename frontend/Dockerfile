# Build React frontend and serve with nginx

# stage 1: build
FROM node:18-alpine AS build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# stage 2: serve
FROM nginx:stable-alpine
# remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /usr/src/app/build /usr/share/nginx/html

# copy custom nginx.conf to redirect API calls
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
