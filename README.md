# docker-ocspd
OpenCA ocspd docker container

# run
docker run -idt --restart=always -p 2560:2560 -v <cert_dir>:/data/ocspd <image>

# OCSPD commands
https://github.com/openca/openca-ocspd/blob/master/README
