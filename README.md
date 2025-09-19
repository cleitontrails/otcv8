# OTClientV8 Linux

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Supported platform:
- Linux (exclusive)

### Based on [otcv8/otcv8-dev](https://github.com/otcv8/otcv8-dev) - Personal Linux-focused fork

### Features

- Rewritten and optimized rendering (60 fps)
- Optimized light rendering system
- Rewritten path finding and auto walking
- HTTP/HTTPS lua API with JSON support
- WebSocket lua API
- New filesystem with file encryption and compression
- Refreshed interface with modular system
- Updated hotkey manager
- Full Tibia 11.00+ support
- Support for proxies to lower latency
- Advanced bot protection
- And hundreds of smaller features and optimizations

### What is otclient?

Otclient is an alternative Tibia client for usage with otserv. It aims to be complete and flexible,
for that it uses LUA scripting for all game interface functionality and configurations files with a syntax
similar to CSS for the client interface design. Otclient works with a modular system, this means
that each functionality is a separated module, giving the possibility to users modify and customize
anything easily. Users can also create new mods and extend game interface for their own purposes.

For a server to connect to, you can build your own with [canary](https://github.com/opentibiabr/canary).

### Building

#### Prerequisites

```bash
# Install dependencies (Arch Linux / CachyOS)
sudo pacman -S cmake ninja gcc git

# Set up vcpkg
export VCPKG_ROOT=/path/to/vcpkg
```

#### Compile

```bash
# Configure
cmake --preset linux-release

# Build
cmake --build build/linux-release
```

#### Configuration

Edit `init.lua` to configure servers, services, and client settings.

### Credits

  * [kondra](https://github.com/OTCv8)
  * [oen432](https://github.com/Oen44)
  * [vithrax](https://github.com/Vithrax)
  * [original contributors](https://github.com/opentibiabr/otcv8/graphs/contributors)

### License

Otclient is made available under the MIT License, thus this means that you are free
to do whatever you want, commercial, non-commercial, closed or open.