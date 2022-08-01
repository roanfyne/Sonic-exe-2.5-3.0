local changedImage = false
function onCreate()
        if string.lower(songName) ~= 'sanic' and
        string.lower(songName)  ~= 'chaos'  and
        string.lower(songName)  ~= 'soulless-nikocover' and
        string.lower(songName)  ~= 'soulless-orycover' and
        string.lower(songName)  ~= 'soulless' and
        string.lower(songName)  ~= 'fatality' and
        string.lower(songName)  ~= 'too-slow-encore' and
        string.lower(songName)  ~= 'endless-encore' and
        string.lower(songName)  ~= 'sunshine' and
        string.lower(songName)  ~= 'milk' and
        string.lower(songName)  ~= 'too-fest' and
        string.match(string.lower(songName),'milk') ~= 'milk' and
        string.lower(songName)  ~= 'cycles-encore' then
        startSonicCount(string.lower(songName))
        elseif string.lower(songName)  == 'cycles-encore' then
            startSonicCount('cycles')
        elseif string.lower(songName)  == 'too-slow-encore' then
            startSonicCount('too-slow')
        elseif string.lower(songName)  == 'endless-encore' then
        startSonicCount('endless')
        elseif string.lower(songName) == 'fatality' then
            changeCountDown('-Fatal','StartScreens/fatal_',true,true)
        elseif string.lower(songName) == 'sunshine' then
            changeCountDown('-Tails','',true,false)
        elseif string.match(string.lower(songName),'milk') == 'milk' then
            milkCountDown('milk')
        end
end
function startSonicCount(name)
    if string.match(name, " ") ~= nil then
        name = string.gsub(name," ","-")
    end
    setProperty('introSoundsSuffix','-silence')
    makeLuaSprite('blackScreenSonicCount','',0,0)
    setObjectCamera('blackScreenSonicCount','other')
    makeGraphic('blackScreenSonicCount',screenWidth,screenHeight,'000000')
    addLuaSprite('blackScreenSonicCount',true)
    makeLuaSprite('startCircle','StartScreens/Circle-'..name,800,00)
    setObjectCamera('startCircle','other')
    addLuaSprite('startCircle',true)
    makeLuaSprite('startText','StartScreens/Text-'..name,-800,00)
    setObjectCamera('startText','other')
    addLuaSprite('startText',true)
    setObjectCamera('startText','other')
    addLuaSprite('startText',true)
    runTimer('tweenWow',0.2)
    runTimer('tween2',getPropertyFromClass('Conductor','crochet')/ 1000 * 5)
end
function milkCountDown(name)
    if string.match(name, " ") ~= nil then
        name = string.gsub(name," ","-")
    end
    setProperty('introSoundsSuffix','-silence')
    makeLuaSprite('blackScreenSonicCount','',0,0)
    setObjectCamera('blackScreenSonicCount','other')
    makeGraphic('blackScreenSonicCount',screenWidth,screenHeight,'000000')
    addLuaSprite('blackScreenSonicCount',true)
    makeLuaSprite('startCircle','StartScreens/Circle-'..name,0,00)
    setProperty('startCircle.scale.x',0)
    setObjectCamera('startCircle','other')
    addLuaSprite('startCircle',true)
    runTimer('tweenMajin',0.2)
end
function onTimerCompleted(tag)
    if tag == 'tweenWow' then
        doTweenX('circleX','startCircle',0,0.6,'quartOut')
        doTweenX('textX','startText',0,0.6,'quartOut')
        --doTweenX('circleX','startCircle',0,0.7,'linear')
        --doTweenX('textX','startText',0,0.7,'linear')
    end
    if tag == 'tweenMajin' then
        doTweenX('circleX','startCircle.scale',1,0.4,'bounceOut')
        --doTweenX('circleX','startCircle',0,0.7,'linear')
        --doTweenX('textX','startText',0,0.7,'linear')
    end
    if tag == 'tween2' then
        --doTweenX('circleX','startCircle',-900,0.7,'quartOut')
        --doTweenX('textX','startText',1200,0.7,'quartOut')
        doTweenAlpha('blackScreenDestroy','blackScreenSonicCount',0,0.5,'linear')
        runTimer('tweenCircle',0.5)
    end
    if tag == 'tweenCircle' then
        doTweenAlpha('circleDestroy','startCircle',0,0.5,'linear')
        doTweenAlpha('textDestroy','startText',0,0.5,'linear')
    end
end
function onCountdownTick(counter)
    if changedImage == true then
        if counter > 0 then
            addLuaSprite('customIntro'..counter)
            doTweenAlpha('byeIntro'..counter,'customIntro'..counter)
            if counter == 1 then
                setProperty('countdownReady.visible',false)
                doTweenAlpha('byeReady','customIntro'..counter,0,0.5,'linear')
            elseif counter == 2 then
                setProperty('countdownSet.visible',false)
                doTweenAlpha('byeSet','customIntro'..counter,0,0.5,'linear')
                removeLuaSprite('customIntro'..counter - 1,true)
            elseif counter == 3 then
                setProperty('countdownGo.visible',false)
                doTweenAlpha('byeGo','customIntro'..counter,0,0.5,'linear')
                removeLuaSprite('customIntro'..counter -1,true)
            end
        end
    end
end
function changeCountDown(name,image,changeSong,changeImage)
    if changeSong == true then
        setProperty('introSoundsSuffix',name)
    end
    if changeImage == true then
        changedImage = true
        for countDown = 1,2 do
            makeLuaSprite('customIntro'..countDown,image..countDown,200,200)
            setObjectCamera('customIntro'..countDown,'hud')
        end
        makeLuaSprite('customIntro3',image..'go')
        setObjectCamera('customIntro3','hud')
    end
end
function onTweenCompleted(tag)
    if tag == 'circleDestroy' then
        removeLuaSprite('startCircle',true)
        removeLuaSprite('startText',true)
        removeLuaSprite('blackScreenSonicCount',true)
    end
end