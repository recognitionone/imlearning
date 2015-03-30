local composer = require( "composer" )
local scene = composer.newScene()

composer.recycleOnSceneChange = true

local _W = display.contentWidth
local _H = display.contentHeight

local function onSceneTouchNormal( self, event )
	if event.phase == "began" then		
		composer.gotoScene( "scene2", "fade", 100  )		
		return true
	end
end

local function onSceneTouchBaby( self, event )
	if event.phase == "began" then		
		composer.gotoScene( "scene5", "fade", 100  )		
		return true
	end
end

local function onSceneTouchHardcore( self, event )
	if event.phase == "began" then		
		composer.gotoScene( "scene7", "fade", 100  )		
		return true
	end
end

local function onSceneTouchTrueHardcore( self, event )
	if event.phase == "began" then		
		composer.gotoScene( "scene9", "fade", 100  )		
		return true
	end
end


local backgroundCircle
local imageBlue
local imageGreen

function scene:create( event )
	local sceneGroup = self.view
	
	backgroundCircle = display.newCircle( _W/2-100, _H/2, _H+50 )
	backgroundCircle:setFillColor(0/255,137/255,166/255)
	sceneGroup:insert( backgroundCircle )
	backgroundCircle.touch = onSceneTouchNormal
	
	local textbackgroundCircle = display.newText("Tap to start...", _W/2-100, _H/2, "Track", 30)
	sceneGroup:insert(textbackgroundCircle)

	imageBaby = display.newCircle( _W - 90, _H/4-_H/8, _H/8-5 )
	imageBaby:setFillColor(245/255,31/255,103/255)
	sceneGroup:insert( imageBaby )
	imageBaby.touch = onSceneTouchBaby
	local imageBabyText = display.newText("Baby mode", _W - 90, _H/4-_H/8, "Track", 15)
	sceneGroup:insert( imageBabyText )
	
	imageNormal = display.newCircle( _W - 90, _H/4+_H/8, _H/8-4 )
	imageNormal:setFillColor(0/255,206/255,249/255)
	sceneGroup:insert( imageNormal )
	imageNormal.touch = onSceneTouchNormal
	local imageNormalText = display.newText("Normal mode", _W - 90, _H/4+_H/8, "Track", 15)
	sceneGroup:insert( imageNormalText )
	
	imageHardcore = display.newCircle( _W - 90, _H/2+_H/8, _H/8-6 )
	imageHardcore:setFillColor(0/255,69/255,83/255)
	sceneGroup:insert( imageHardcore )
	imageHardcore.touch = onSceneTouchHardcore
	local imageHardcoreText = display.newText("Hardcore mode", _W - 90, _H/2+_H/8, "Track", 15)
	sceneGroup:insert( imageHardcoreText )
	
	imageTrueHardcore = display.newCircle( _W - 90, _H-_H/8, _H/8-3 )
	imageTrueHardcore:setFillColor(0/255,35/255,41/255)
	sceneGroup:insert( imageTrueHardcore )
	imageTrueHardcore.touch = onSceneTouchTrueHardcore
	local imageTrueHardcoreText = display.newText("True Hardcore mode", _W - 90, _H-_H/8, "Track", 15)
	sceneGroup:insert( imageTrueHardcoreText )
	
	
end

function scene:show( event )
local sceneGroup = self.view
	local phase = event.phase
	if "did" == phase then
		composer.removeScene( "scene4" )	
		
		backgroundCircle:addEventListener( "touch", backgroundCircle )		
		imageBaby:addEventListener("touch", imageBaby)
		imageNormal:addEventListener("touch", imageNormal)
		imageHardcore:addEventListener("touch", imageHardcore)
		imageTrueHardcore:addEventListener("touch", imageTrueHardcore)
		
		_G = 0 --local points
		_P = 0 --total points
		_L = 1 --levels
		_O = 0 --babymode local points
	end
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then
		backgroundCircle:removeEventListener( "touch", backgroundCircle )		
		imageBaby:removeEventListener("touch", imageBaby)
		imageNormal:removeEventListener("touch", imageNormal)
		imageHardcore:removeEventListener("touch", imageHardcore)
		imageTrueHardcore:removeEventListener("touch", imageTrueHardcore)
		
		backgroundCircle:removeSelf()
			
		imageBaby:removeSelf()
		imageNormal:removeSelf()
		imageHardcore:removeSelf()
		imageTrueHardcore:removeSelf()
	end
end

function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene