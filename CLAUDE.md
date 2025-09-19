# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

OTClientV8 Linux is an alternative Tibia client built exclusively for Linux with C++ and Lua scripting. Based on the otcv8-dev project, it provides optimized rendering, native X11 window management, and extensive customization through a modular system. The client connects to OTServ servers and features an advanced interface system using Lua for game logic and CSS-like syntax for UI design.

## Build System

This project uses CMake with vcpkg for dependency management:

- **Build Configuration**: Use CMake with the vcpkg toolchain file
- **Dependencies**: Managed through vcpkg.json, installed to `libs/` directory
- **Platform**: Linux only (X11/Wayland compatible)
- **Output**: Clean deployment created in `build/` directory with executable and all assets

### Build Commands

```bash
# Configure with vcpkg (set VCPKG_ROOT environment variable first)
cmake -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake .

# Build (creates executable and assets in build/ directory)
cmake --build . --parallel $(nproc)

# Run
cd build && ./otclient
```

### Build Options

- `OPTIONS_ENABLE_CCACHE`: Enable ccache for faster compilation (ON by default)
- `OPTIONS_ENABLE_SCCACHE`: Use sccache for compilation caching
- `OPTIONS_ENABLE_IPO`: Enable interprocedural optimization (LTO)

## Code Architecture

### Core Structure

- **`src/client/`**: Core client logic including game protocol, rendering, and entity management
  - `protocolgame.cpp/h`: Network protocol handling for server communication
  - `game.cpp/h`: Main game state and logic management
  - `map.cpp/h`: Game world map representation and management
  - `creature.cpp/h`, `player.cpp/h`: Entity system for characters and NPCs
  - `mapview.cpp/h`: Rendering and display of the game world
  - `lightview.cpp/h`: Optimized light rendering system

- **`src/framework/`**: Low-level framework providing rendering, input, audio, and Linux platform support

### Key Systems

1. **Modular Architecture**: Game functionality is split into loadable modules with priority-based loading (0-99: libraries, 100-499: client, 500-999: game, 1000-9999: mods)

2. **Lua Integration**: Extensive Lua bindings for game logic, UI, and scripting through `luafunctions_client.cpp`

3. **Protocol System**: Client-server communication through `protocolgame.cpp` with support for Tibia 11.00+ protocol

4. **Rendering Pipeline**: Optimized OpenGL rendering with X11 window management, adaptive rendering, and 60fps target

### Project Structure

```
/
├── src/           # C++ source code
├── assets/        # Game assets (source files)
│   ├── data/      # Images, sounds, fonts, shaders, styles
│   ├── modules/   # Lua modules and game logic
│   ├── layouts/   # UI layout configurations
│   ├── mods/      # Game modifications and extensions
│   └── init.lua   # Main configuration template
├── libs/          # vcpkg dependencies (auto-generated)
├── build/         # Clean deployment (auto-generated)
│   ├── otclient   # Executable (ready to run)
│   ├── data/      # Copied game assets
│   ├── modules/   # Copied Lua modules
│   ├── layouts/   # Copied UI layouts
│   ├── mods/      # Copied modifications
│   └── init.lua   # Configuration file
└── cmake/         # CMake modules and helpers
```

### Configuration

- **`assets/init.lua`**: Main configuration template defining app settings, servers, and services
- **`build/init.lua`**: Generated configuration file (copied from assets during build)
- Configuration includes app name, version, default layout, service URLs, and server connections
- Modular loading system with automatic discovery and priority-based initialization

## Development Workflow

When working with this Linux-exclusive codebase:

1. **Client-side changes**: Focus on `src/client/` for game logic modifications
2. **Framework changes**: Modify `src/framework/` for low-level Linux system changes
3. **Platform-specific**: All platform code is now Linux-only in `src/framework/platform/`
4. **Lua integration**: Update `luafunctions_client.cpp` for new Lua bindings
5. **Protocol changes**: Modify `protocolgame.cpp` for server communication updates

## Key Dependencies

- **LuaJIT**: Lua scripting engine for game logic
- **OpenGL**: Graphics rendering (Linux native)
- **PhysFS**: Virtual file system for game assets
- **OpenAL**: Audio system
- **Asio**: Network communication
- **OpenSSL**: Secure connections and encryption

This Linux-exclusive version maintains compatibility with the original OTClient API while providing enhanced performance, native Linux integration, and additional features optimized for Linux desktop environments and modern Tibia server development.