# dockerfiles
These dockerfiles all start with Tensorflow and add a few more tools. The main additions are scipy and pillow, matplotlib (as well as python3-tk for displaying plots), and tensorflow-datasets.

## Building Images

All the dockerfiles are named `tf-<TAG>.Dockerfile` where tag indicates the tensorflow tag. I've chosen to name the images in the following way:
```
docker build --rm -f tf-1.13.1-py3.Dockerfile -t mytf:1.13.1-py3 .
```

## Aliases
To make things easier, add aliases of long docker run commands.

### Some options to add to docker comand
* `--runtime=nvidia` Use the GPU. (Necessary if using a gpu tag.)
* `-u $(id -u):$(id -g)` Run as current user (not as root).
* `-e DISPLAY=$DISPLAY` and `-v /tmp/.X11-unix:/tmp/.X11-unix` Show matplotlib plots.
* `-v $PWD:/tmp` and `-w /tmp` Map the current directory to `/tmp` and make `/tmp` the working directory.

### Example aliases
```
# Alias to run python code in a docker container with tensorflow, etc.
alias pytf='docker run -it --rm -e DISPLAY=$DISPLAY -u $(id -u):$(id -g) \
            -v $PWD:/tmp -v /tmp/.X11-unix:/tmp/.X11-unix -w /tmp \
            mytf:1.13.1-py3 python'
alias bashtf='docker run -it --rm -e DISPLAY=$DISPLAY -u $(id -u):$(id -g) \
              -v $PWD:/tmp -v /tmp/.X11-unix:/tmp/.X11-unix -w /tmp \
              mytf:1.13.1-py3 bash'

alias pytf2='docker run -it --rm -e DISPLAY=$DISPLAY -u $(id -u):$(id -g) \
             -v $PWD:/tmp -v /tmp/.X11-unix:/tmp/.X11-unix -w /tmp \
             mytf:2.0.0a0-py3 python'
alias bashtf2='docker run -it --rm -e DISPLAY=$DISPLAY -u $(id -u):$(id -g) \
              -v $PWD:/tmp -v /tmp/.X11-unix:/tmp/.X11-unix -w /tmp \
              mytf:2.0.0a0-py3 bash'
```
Use cases of these aliases:
* `pytf tf1.0_compatible_code.py`
* `pytf2 tf2.0_compatible_code.py`
