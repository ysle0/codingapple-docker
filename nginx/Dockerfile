FROM nginx:1.27.5

COPY ./myconf1.conf /etc/nginx/conf.d/myconf1.conf
RUN ["rm", "/etc/nginx/conf.d/default.conf"]
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
