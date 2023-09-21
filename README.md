# yocto-docker
Dockerfile to build yocto within a container

## Identify host user PUID and PGID
```
cat /etc/passwd
```

## Build the image
Execute the following command by replacing IMAGE_NAME, HOST_USERNAME, HOST_PUID, and HOST_PGID
```
sudo docker build -f Dockerfile -t IMAGE_NAME --build-arg USERNAME=HOST_USERNAME --build-arg PUID=HOST_PUID --build-arg PGID=HOST_PGID .
sudo docker build -f Dockerfile -t my-yocto --build-arg USERNAME=julien --build-arg PUID=1000 --build-arg PGID=1000 .
```

## Run the image
Execute the following command by replacing IMAGE_NAME, HOST_WORKDIR, and REMOTE_WORKDIR
```
sudo docker run -it --rm -v HOST_WORKDIR:REMOTE_WORKDIR IMAGE_NAME
sudo docker run -it --rm -v /home/julien/workspaces/yocto:/home/julien/workspaces/yocto my-yocto
```

At this point, all the packages required by yocto are installed. You can clone poky, and build the minimal image as an example:
```
cd ~/workspaces/yocto/
git clone -b kirkstone https://github.com/yoctoproject/poky.git
cd poky
source oe-init-build-env
bitbake core-image-minimal
```

The outputs are shared with the host and generated into the folder specified (/home/julien/workspaces/yocto).

Once built, you can use the QEmulator from the host environment. You don't need the docker environment anymore.
```
runqemu /home/julien/workspaces/yocto/poky/build/tmp/deploy/images/qemux86-64
```