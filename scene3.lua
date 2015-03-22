local composer = require( "composer" )
local scene = composer.newScene()
local score = require( "score" )
local level = require( "level" )

local _W = display.contentWidth
local _H = display.contentHeight

local scoreText = score.init({
   x = display.contentCenterX,
   y = -10,
   maxDigits = 3,
   leadingZeros = false,
   filename = "scorefile.txt",
})

local levelText = level.init({
   x = display.contentCenterX,
   y = -1000,
   maxDigits = 3,
   leadingZeros = false,
   filename = "levelfile.txt",
})


local function onSceneTouch2( self, event )
	if event.phase == "began" then		
		composer.gotoScene( "scene2", "fade", 100  )		
		return true
	end
end

local image



local points

function scene:create( event )
	points =  event.params.numPoints
	local sceneGroup = self.view
	
	image = display.newCircle( _W/2-100, _H/2, _H+50 )
	image:setFillColor(0/255,137/255,166/255)
	sceneGroup:insert( image )
	image.touch = onSceneTouch2
	
	local myText = "Level "..level.get().."\n\n".."Last level score: "..points.."\n".."Total score: "..score.get().."\n".."Tap to continue..."

	local options = {
	   text = myText,
	   x = _W/2,
	   y = _H/2+90,
	   width = 320,
	   height = 300,
	   font = "Track",
	   fontSize = 20,
	   align = "left"
	}
	
	textField = display.newText( options )
	textField:setFillColor( 1, 1, 1 )
	sceneGroup:insert( textField )

	
end

function scene:show( event )
	local phase = event.phase
	if "did" == phase then
		--composer.removeScene( "scene2" )
		
		--composer.destroyScene( "scene2" )
		composer.removeHidden()
		points =  event.params.numPoints
		
		textField.text = "Level "..level.get().."\n\n".."Last level score: "..points.."\n".."Total score: "..score.get().."\n".."Tap to continue..."
		image:addEventListener( "touch", image )
		
		
	end
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then
		image:removeEventListener( "touch", image )
		
	end
	
end

function scene:destroy( event )
composer.removeHidden(true)
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene