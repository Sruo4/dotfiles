
-- 定义一个函数，将所有窗口移动到主屏幕
function moveAllWindowsToMainScreen()
    local screen = hs.screen.primaryScreen() -- 获取主屏幕
    local screenFrame = screen:frame()       -- 获取主屏幕的尺寸和位置

    -- 获取所有窗口
    local allWindows = hs.window.allWindows()

    for _, window in ipairs(allWindows) do
        -- 将窗口移动到主屏幕
        window:moveToScreen(screen)
        -- 将窗口设置为全屏
    end
end

-- 绑定快捷键（Cmd + Ctrl + M）来触发上述函数
hs.hotkey.bind({"cmd", "ctrl"}, "M", moveAllWindowsToMainScreen)


-- 创建一个菜单项
local menu = hs.menubar.new()
menu:setTitle("⚒︎")

-- 添加菜单项
menu:setMenu({
    { title = "Move Windows to Main Screen", fn = moveAllWindowsToMainScreen },
    { title = "Reload Config", fn = hs.reload },
    { title = "Quit", fn = hs.quit },
})
