FROM node:16

WORKDIR /app

COPY package*.json ./

RUN npm config set registry https://registry.npmmirror.com/

RUN npm install pnpm -g

RUN pnpm install

RUN pnpm build

FROM nginx:alpine
COPY --from=build /app/build /root/www
EXPOSE 8091
CMD ["nginx", "-g", "daemon off;"]
docker build -t nginx:v1 .