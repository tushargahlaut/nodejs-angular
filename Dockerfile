#stage 1
ARG APP_NAME=angular-frontend
FROM node:16.17.0 as node
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod
#stage 2
FROM nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=node /app/dist/angular-frontend /usr/share/nginx/html
EXPOSE 8080:8080
CMD ["nginx", "-g", "daemon off;"]
