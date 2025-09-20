-- CONFIG - OTClient 8.6 Native Linux Edition
APP_NAME = "otclient86-linux"    -- Tibia 8.6 exclusive client
APP_VERSION = 860                -- Hardcoded for Tibia 8.6 protocol
DEFAULT_LAYOUT = "retro"         -- Optimized layout for 8.6

-- Services disabled for 8.6 simplicity
Services = {
  website = "",
  updater = "",
  stats = "",
  crash = "",
  feedback = "",
  status = ""
}

-- Simple server configuration - only IP:PORT needed (8.6 protocol hardcoded)
Servers = {
  ["Baiak-Fury"] = "baiakeiros.com.br:7171:860"  -- No version needed - always 8.6
}

-- Simplified configuration for 8.6 only
ALLOW_CUSTOM_SERVERS = true     -- Allow easy server IP input
HARDCODED_CLIENT_VERSION = 860  -- Force 8.6 protocol
HARDCODED_PROTOCOL_VERSION = 860

g_app.setName("OTCv8 Linux")
-- CONFIG END

-- print first terminal message
g_logger.info(os.date("== application started at %b %d %Y %X"))
g_logger.info(g_app.getName() .. ' ' .. g_app.getVersion() .. ' (' .. g_app.getBuildCommit() .. ') made by ' .. g_app.getAuthor() .. ' built on ' .. g_app.getBuildDate() .. ' for arch ' .. g_app.getBuildArch())

if not g_resources.directoryExists("/data") then
  g_logger.fatal("Data dir doesn't exist.")
end

if not g_resources.directoryExists("/modules") then
  g_logger.fatal("Modules dir doesn't exist.")
end

-- settings
g_configs.loadSettings("/config.otml")

-- set layout
local settings = g_configs.getSettings()
local layout = DEFAULT_LAYOUT
if settings:exists('layout') then
  layout = settings:getValue('layout')
end
g_resources.setLayout(layout)

-- load mods
g_modules.discoverModules()
g_modules.ensureModuleLoaded("corelib")

local function loadModules()
  -- libraries modules 0-99
  g_modules.autoLoadModules(99)
  g_modules.ensureModuleLoaded("gamelib")

  -- client modules 100-499
  g_modules.autoLoadModules(499)
  g_modules.ensureModuleLoaded("client")

  -- game modules 500-999
  g_modules.autoLoadModules(999)
  g_modules.ensureModuleLoaded("game_interface")

  -- mods 1000-9999
  g_modules.autoLoadModules(9999)
end

-- report crash
if type(Services.crash) == 'string' and Services.crash:len() > 4 and g_modules.getModule("crash_reporter") then
  g_modules.ensureModuleLoaded("crash_reporter")
end

-- run updater, must use data.zip
if type(Services.updater) == 'string' and Services.updater:len() > 4
  and g_resources.isLoadedFromArchive() and g_modules.getModule("updater") then
  g_modules.ensureModuleLoaded("updater")
  return Updater.init(loadModules)
end
loadModules()
