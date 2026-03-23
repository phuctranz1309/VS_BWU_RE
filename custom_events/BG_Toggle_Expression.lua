-- Biến này để ghi nhớ trạng thái toàn cục của nhóm nữ sinh
local isSad = false

function onEvent(name, value1, value2)
    -- Kiểm tra nếu đúng tên Event cậu đặt trong Chart
    if name == 'BG_Toggle_Expression' then
        if isSad == false then
            -- Nếu đang bình thường (false) -> Chuyển sang buồn
            objectPlayAnim('bgFreaks', 'sad', true);
            isSad = true;
        else
            -- Nếu đang buồn (true) -> Chuyển về nhảy bình thường
            objectPlayAnim('bgFreaks', 'dance', true);
            isSad = false;
        end
    end
end