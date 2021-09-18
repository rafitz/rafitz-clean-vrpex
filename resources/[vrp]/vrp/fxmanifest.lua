fx_version "bodacious"
game "gta5"

ui_page "gui/index.html"
ui_page_preload "yes"

server_scripts { 
	"lib/utils.lua",
	"base.lua",
	"queue.lua",
	"modules/gui.lua",
	"modules/group.lua",
	"modules/player_state.lua",
	"modules/map.lua",
	"modules/identity.lua",
	"modules/basic_skinshop.lua"
}

client_scripts {
	"lib/utils.lua",
	"client/base.lua",
	"client/gui.lua",
	"client/player_state.lua",
	"client/survival.lua",
	"client/map.lua",
	"client/identity.lua",
	"client/noclip.lua"
}

files {
	"loading/index.html",	
  	"loading/1.css",
  	"loading/logo.png",
  	"loading/app.js",
 	"loading/particles.js",
  	"loading/background.png",
 	"loading/assets/css/style.css",
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"lib/Luaseq.lua",
	"lib/Tools.lua",
	"gui/*",
}

loadscreen "loading/index.html"

server_export "AddPriority"
server_export "RemovePriority"