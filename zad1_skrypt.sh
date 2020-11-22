#!/bin/bash

docker network create -d bridge --subnet 10.0.10.0/24 bridge1
docker network create -d bridge --subnet 192.168.56.1/24 bridge2




docker create --name D1 alpine
docker create --name T1 alpine 

docker create --name D2 -p 10.0.10.1:8080:80 -p 192.168.56.1:8081:80 httpd
docker create --name T2 -p 172.17.0.1:80:80 -p 10.0.10.1:8000:80 nginx

docker network connect --ip 10.0.10.254 bridge1 D1
docker network connect bridge1 D2
docker network connect bridge2 D2
docker network connect bridge1 T2

docker network disconnect bridge D1
docker network disconnect bridge D2

docker create -ti --name S1 --net bridge2 ubuntu:latest
docker create -ti --name late --net bridge1 ubuntu:latest
docker network connect bridge2 late


docker start D1 D2 T1 T2 S1 late



