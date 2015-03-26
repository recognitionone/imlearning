local composer = require( "composer" )
local scene = composer.newScene()

composer.recycleOnSceneChange = true

local _W = display.contentWidth
local _H = display.contentHeight

local function onSceneTouch( self, event )
	if event.phase == "began" then		
		composer.gotoScene( "scene2", "fade", 100  )		
		return true
	end
end

local backgroundCircle

function scene:create( event )
	local sceneGroup = self.view
	
	backgroundCircle = display.newCircle( _W/2-100, _H/2, _H+50 )
	backgroundCircle:setFillColor(0/255,137/255,166/255)
	sceneGroup:insert( backgroundCircle )
	backgroundCircle.touch = onSceneTouch
	
	local textbackgroundCircle = display.newText("Tap to start...", _W/2-100, _H/2, "Track", 30)
	sceneGroup:insert(textbackgroundCircle)

	local imageBlue = display.newCircle( 230, 230, 30 )
	imageBlue:setFillColor(0,1,1)
	sceneGroup:insert( imageBlue )
	imageBlue.touch = onSceneTouch2
	
	local imageGreen = display.newCircle( 380, 130, 45 )
	imageGreen:setFillColor(0,1,0)
	sceneGroup:insert( imageGreen )
	imageGreen.touch = onSceneTouch3
end

function scene:show( event )
local sceneGroup = self.view
	local phase = event.phase
	if "did" == phase then
		composer.removeScene( "scene4" )	
		
		backgroundCircle:addEventListener( "touch", backgroundCircle )		
		
		_G = 0
		_P = 0
		_L = 1
	end
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then
		backgroundCircle:removeEventListener( "touch", backgroundCircle )
		backgroundCircle:removeSelf()
	end
end

function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene