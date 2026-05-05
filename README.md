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
| `PUID` | _not set_ | desired user id of the process owner
| `PGID` | _not set_ | desired group id of the process pwner (primary group of the `PUID` user)
| `PUSER` | _not set_ | desired `PUID` user name
| `PGROUP` | _not set_ | desired `PGID` group name
| `CHOWN` | _not set_ | space-separated list of directories to change ownership to `PUID`/`PGID` during container startup
| `CRON` | _not set_ (`0`) | will start _cron_ inside the container if set to `1`
| `TZ` / `TIMEZONE` | _not set_ (`UTC`) | desired container timezone

### Supported platforms

 * `linux/amd64`;
 * `linux/386`;
 * `linux/arm/v7`;
 * `linux/arm64/v8`;
 * `linux/ppc64le`;
 * `linux/s390x`;
