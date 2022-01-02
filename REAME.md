# How to use Docker

## Get files

get the VCS files

``` bash
cd /data/tools/synopsys/
zip -r --symlinks ~/VCS2019.06-SP2.zip VCS2019.06-SP2/
zip -r --symlinks ~/installer_v5.1.zip installer_v5.1/
scp -r dunlop:~/VCS2019.06-SP2.zip VCS2019.06-SP2.zip
scp -r carlson:~/installer_v5.1.zip installer_v5.1.zip
unzip VCS2019.06-SP2.zip
unzip installer_v5.1.zip
```

## Build command

`docker build --squash --tag vcs_image:0.1`

## run image

`docker run --detach --name vcs vcs_image:0.1`

## possible solution

`docker run -v $PWD:/data -w /data itamarst/dataprocessor input.txt output.txt`
`docker run -u "$(id -u):$(id -g)" -v $PWD:/data -w /data itamarst/dataprocessor input.txt output.txt`

- [libelf.so.1](http://chipkit.net/forum/viewtopic.php?t=103)

- [Docker doc](https://docs.docker.com/engine/reference/commandline/run/)

- [synopsys docker](https://hub.docker.com/layers/vgsnps/vcs_docker/latest/images/sha256-c2283e8c6f1007ccfb868a0502467726b6e0a08228b208a3b5e47995ae08f5f9?context=explore)

- [modelsim docker](https://hub.docker.com/r/goldensniper/modelsim-docker)

- [synopsys docker example](https://github.com/limerainne/Dockerize-EDA/blob/master/Dockerfile_Synopsys_VCS)

- [run command example](https://linuxize.com/post/docker-run-command/)

- [vagrant docker](https://www.vagrantup.com/docs/provisioning/docker.html)

- [connect to docker](https://linuxize.com/post/how-to-connect-to-docker-container/)

- [vscode docker](https://code.visualstudio.com/docs/remote/containers)

- [flexlm](https://www.artwork.com/support/linux/installing_flex_license_server_on_linux.htm)
