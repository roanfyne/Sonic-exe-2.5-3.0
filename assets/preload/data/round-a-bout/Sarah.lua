local animTime = 0
local singAnim = {'singLEFT','singDOWN','singUP','singRIGHT'}
local animOffset = {{-190,-100},{-60,-195},{-40,-118},{-208,-70},{-40,-214}}
function onCreatePost()
    makeAnimatedLuaSprite('SarahCharacter','characters/Sarah',-50,-120)
    setProperty('SarahCharacter.alpha',0.001)
    scaleObject('SarahCharacter',1.2,1.2)
    addAnimationByPrefix('SarahCharacter','idle','Sarah_IDLE',24,false)
    addAnimationByPrefix('SarahCharacter','singLEFT','Sarah_IDLE',24,false)
    addAnimationByPrefix('SarahCharacter','singDOWN','Sarah_DOWN',24,false)
    addAnimationByPrefix('SarahCharacter','singUP','Sarah_UP',24,false)
    addAnimationByPrefix('SarahCharacter','singRIGHT','Sarah_RIGHT',24,false)
    addLuaSprite('SarahCharacter',false)
end
function onUpdate()
    debugPrint(animOffset[0])
    --[[for number,#animOffset in pairs(animOffset) do
        debugPrint(number)
    end]]--

    if animTime > 0.1 then
        animTime = animTime - 0.1
    end
    if animTime == 0.1 then
        objectPlayAnimation('SarahCharacter','idle',true)
        animTime = 0
    end
end
function opponentNoteHit(noteId,Notedata)
    objectPlayAnimation('SarahCharacter',singAnim[Notedata + 1],true)
    animTime = 4
end
function onStepHit()
    if curStep == 764 then
        doTweenAlpha('helloSarah','SarahCharacter',0.7,0.5,'linear')
    end
end
function onBeatHit()
    if curBeat % 2 == 0 then
        objectPlayAnimation('SarahCharacter','idle',false)
    end
end
