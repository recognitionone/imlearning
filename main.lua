display.setStatusBar( display.HiddenStatusBar )
local composer = require "composer"
composer.gotoScene( "scene1", "fade", 100 )

--composer.recycleOnSceneChange = true
--composer.recycleOnLowMemory = true
composer.purgeOnSceneChange = true

