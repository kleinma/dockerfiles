FROM tensorflow/tensorflow:2.0.0a0-gpu-py3

ARG USE_PYTHON_3_NOT_2
ARG _PY_SUFFIX=${USE_PYTHON_3_NOT_2:+3}
ARG PYTHON=python${_PY_SUFFIX}
ARG PIP=pip${_PY_SUFFIX}

RUN ${PIP} install scipy pillow matplotlib tensorflow-datasets

RUN apt-get update && apt-get install -y python3-tk

ENV CUDA_VISIBLE_DEVICES=1,2

LABEL maintainer="mak177@case.edu"
