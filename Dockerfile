# syntax=docker/dockerfile:1.0-experimental

ARG LC_ALL=C.UTF-8
ARG BUILD_DIR=/usr/src
ARG BIN_DIR=/usr/local/bin

FROM ubuntu:bionic as compiled
ARG LC_ALL
ENV LC_ALL="${LC_ALL}"
ARG BUILD_DIR
ENV BUILD_DIR="${BUILD_DIR}"
WORKDIR "${BUILD_DIR}"
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
ARG LC_ALL
ENV LC_ALL="${LC_ALL}"
ARG BUILD_DIR
ENV BUILD_DIR="${BUILD_DIR}"
ARG BIN_DIR
ENV BIN_DIR="${BIN_DIR}"
COPY --from=compiled "${BUILD_DIR}"/tmux "${BIN_DIR}"/tmux
ENTRYPOINT ["tmux"]
