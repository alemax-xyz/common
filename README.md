## Base image for complex docker images

The image contains:

 * timezone database (`tzdata`);
 * CA certificates (`ca-certificates`);
 * terminal information (`libtinfo`);
 * mime types (`media-types`);
 * ncurses (`libcurses`);
 * fgciwrap (`fcgiwrap`);
 * extra libraries: `libreadline`, `libstdc++`;

It is built on top of the [clover/base](https://hub.docker.com/r/clover/base/).

### Enviroment variables

| Name | Default value | Description
| ---- | ------------- | -----------
| `PUID` | `50` | Desired _UID_ of the process owner _*_
| `PGID` | primary group id of the _UID_ user (`50`) | Desired _GID_ of the process owner _*_
| `CRON` | _not set_ | Will start _cron_ inside the container if set to `1`
| `TIMEZONE` | `UTC` | Desired container timezone

### Supported platforms

 * `linux/amd64`;
 * `linux/386`;
 * `linux/arm/v7`;
 * `linux/arm64/v8`;
 * `linux/ppc64le`;
 * `linux/s390x`;
