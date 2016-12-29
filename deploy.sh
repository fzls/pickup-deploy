#!/bin/bash

echo "----------开始创建文件夹----------"
mkdir pickup
cd pickup

echo "----------开始部署oauth服务器----------"

echo "----------从github仓库拉取oauth项目代码" \
    && git clone -b without_ssl --single-branch https://github.com/fzls/oauth-server.git \
    && cd oauth-server \
    && echo "----------对必要的配置文件（.env，docker-compose-custom.yml）进行初始化" \
    && mv -f .env.example.docker .env \
    && mv -f docker-compose-custom.yml.example docker-compose-custom.yml \
    && echo "----------开始创建oauth容器服务组" \
    && sh prod.sh up -d \
    && cd ..

echo "----------oauth服务器部署完成，通过http://localhost:9899或http://your_host_ip:9899进行访问----------"


echo "----------开始部署api服务器----------"

echo "----------从github仓库拉取api项目代码" \
    && git clone -b without_ssl --single-branch https://github.com/fzls/pickup-api.git \
    && cd pickup-api \
    && echo "----------对必要的配置文件（.env，docker-compose-custom.yml）进行初始化" \
    && mv -f .env.example.docker .env \
    && mv -f docker-compose-custom.yml.example docker-compose-custom.yml \
    && echo "----------开始创建api容器服务组" \
    && sh prod.sh up -d \
    && cd ..

echo "----------api服务器部署完成，通过http://localhost:2333或http://your_host_ip:2333进行访问----------"


echo "----------开始部署web服务器----------"

echo "----------从github仓库拉取web项目代码" \
    && git clone -b without_ssl --single-branch https://github.com/fzls/pickup-web.git \
    && cd pickup-web \
    && echo "----------对必要的配置文件（.env，docker-compose-custom.yml）进行初始化" \
    && mv -f .env.example.docker .env \
    && mv -f docker-compose-custom.yml.example docker-compose-custom.yml \
    && mv -f ./public/js/config/env.example.js ./public/js/config/env.js

echo ""
echo "*******************************************************************************"
echo "***********上述命令运行完成后马上访问相应端口可能显示502 Bad Gateway***********"
echo "***********这是因为php容器正在安装必要的包，可以使用docker logs oauthserver_php_1 -f来查看安装进度，其他几个服务器将oauthserver改为对应的名字即可***********"
echo "*******************************************************************************"
echo ""

echo ""
echo "*******************************************************************************"
echo "如果需要对API服务器的数据进行初始化用以测试，可以执行下列命令，等待其执行完毕即可"
echo "docker exec pickupapi_php_1 php artisan db:seed --force"
echo "*******************************************************************************"
echo ""

echo "注意："
echo "打开./public/js/config/env.js，按照提示将step1,2中的相应内容进行修改"
echo "修改完成后再pickup-web目录下运行 sh prod.sh up -d 即可"
echo "等上述命令完成后通过http://localhost:666或http://your_host_ip:666进行访问"


