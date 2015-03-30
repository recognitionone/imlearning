local composer = require( "composer" )
local scene = composer.newScene()
composer.recycleOnSceneChange = true


local _W = display.contentWidth
local _H = display.contentHeight

local function onSceneTouch2( self, event )
	if event.phase == "began" then		
		composer.gotoScene( "scene7", "fade", 100  )		
		return true
	end
end

local image





function scene:create( event )
	
	local sceneGroup = self.view
	
	image = display.newCircle( _W/2, _H/2, _H+150 )
	image:setFillColor (0/255,69/255,83/255)
	sceneGroup:insert( image )
	image.touch = onSceneTouch2
	
	local myGreatText = display.newText("You are great! :D", _W/2, _H/2-60, "Track", 30)
	sceneGroup:insert( myGreatText )
	
	local myText = "Next Level: ".._L.."\n\n".."Last level score: ".._G.."\n".."Total score: ".._P.."\n\n".."Tap to continue..."

	local options = {
	   text = myText,
	   x = _W/2,
	   y = _H/2+140,
	   width = 320,
	   height = 300,
	   font = "Track",
	   fontSize = 15,
	   align = "center"
	}
	
	textField = display.newText( options )
	textField:setFillColor( 1, 1, 1 )
	sceneGroup:insert( textField )

	
end

function scene:show( event )
	local phase = event.phase
	if "did" == phase then
	--purgeScene()
		composer.removeScene( "scene7" )
		
		
		
		textField.text = "Next Level: ".._L.."\n\n".."Last level score: ".._G.."\n".."Total score: ".._P.."\n\n".."Tap to continue..."
		image:addEventListener( "touch", image )
		
		
	end
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then
		image:removeEventListener( "touch", image )
		_G = 0
	end
	
end

function scene:destroy( event )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene