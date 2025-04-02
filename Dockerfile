FROM nginx:latest
COPY . /usr/share/nginx/html
EXPOSE 85
CMD ["nginx", "-g", "daemon off;"]
