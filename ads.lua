-----------------------------------------------------------------------------------------
--
-- ads.lua
--
-- 
-----------------------------------------------------------------------------------------
--Static instances of the ads class
local ads = {}

-- Required plugins for the file to function
local appodeal = require("plugin.appodeal")
local appKey

-- Determine which appKey should be use based on the platform
if platform == "android" then
    appKey = "insert your iOS keyword Here"
elseif platform == "ios" then
    appKey = "insert your andriod keyword here"
end

-- Set local variables
local availableAdTypes = {
	{ adUnitType="banner", label="Banner", xPos=103, yPos=110 }, -- ad type 1 
	{ adUnitType="interstitial", label="Interstitial", xPos=103, yPos=150 },-- ad type 2
  { adUnitType="rewardedVideo", label="Rewarded Video", xPos=250, yPos=150} --ad type 3
}

--  app event handler 
local function adListener(event)
    print("ads: adListener:addDid trigger listener event")
   
  -- Exit function if user hasn't set up testing parameters
	if ( setupComplete == false ) then return end
	
	-- Successful initialization of the Appodeal plugin
	if ( event.phase == "init" ) then
		print( "Appodeal event: initialization successful" ) 
    
       ads.showAd(1)
    -- An ad loaded successfully
	elseif ( event.phase == "loaded" ) then
		print( "Appodeal event: " .. tostring(event.type) .. " ad loaded successfully" )

    -- The ad was closed/hidden/completed
    elseif ( event.phase == "hidden" or event.phase == "closed" or event.phase == "playbackEnded" ) then
		print( "Appodeal event: " .. tostring(event.type) .. " ad closed/hidden/completed" )
    end
end 

--Check Test Mode before app submission
function ads.init()
    -- use supportedAdType after testMode, when not using all three ad types to prevent lowered fill rates 
    -- example appodeal.init( adListener, { appKey=appKey, testMode=true,--supportedAdTypes={"interstitial", "banner"} }) 
    appodeal.init( adListener, { appKey=appKey, testMode=true}) 
end

function ads.showAd(currentAdType)
    appodeal.show( availableAdTypes[currentAdType]["adUnitType"] )   
end
return ads
