# 前置要求
* Docker[点击链接根据平台选择相应的指示进行安装](https://docs.docker.com/engine/installation)
* Docker compose[点击链接根据平台选择相应的指示进行安装](https://docs.docker.com/compose/install/)
* Git

# 部署说明
* Oauth 服务器
    - git clone -b without_ssl --single-branch https://github.com/fzls/oauth-server.git && cd oauth-server
    - mv -f .env.example.docker .env
    - mv -f docker-compose-custom.yml.example docker-compose-custom.yml
    - sh prod.sh up -d
* API 服务器
    - git clone -b without_ssl --single-branch https://github.com/fzls/pickup-api.git && cd pickup-api
    - mv -f .env.example.docker .env
    - mv -f docker-compose-custom.yml.example docker-compose-custom.yml
    - sh prod.sh up -d
* Web 服务器
    - git clone -b without_ssl --single-branch https://github.com/fzls/pickup-web.git && cd pickup-web
    - mv -f .env.example.docker .env
    - mv -f docker-compose-custom.yml.example docker-compose-custom.yml
    - mv -f ./public/js/config/env.example.js ./public/js/config/env.js
    - 打开./public/js/config/env.js，按照提示将step1,2中的相应内容进行修改
    - sh prod.sh up -d

>根据网速不同，部署速度也会有显著区别（由其是在从国外服务器下载相应资源时）

>如果需要对API服务器的数据进行初始化，可以执行下列命令，等待其执行完毕即可
>   1. docker exec pickupapi_php_1 php artisan db:seed --force
>   

# 一键部署脚本
* sh deploy.sh
* 然后根据提示进行相应的操作即可

>注意：需要先安装docker

>如果在web端发现api服务器无法与oauth服务器进行通讯，则需要将api服务器目录下的.env的最后一个AUTH_SERVER改为下面这个方式得到的ip
>打开cmd，输入ipconfig，找到
    Ethernet adapter Ethernet:

       Connection-specific DNS Suffix  . :
       Link-local IPv6 Address . . . . . : fe80::cc10:16b6:f5cd:3464%11
       IPv4 Address. . . . . . . . . . . : 10.171.40.182
       Subnet Mask . . . . . . . . . . . : 255.255.240.0
       Default Gateway . . . . . . . . . : 10.171.32.1
>其中类似于10.171.40.182这个样子的ip即为当前主机在docker中映射的ip，在docker容器中可以通过该ip访问当前主机
>NOTE：如果是在服务器端部署，则将该值设置为oauth服务器所在主机的ip即可

# 关闭相应服务
* 在对应服务文件夹下运行 sh prod.sh down 即可
