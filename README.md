## Base image for complex docker images

The image contains:

 * timezone database (`tzdata`);
 * CA certificates (`ca-certificates`);
 * terminal information (`libtinfo`);
 * mime types (`media-types`);
 * ncurses (`libcurses`);
 * extra libraries: `libreadline`, `libstdc++`;

It is built on top of the [clover/base](https://hub.docker.com/r/clover/base/).

### Enviroment variables

| Name       | Default value | Description      |
|------------|---------------|------------------|
| `TIMEZONE` | `UTC`         | Desired timezone |

### Supported platforms

 * `linux/amd64`;
 * `linux/386`;
 * `linux/arm/v7`;
 * `linux/arm64/v8`;
 * `linux/ppc64le`;
 * `linux/s390x`;
