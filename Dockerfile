FROM python:3.12-bullseye


ENV LANG en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_DRIVER_CAPABILITIES video,compute,utility

RUN apt-get update && apt-get install --no-install-recommends -y software-properties-common \
    build-essential curl nano vim git sudo lshw wget netcat net-tools iputils-ping \
	zsh git-lfs && \
    apt clean && rm -rf /var/lib/apt/lists/*

RUN curl https://bootstrap.pypa.io/get-pip.py | python3


ARG USER_ID=1000
ARG USERS_GID=100
ARG USER=agent

RUN useradd -m ${USER} --uid=${USER_ID} &&  \
	echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
	adduser ${USER} users && adduser ${USER} sudo && \
	usermod --shell /usr/bin/bash ${USER} 


USER ${USER}
WORKDIR /home/${USER}

ENV PATH="/home/${USER}/.local/bin:${PATH}"

RUN pip install PyYAML fastapi fastapi_utils pandarallel pydantic typer pyautogen llama_index weaviate-client
RUN sudo apt-get install -y build-essential
RUN mkdir -p /home/${USER}/workspace/autogen
COPY --chown=${USER}:users autogen /home/${USER}/workspace/autogen
