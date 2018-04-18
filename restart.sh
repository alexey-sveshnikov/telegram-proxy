docker rm -f socks
docker run -p 1080:1080 -v `pwd`/sockd.conf:/etc/sockd.conf -d --name socks --restart unless-stopped telegram-socks
