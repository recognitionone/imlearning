local composer = require( "composer" )
local scene = composer.newScene()
local score = require( "score" )

local scoreText = score.init({
   x = display.contentCenterX,
   y = -10,
   maxDigits = 3,
   leadingZeros = false,
   filename = "scorefile.txt",
})

local image, textRed

local _W = display.contentWidth
local _H = display.contentHeight



local function onSceneTouch2( self, event )
	if event.phase == "began" then		
		composer.gotoScene( "scene2", "fade", 400  )		
		return true
	end
end

local textField
local textScoreField

local bestscore

function scene:create( event )
	
	bestscore = score.get()
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
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if "did" == phase then
		composer.removeScene( "scene2" )
		
		image:addEventListener( "touch", image )
		image2:addEventListener( "touch", image2 )
		
		local myScoreText = "Your score: "..score.get()

		local optionsScore = {
		   text = myScoreText,
		   x = _W/2-90,
		   y = _H/2+30,
		   width = 320,
		   height = 300,
		   font = "Track",
		   fontSize = 20,
		   align = "left"
		}

		textScoreField = display.newText( optionsScore )
		textScoreField:setFillColor( 1, 1, 1 )
		sceneGroup:insert( textScoreField )
		
		
		local z = math.random(0,20)
		
		
		
		
		local myText = "small green balls are better than you"

		local options = {
		   text = myText,
		   x = _W/2-90,
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
				textField.text = "this game is really easy...\nmaybe you are just tired"
			elseif z > 1 and z <=2 then
				textField.text= "world is complicated and you don't even get these stupid balls"
			elseif z > 2 and z <=3 then
				textField.text= "there are more important things than some stupid game"
			elseif z > 3 and z <=4 then
				textField.text = "you probably fail at other things too"
			elseif z > 4 and z <=5 then
				textField.text = "small green balls are better than you..."
			elseif z > 5 and z <=6 then
				textField.text = "so, you lost everything - even this game"
			elseif z > 6 and z <=7 then
				textField.text = "it's ok, maybe next time..."
			elseif z > 7 and z <=8 then
				textField.text = "in entire multiversum\n there must be one universe\n where you are good at something"
			elseif z > 8 and z <=9 then
				textField.text = "it's time to order some pizza!"
			elseif z > 9 and z <=10 then
				textField.text = "most importantly:\nyou have to relax"
			elseif z > 10 and z <=11 then
				textField.text = "and you are sure you have nothing else to do?"
			elseif z > 11 and z <=12 then
				textField.text = "maybe just have a nap instead..."
			elseif z > 12 and z <=13 then
				textField.text = "naps are great, really"
			elseif z > 13 and z <=14 then
				textField.text = "pizza is also great, have some pizza"
			elseif z > 14 and z <=14 then
				textField.text = "love of your life is waiting for you \nand you are focusing on some bubbles..."
			elseif z > 15 and z <=14 then
				textField.text = "you can do better than this"	
			elseif z > 16 and z <=14 then
				textField.text = "what if you would put this game away and do something productive?"
			elseif z > 17 and z <=14 then
				textField.text = "I am disappointed only a little bit"
			elseif z > 18 and z <=14 then
				textField.text = "Really? This is all you've got?"
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
		textField.text = nil
		textScoreField.text = nil
		score.set(0)
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