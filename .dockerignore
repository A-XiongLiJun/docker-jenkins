FROM node:16

WORKDIR /root/www

COPY package*.json ./

RUN npm config set registry https://registry.npmmirror.com/

RUN npm install pnpm -g

RUN pnpm install

COPY . .

EXPOSE 5173/tcp

CMD ["pnpm", "dev"]