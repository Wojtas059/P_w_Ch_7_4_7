#!/bin/bash

docker stop D1 D2 S1
docker rm D1 D2 S1

docker network rm bridge1 bridge2

docker network create -d bridge --subnet 10.0.10.0/24 bridge1
docker network create -d bridge --subnet 192.168.56.1/24 bridge2

docker run -itd --name D1 alpine
docker network connect --alias host1 bridge1 D1

docker run -itd --name D2 --net bridge1 --network-alias apa1 -p 10.0.10.1:8080:80 apache
docker network connect --alias apa2 bridge2 D2 -p 10.0.2.1:8081:80 apache

docker run -itd --name S1 --net bridge2 --network-alias host2 ubuntu:latest




