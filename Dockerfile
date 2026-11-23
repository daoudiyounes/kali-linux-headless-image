
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get -y install --no-install-recommends kali-linux-headless \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
