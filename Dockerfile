# syntax=docker/dockerfile:1.0-experimental
FROM ubuntu:bionic as compiled
ENV LC_ALL=C.UTF-8
WORKDIR /usr/src
RUN	true \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		autoconf \
		automake \
		ca-certificates \
		gcc \
		git \
		libevent-dev \
		libncurses-dev \
		make \
		pkg-config \
	&& git clone http://github.com/tmux/tmux.git . \
	&& sh autogen.sh \
	&& ./configure --enable-static --disable-nls \
	&& make

FROM ubuntu:latest
ENV LC_ALL=C.UTF-8
COPY --from=compiled /usr/src/tmux /usr/local/bin/tmux
