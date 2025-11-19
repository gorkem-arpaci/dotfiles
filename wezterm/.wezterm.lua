local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- Temel ayarlar
-- config.font = wezterm.font("Fira Code")
config.font = wezterm.font("SF Mono", { weight = "Medium" })
config.font_size = 17
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.55
config.macos_window_background_blur = 35
config.default_cursor_style = "BlinkingBlock"
config.color_scheme = "Summerfruit Dark (base16)"

-- Pencere boyutlarını ayarlama - Başlangıç konumu (0,0) ve pencere boyutu
-- Ekranın soluna yapışacak şekilde, ekran yüksekliği kadar uzun ve genişliği ekran genişliğinin %30'u
config.window_padding = {
	left = 10,
	right = 0,
	top = 0,
	bottom = 0,
}
-- Her açılışta pencereyi konumlandırma - startup event ekleyerek
wezterm.on("gui-startup", function()
	-- Aktif ekranın boyutlarını al
	local screen = wezterm.gui.screens().active
	local screen_width = screen.width
	local screen_height = screen.height

	-- Genişliği ekranın %30'u olarak ayarla
	local window_width = math.floor(screen_width * 0.75)

	-- Yeni pencere oluştur
	local _, _, window = wezterm.mux.spawn_window({})

	-- Pencerenin konumunu ve boyutunu ayarla
	window:gui_window():set_position(screen_width * 0.25, 0)
	window:gui_window():set_inner_size(window_width, screen_height)
end)

-- Değişiklikler kaydedildiğinde otomatik yapılandırma yükle
config.automatically_reload_config = true

return config
