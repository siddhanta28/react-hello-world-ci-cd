FROM node:9.5 as builder

RUN mkdir -p /react
WORKDIR /react
COPY . .
ENV PATH /react/node_modules/.bin:$PATH
RUN npm i && npm i -g react-scripts
RUN npm run build



FROM nginx:alpine

COPY --from=builder /react/build /usr/share/nginx/html

# needed this to make React Router work properly 

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx/nginx.conf /etc/nginx/conf.d

EXPOSE 3000 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]