FROM node:16

WORKDIR /root/www

COPY package*.json ./

RUN npm config set registry https://registry.npmmirror.com/

RUN npm install pnpm -g

RUN pnpm install

RUN pnpm build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 8091
CMD ["nginx", "-g", "daemon off;"]
