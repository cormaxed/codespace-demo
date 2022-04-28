# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.209.6/containers/javascript-node/.devcontainer/base.Dockerfile

# [Choice] Node.js version (use -bullseye variants on local arm64/Apple Silicon): 16, 14, 12, 16-bullseye, 14-bullseye, 12-bullseye, 16-buster, 14-buster, 12-buster
ARG VARIANT="16-bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${VARIANT}

ARG USERNAME=node

# Install Docker for DIND support
RUN apt-get update && \
    apt-get install -y \
        btrfs-progs \
		e2fsprogs \
		iptables \
		openssl \
		xfsprogs \
		pigz \
        gnupg

RUN addgroup -S dockremap; \
	adduser -S -G dockremap dockremap; \
	echo 'dockremap:165536:65536' >> /etc/subuid; \
	echo 'dockremap:165536:65536' >> /etc/subgid

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

RUN echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    focal stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io
COPY daemon.json /etc/docker/daemon.json

RUN usermod -aG docker ${USERNAME}

# Install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Install neovim
RUN cd /tmp \ 
    && wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage \
    && chmod +x nvim.appimage \
    && ./nvim.appimage --appimage-extract \
    && cp -rf squashfs-root/usr/* /usr/ \
    && rm -rf nvim.appimage squashfs-root

# Install language plugins 
RUN apt install -y python3-pip \
    && python -m pip install pynvim
RUN npm install -g neovim

# Install tmux
RUN apt install -y tmux fzf

# Install Hasura CLI
RUN curl -L "https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh" | bash

# Install postgres cli
RUN apt-get install -y postgresql-client

# Install Azure functions
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
    && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/debian/$(lsb_release -rs | cut -d'.' -f 1)/prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list' \
    && apt-get update \
    && apt-get install -y azure-functions-core-tools-4
