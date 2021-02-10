FROM node:14

# Create app directory
WORKDIR /botwsp

RUN apt-get update \
 && apt-get upgrade -y
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow
RUN apt-get install -y tzdata && \
    apt-get install -y \
    curl \
    python3 \
    python3-pip \
   screen \
   sudo \
    && rm -rf /var/lib/apt/lists/*

RUN chsh -s /bin/bash
ENV SHELL=/bin/bash
    
# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install

RUN pip3 install s3cmd
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

CMD bash /botwsp/start.sh