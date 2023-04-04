# 构建镜像基于onbuild_vue:v1镜像
FROM node:16.16.0 AS builder
#切换到/app工作目录下
WORKDIR /app
# 复制package.json到app目录下
COPY package.json ./
# 执行npm命令
RUN npm config set registry https://registry.npm.taobao.org/ && \
    npm install pnpm -g && \
    pnpm install
# 复制当前目录下的所有文件到app目录下
COPY . ./
# 执行npm run build命令
RUN pnpm build
 
# 构建镜像基于nginx:alpine镜像
FROM nginx:alpine
# 声明端口80。仅声明作用，如果docker run -P 就会指定该端口
EXPOSE 80
# 从名为builder的阶段，复制打包好的文件到/usr/share/nginx/html/
COPY --from=builder /app/dist /usr/share/nginx/html/
# 删除原本的默认配置
# RUN rm /etc/nginx/conf.d/default.conf
# 从名为builder的阶段，复制nginx配置文件到/etc/nginx/conf.d/
# COPY --from=builder /app/nginx.conf /etc/nginx/conf.d/