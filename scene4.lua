local composer = require( "composer" )
local scene = composer.newScene()
composer.recycleOnSceneChange = true


local image, textRed

local _W = display.contentWidth
local _H = display.contentHeight


local function onSceneTouch2( self, event )
	if event.phase == "began" then		
		composer.gotoScene( "scene2", "fade", 100  )		
		return true
	end
end

local function onSceneTouch3( self, event )
	if event.phase == "began" then		
			native.requestExit()				
	end
end

local textField
local textScoreField

local bestscore

function scene:create( event )

	local sceneGroup = self.view
	
	image = display.newCircle( _W/2-60, _H/2, _H )
	image:setFillColor(0/255,137/255,166/255)
	sceneGroup:insert( image )
	image.touch = onSceneTouch2
	

		
	image2 = display.newCircle( _W/2+140, _H/2+70, 80 )
	image2:setFillColor(3/255,212/255,1)
	sceneGroup:insert( image2 )
	image2.touch = onSceneTouch2
	textRed = display.newText("Play again", _W/2+140, _H/2+70, "Track", 20)
	sceneGroup:insert( textRed )
	
		
	image3 = display.newCircle( _W/2+160, _H/2-80, 30 )
	image3:setFillColor(0.3, 1, 0.3)
	sceneGroup:insert( image3 )
	image3.touch = onSceneTouch3
	textRed3 = display.newText("Exit", _W/2+160, _H/2-80, "Track", 10)
	sceneGroup:insert( textRed3 )
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if "did" == phase then
		composer.removeScene( "scene2" )
		
		image:addEventListener( "touch", image )
		image2:addEventListener( "touch", image2 )
		image3:addEventListener( "touch", image3 )
		
		local myScoreText = "Your score: ".._P

		local optionsScore = {
		   text = myScoreText,
		   x = _W/2-60,
		   y = _H/2+30,
		   width = 320,
		   height = 300,
		   font = "Track",
		   fontSize = 10,
		   align = "left"
		}

		textScoreField = display.newText( optionsScore )
		textScoreField:setFillColor( 1, 1, 1 )
		sceneGroup:insert( textScoreField )
				
		local z = math.random(0,21)
		
		local myText = "small green balls are better than you"

		local options = {
		   text = myText,
		   x = _W/2-60,
		   y = _H/2+130,
		   width = 320,
		   height = 300,
		   font = "Track",
		   fontSize = 20,
		   align = "left"
		}

		textField = display.newText( options )
		textField:setFillColor( 1, 1, 1 )
		sceneGroup:insert( textField )
		
		
		
		
		if textField ~= nil then
			if z <= 1 then
				textField.text = "This game is really easy...\nmaybe you are just tired"
			elseif z > 1 and z <=2 then
				textField.text= "World is so complicated and you don't even get these stupid balls"
			elseif z > 2 and z <=3 then
				textField.text= "There are more important things than this stupid game"
			elseif z > 3 and z <=4 then
				textField.text = "You probably fail at other things too"
			elseif z > 4 and z <=5 then
				textField.text = "Small green balls are better than you..."
			elseif z > 5 and z <=6 then
				textField.text = "So, you lost everything - even this game"
			elseif z > 6 and z <=7 then
				textField.text = "Maybe next time..."
			elseif z > 7 and z <=8 then
				textField.text = "There must be some universe where you are good at something"
			elseif z > 8 and z <=9 then
				textField.text = "It's time to order some pizza!"
			elseif z > 9 and z <=10 then
				textField.text = "But most importantly:\nyou have to relax"
			elseif z > 10 and z <=11 then
				textField.text = "Are you sure you have nothing else to do?"
			elseif z > 11 and z <=12 then
				textField.text = "maybe just have a nap instead..."
			elseif z > 12 and z <=13 then
				textField.text = "Naps are great, really"
			elseif z > 13 and z <=14 then
				textField.text = "Pizza is also great idea! Have some pizza"
			elseif z > 14 and z <=14 then
				textField.text = "Love of your life is waiting for you \nand you are focusing on some bubbles..."
			elseif z > 15 and z <=16 then
				textField.text = "you can do better than this"	
			elseif z > 16 and z <=17 then
				textField.text = "What if you would do something productive?"
			elseif z > 17 and z <=18 then
				textField.text = "I am disappointed only a little bit"
			elseif z > 18 and z <=19 then
				textField.text = "Really? This is all you've got?"
			elseif z > 19 and z <=20 then
				textField.text = "There, there..."
			else
				textField.text = "maybe drink your water and then start again"
			end
		end
	end
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then
		image:removeEventListener( "touch", image )
		image2:removeEventListener( "touch", image2 )
		image3:removeEventListener( "touch", image3 )
		
		textField.text = nil
		textScoreField.text = nil
		
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