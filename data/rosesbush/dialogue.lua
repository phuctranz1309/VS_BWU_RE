local doDialogue = true
local allowCountdown = false
local isEnding = false -- Biến để kiểm tra xem có phải đang ở cuối bài không

function onStartCountdown()
    -- Nếu đã cho phép countdown chạy (sau khi xong dialogue đầu bài)
    if allowCountdown then
        return Function_Continue
    end

    -- Kích hoạt delay 2s và nhạc cho đầu bài
    if doDialogue and not seenCutscene then
        playMusic('Lunchbox', 0, false)
        runTimer('startDialogueDelay', 2)
        doDialogue = false
        return Function_Stop
    end

    return Function_Continue
end

function onTimerCompleted(tag)
    if tag == 'startDialogueDelay' then
        startDialogue('dialogue') -- Chạy file dialogue.json mặc định
    elseif tag == 'finishSongFade' then
        -- Sau khi fade xong thì mới kết thúc bài thực sự
        endSong()
    end
end

-- ==========================================================
-- LOGIC CHẠY DIALOGUE KHI HẾT BÀI
-- ==========================================================
function onEndSong()
    if not isEnding then
        isEnding = true
        
        -- ẨN CÁC THÀNH PHẦN LẺ CỦA HUD (Để giữ lại Dialogue sạch sẽ)
        setProperty('healthBar.visible', false)
        setProperty('healthBarBG.visible', false)
        setProperty('iconP1.visible', false)
        setProperty('iconP2.visible', false)
        setProperty('scoreTxt.visible', false)
        setProperty('timeBar.visible', false)
        setProperty('timeBarBG.visible', false)
        setProperty('timeTxt.visible', false)
        setProperty('strumLineNotes.visible', false) 
        
        startDialogue('end_dialogue') 
        return Function_Stop 
    end
    return Function_Continue
end

-- ==========================================================
-- HÀM XỬ LÝ KHI BẤM HẾT DIALOGUE
-- ==========================================================
function onDialogueComplete()
    if isEnding then
        -- BẮT ĐẦU FADE TỪ TỪ KHI HẾT CHỮ
        cameraFade('game', '000000', 1, true)  -- Fade màn hình game
        cameraFade('hud', '000000', 1, true)   -- Fade các thứ trên HUD
        cameraFade('other', '000000', 1, true) -- Fade cả cái hộp thoại luôn
        
        -- Chờ 1.1 giây (để kịp nhìn thấy màn hình đen hẳn) rồi mới thoát
        runTimer('finishSongFade', 1.1)
    else
        -- Nếu là đầu bài thì cho phép countdown vào game như cũ
        allowCountdown = true
        startCountdown() 
    end
end