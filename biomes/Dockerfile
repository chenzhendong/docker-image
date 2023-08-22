# Use the latest version of Ubuntu as the base image
FROM ubuntu:latest

# Install necessary tools
RUN apt-get -y update && \
    apt-get install -y curl vim clang build-essential rsync git-lfs sudo && \
    apt-get install -y gcc libpq-dev python3-dev python3-pip python3-venv python3-wheel && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -u 1000 -s /usr/bin/bash -m -G root,sudo ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ubuntu && \
    mkdir -p /biomes &&  chown ubuntu:ubuntu /biomes && \
    ln -s /usr/bin/python3 /usr/bin/python

USER ubuntu

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash && \
    source ~/.bashrc && nvm install v20  && nvm use v20 && npm install -g yarn && npm install -g @bazel/bazelisk

RUN cd /biomes && git clone https://github.com/ill-inc/biomes-game.git && cd biomes-game && \
    python -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt && \
    curl -s https://download.redis.io/releases/redis-7.0.8.tar.gz | tar xvz -C ${HOME}   && \ 
    make -j`nproc` -C ${HOME}/redis-7.0.8   && sudo make install -C ${HOME}/redis-7.0.8   && \
    rm -rf ${HOME}/redis-7.0.8 && \
    yarn global add node-gyp

CMD ["/biomes/biomes-game/b", "data-snapshot", "run"]

