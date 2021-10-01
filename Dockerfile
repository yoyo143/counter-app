FROM nginx:1.20.1-alpine

WORKDIR /usr/share/nginx/html

COPY build/* .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
