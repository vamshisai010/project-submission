FROM nginx:alpine COPY index.html /usr/share/nginx/html/index.html RUN sed -i 's/listen 80;/listen 8000;/g' /etc/nginx/conf.d/default.conf EXPOSE 8000 CMD ["nginx", "-g", "daemon off;"]
