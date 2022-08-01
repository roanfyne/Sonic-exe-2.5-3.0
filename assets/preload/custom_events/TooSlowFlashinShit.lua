function onCreate()
    makeAnimatedLuaSprite('FlashingShit','daSTAT',0,0)
    addAnimationByPrefix('FlashingShit','glitch','staticFLASH',24,true)
    setProperty('FlashingShit.alpha',0.6)
    scaleObject('FlashingShit',3.2,2.45)
    setObjectCamera('FlashingShit','other')
end

function onEvent(name,v1)
    if name == 'TooSlowFlashinShit' then
        addLuaSprite('FlashingShit',true)
        playSound('simplejumpsound')
        if tonumber(v1) ~= nil then
            runTimer('destroyFlashShit',v1)
        else
            runTimer('destroyFlashShit',0.3)
        end
    end
end
function onTimerCompleted(tag)
    if tag == 'destroyFlashShit' then
        removeLuaSprite('FlashingShit',false)
    end
end