Dockerized Tmux Build
=====================

A `Dockerfile` that produces a statically-linked build of
`tmux` -- the terminal multiplexer, enclosed in an `ubuntu`
image.

The resulting image can either be used directly (which likely
makes little sense) or the resulting `tmux` binary simply copied
out using `docker cp container:/usr/bin/tmux ./tmux`.

_NOTE_: Even though the `tmux` binary is statically-linked, it
still depends on e.g. locales to be properly configured wherever
one tries to run it. I.e. it won't work on non-`glibc` platforms.
