local doDialogue = true
local allowCountdown = false

function onStartCountdown()
    -- Nếu đã cho phép countdown chạy (sau khi xong dialogue)
    if allowCountdown then
        return Function_Continue
    end

    -- Kích hoạt delay 3s và nhạc
    if doDialogue and not seenCutscene and isStoryMode then
        playMusic('breakfast-(pixel)', 1, true)
        runTimer('startDialogueDelay', 3)
        doDialogue = false
        return Function_Stop
    end

    -- Chặn countdown cho đến khi dialogue kết thúc
	return Function_Continue
end

function onTimerCompleted(tag)
    if tag == 'startDialogueDelay' then
        startDialogue('dialogue')
    end
end

-- Hàm này cực kỳ quan trọng: chạy khi bạn bấm hết dialogue
function onDialogueComplete()
    allowCountdown = true
    startCountdown() -- Gọi lại countdown để vào game
end