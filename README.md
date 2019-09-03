# dockerfiles
These dockerfiles all start with Tensorflow and add a few more tools. The main additions are scipy and pillow, matplotlib (as well as python3-tk for displaying plots), and tensorflow-datasets.

## Building Images

All the dockerfiles are named `tf-<TAG>.Dockerfile` where tag indicates the tensorflow tag. I've chosen to name the images in the following way:
```
docker build --rm -f tf-2.0.0b1-gpu-py3.Dockerfile -t mytf:2.0.0b1-gpu-py3 .
```

## Aliases
To make things easier, add aliases of long docker run commands.

### Some options to add to docker comand
* `--runtime=nvidia` Use the GPU. (Necessary if using a gpu tag.)
* `-u $(id -u):$(id -g)` Run as current user (not as root) so that saved files can be manipulated by the host. Also, allows .Xauthority to be read.
* `-e DISPLAY=$DISPLAY` Needed for X11 forwarding.
* `-v ${HOME}/.Xauthority:/tmp/.Xauthority -e XAUTHORITY=/tmp/.Xauthority` Map `.Xauthority` to the container and point to it to connect to the X11 server.
* `--net=host` Currently needed to connect to the X11 server over ssh. It would be nice if we could change this.
* `-v $PWD:/app` and `-w /app` Map the current directory to `/app` and make `/app` the working directory.

### Example aliases
```
# Alias to run python code in a docker container with tensorflow, etc.
alias pytf='docker run --runtime=nvidia -it --rm -u $(id -u):$(id -g) \
            --net=host -e DISPLAY=$DISPLAY \
            -v ${HOME}/.Xauthority:/tmp/.Xauthority \
            -e XAUTHORITY=/tmp/.Xauthority \
            -v $PWD:/app -w /app \
            mytf:1.13.1-gpu-py3 python'
alias bashtf='docker run --runtime=nvidia -it --rm -u $(id -u):$(id -g) \
              --net=host -e DISPLAY=$DISPLAY \
              -v ${HOME}/.Xauthority:/tmp/.Xauthority \
              -e XAUTHORITY=/tmp/.Xauthority \
              -v $PWD:/app -w /app \
              mytf:1.13.1-gpu-py3 bash'

alias pytf2='docker run --runtime=nvidia -it --rm -u $(id -u):$(id -g) \
             --net=host -e DISPLAY=$DISPLAY \
             -v ${HOME}/.Xauthority:/tmp/.Xauthority \
             -e XAUTHORITY=/tmp/.Xauthority \
             -v $PWD:/app -w /app \
             mytf:2.0.0b1-gpu-py3 python'
alias bashtf2='docker run --runtime=nvidia -it --rm -u $(id -u):$(id -g) \
               --net=host -e DISPLAY=$DISPLAY \
               -v ${HOME}/.Xauthority:/tmp/.Xauthority \
               -e XAUTHORITY=/tmp/.Xauthority \
               -v $PWD:/app -w /app \
               mytf:2.0.0b1-gpu-py3 bash'
```
Use cases of these aliases:
* `pytf tf1.0_compatible_code.py`
* `pytf2 tf2.0_compatible_code.py`
