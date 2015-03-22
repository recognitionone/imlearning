---------------------------------------------------
---game--------------------------------------------
---------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()
local score = require( "score" )
local level = require( "level" )

local physics = require "physics"
system.setIdleTimer( false )

physics.start()
physics.setGravity(0, -0.98)
physics.setDrawMode("normal")
physics.setPositionIterations( 16 )
physics.setVelocityIterations( 6 )
physics.setAverageCollisionPositions( true )
physics.setScale( 60 )
physics.setContinuous(true)


---------------------------------------------------
-------------------
---------------------------------------------------

local scoreText = score.init({
   x = display.contentCenterX,
   y = -1000,
   maxDigits = 3,
   leadingZeros = false,
   filename = "scorefile.txt",
})

local levelText = level.init({
   x = display.contentCenterX,
   y = -10,
   maxDigits = 3,
   leadingZeros = false,
   filename = "levelfile.txt",
})

---------------------------------------------------
---local variables---------------------------------
---------------------------------------------------

local _W = display.contentWidth
local _H = display.contentHeight

levelNum = level.get()

local lives = levelNum + 3
local circles = levelNum + 12
local numBalls = levelNum + 1
local filling = 0
local z = (_W-20)*(_H-20)

local myCircle, circlesGroup, background


---------------------------------------------------
---won game----------------------------------------
---------------------------------------------------

local function gameover(self, event)

			score.add(circles + lives)	
			
			composer.gotoScene( "scene3", {
			effect = "fade",
			time = 100,
			params = {
			numPoints = circles + lives
			}
			})
	
end

---------------------------------------------------
---lost game---------------------------------------
---------------------------------------------------

local function gameover2(self)		
		composer.gotoScene ("scene4", "fade", 400)
		return true
end

function startVelocityTimer()
	if setVelocityTimer == nil then
		setVelocityTimer = timer.performWithDelay(30, setVelocity, -1)
	end
end

function stopVelocityTimer()
	if setVelocityTimer ~= nil then
		timer.cancel(setVelocityTimer)
		setVelocityTimer = nil
	end
end	


function startMakeItBiggerTimer()
	if makeItBiggerTimer == nil then
		makeItBiggerTimer = timer.performWithDelay(10, makeItBigger, 1)
	end
end
	
function stopMakeItBiggerTimer()
	if makeItBiggerTimer ~= nil then
		
		timer.cancel(makeItBiggerTimer)
		makeItBiggerTimer = nil
	end
end	

function startGameoverTimerWin()
	if gameoverTimerWin == nil then
		gameoverTimerWin = timer.performWithDelay(30, gameover, -1)
	end
end

function stopGameoverTimerWin()
	if gameoverTimerWin ~= nil then
		timer.cancel(gameoverTimerWin)
		gameoverTimerWin = nil
	end
end	
	
function startGameoverTimerFail()
	if gameoverTimerFail == nil then
		gameoverTimerFail = timer.performWithDelay(30, gameover2, -1)
	end
end

function stopGameoverTimerFail()
	if gameoverTimerFail ~= nil then
		timer.cancel(gameoverTimerFail)
		gameoverTimerFail = nil
	end
end	

function removeCircle()
	if myCircle ~= nil then
		myCircle:removeSelf()
		myCircle = nil
	end
end

function removeCircles()
	if circlesGroup ~= nil then
		for i=1, circlesGroup.numChildren, 1 do
			circlesGroup[i]:removeSelf()
			circlesGroup = nil
		end
	end
end
		

---------------------------------------------------
---scene: create-----------------------------------
---------------------------------------------------

function scene:create( event )
	local sceneGroup = self.view
		
	background = display.newRect(_W/2, _H/2, _W, _H*2)
	background:setFillColor(0/255,137/255,166/255)
	sceneGroup:insert( background )

---------------------------------------------------
---walls-------------------------------------------
---------------------------------------------------

	local function newWall (params)
		local wall = display.newRect(params.xpos, params.ypos, params.width, params.height)	
		physics.addBody( wall, "static", {friction = 0, density = 200, bounce = 0})
		wall.alpha = 0
		sceneGroup:insert( wall )
		return wall
	end

	local params = {
		{xpos = _W/2, ypos = -200, width = _W, height = 440},
		{xpos = _W/2, ypos = _H+200, width = _W, height = 410},
		{xpos = -200, ypos = _H/2, width = 390, height = _H},
		{xpos = _W+200, ypos = _H/2, width = 390, height = _H},
	}

	local collection = {}
	for _, item in ipairs (params) do
		local wall = newWall(item)	
		collection[#collection + 1] = wall
	end

---------------------------------------------------
---texts-------------------------------------------
---------------------------------------------------
	
	local myText = display.newText( "Lives: "..lives, 60, 10, "Track", 14 )
	myText:setFillColor( 0, 0, 0 )
	sceneGroup:insert( myText )

	local myFillingText = display.newText( "Filling: "..(string.format("%.0f", filling)).."%", 400, 12, "Track", 14 )
	myFillingText:setFillColor( 0, 0, 0 )
	sceneGroup:insert( myFillingText )

	local levelText = display.newText("Level: "..levelNum, 160, 10, "Track", 14)
	levelText:setFillColor(0,0,0)
	sceneGroup:insert(levelText)

	local circlesText = display.newText("Circles: "..circles, 270, 10, "Track", 14)
	circlesText:setFillColor(0,0,0)
	circlesText.align = "left"
	sceneGroup:insert(circlesText)

	myFillingText:toFront()
	myText:toFront()
	levelText:toFront()
	circlesText:toFront()

---------------------------------------------------
---creating blue balls-----------------------------
---------------------------------------------------


	local myCircle

	function onLocalCollision( self, event )
		if myCircle ~= nil then
			if ( event.phase == "began" ) then
				if (event.other.name == "mc") then
					
					self:removeSelf()
					myCircle = nil
					lives = lives - 1
					
					if lives <= 0 then
						myText.text = "Game over"
						level.set(1)
												
						stopMakeItBiggerTimer()						
						stopVelocityTimer()				
						startGameoverTimerFail()
						
					else
					
						myText.text = "Lives: "..lives
						
					end
				else					
				
					stopGrowing()
					removeCircle()
				end		
			end
		end
	end

	circlesGroup = display.newGroup()
	
	function circleGenerator( event)		
		if event.phase == "began" then		
			
			myCircle = display.newImageRect("circleblue.png", 10, 10, 10, 20)
			myCircle.collision = onLocalCollision	
			myCircle:addEventListener( "collision", myCircle)		
			myCircle.x = event.x
			myCircle.y = event.y	

			myCircle.anchorX = 0.5
			myCircle.anchorY = 0.5			
			
			myCircle.gravityScale = 0	
			myCircle.name = "myC"	
			physics.addBody(myCircle, "dynamic", {friction = 0, density = 300, bounce = 0.3, radius = myCircle.contentWidth/2})	
			
			startMakeItBiggerTimer()
		elseif event.phase == "moved" then
		
			if myCircle ~= nil then
			
				myCircle.x = event.x
				myCircle.y = event.y
				
			end
			
		elseif event.phase == "ended" then	
			stopMakeItBiggerTimer()
			stopGrowing()
			removeCircle()
		end
		return true
	end
---------------------------------------------------
---creating green balls----------------------------
---------------------------------------------------


	local function newMovingCircle (params1)
	
		local movingCircle = display.newCircle( params1.xpos, params1.ypos, 10)
		physics.addBody(movingCircle, "dynamic", { friction = 0, density = 0.001, bounce = 1,radius = movingCircle.contentWidth/2})
		movingCircle.gravityScale = 0
		movingCircle:setLinearVelocity( math.random(-130, 130), math.random(-130, 130))
		movingCircle:setFillColor(0.3, 1, 0.3)
		movingCircle.name = "mc"
		
		return movingCircle
	end


	local groupOfBalls = display.newGroup()
	sceneGroup:insert( groupOfBalls )
	
	local collection1 = {} 
	for  i = 1,numBalls,1 do	
		local movingCircle = newMovingCircle({xpos = _W/2+math.random(-130,130), ypos = _H/2+math.random(-130,130), xmove = 0.5, ymove = 0.5})
		collection1[#collection1 + 1] = movingCircle
		groupOfBalls:insert(movingCircle)
	end


	function setVelocity(event)	
		for  i = 1,numBalls,1 do	
			
			local vx, vy = collection1[i]:getLinearVelocity()
			collection1[i]:setLinearVelocity((167/math.sqrt((vx*vx)+(vy*vy))*vx), (167/math.sqrt((vx*vx)+(vy*vy))*vy))
			
		end	
	end

	
---------------------------------------------------
---process of making blue circles bigger-----------
---------------------------------------------------


	function makeItBiggerStage0(event)
		if myCircle ~= nil then					
			myCircle:scale(1.5, 1.5)
			makeItBigger1()
		end
	end
	
	function makeItBiggerStage1(event)
		if myCircle ~= nil then					
			myCircle:scale(1.02, 1.02)
			makeItBigger1()
		end
	end
	
	function makeItBiggerStage2(event)
		if myCircle ~= nil then					
			myCircle:scale(1.01, 1.01)
			makeItBigger1()
		end
	end
	function makeItBiggerStage3(event)
		if myCircle ~= nil then					
			myCircle:scale(1.005, 1.005)
			makeItBigger1()
		end
	end
	
	function makeItBigger(event)
			timer.performWithDelay(20, makeItBiggerStage0, 3)
			timer.performWithDelay(20, makeItBiggerStage1, 20)
			timer.performWithDelay(20, makeItBiggerStage2, 100)
			timer.performWithDelay(20, makeItBiggerStage3, 1000)
	end
	
	function makeItBigger1(event)
		if myCircle ~= nil then					
			
			physics.removeBody(myCircle)
			physics.addBody(myCircle, "static", {friction = 0, density = 320, bounce = 0.2, radius = myCircle.contentWidth/2})
			
			
			if (myCircle.x < myCircle.contentWidth/2) then
				myCircle.x = myCircle.contentWidth/2 + 1
			end
			if (myCircle.x > _W-myCircle.contentWidth/2) then
				myCircle.x = _W-myCircle.contentWidth/2 - 1
			end
			if (myCircle.y < myCircle.contentWidth/2+20) then
				myCircle.y = myCircle.contentWidth/2 + 21
			end
			if (myCircle.y > _H-myCircle.contentWidth/2) then
				myCircle.y = _H-myCircle.contentWidth/2 - 1
			end
		end
	end
	
---------------------------------------------------
---blue circles stop growing-----------------------
---------------------------------------------------

	function stopGrowing()		
			timer.performWithDelay(1, function ()
				if myCircle ~= nil then
                                        myCircle.bodyType = "static"

                                        local theCircle = myCircle
                                        timer.performWithDelay(10,
                                                               function ()
                                                                  theCircle.bodyType = "dynamic"
                                                               end, 1)

					myCircle.gravityScale = 27
					circlesGroup:insert(myCircle)		
					sceneGroup:insert( myCircle )
					myCircle:removeEventListener( "collision", myCircle)
					circles = circles - 1
					circlesText.text = "Circles: "..circles
					stopMakeItBiggerTimer()
					
					if (circles) <= 0 then
						circlesText.text = "Game over"
						level.set(1)
						
						stopVelocityTimer()
						startGameoverTimerFail()
					end
					
					filling = filling + (myCircle.contentWidth/2)*(myCircle.contentWidth/2)*3.14
					if (z/filling) <= 1.5 then
						myFillingText.text = "You Won"
						
						level.add(1)
											
						stopVelocityTimer()
						startGameoverTimerWin()								
					else					
						myFillingText.text = "Filling: "..(string.format("%.0f", (filling/z*100))).."%"
					end
					
					myCircle = nil	
							
				end
			end, 1)		
		end	
			
---------------------------------------------------
---timers: starts and stops------------------------
---------------------------------------------------			

	background:addEventListener("touch", circleGenerator)
		startVelocityTimer()
	

	
end



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if "did" == phase then
		composer.removeScene( "scene1" )

	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if "will" == phase then
		collection1 = {}
		groupOfBalls = nil
		score.save()
		removeCircle()
		removeCircles()
		stopGameoverTimerWin()
		stopGameoverTimerFail()
		stopMakeItBiggerTimer()
		stopVelocityTimer()
		background:removeEventListener("touch", circleGenerator)
		
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	removeCircles()
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
