--[[
    Zemvar UI  (our own executor interface)
    Loaded by the Zemvar executor loader in place of the original Delta UI.
    Self-contained: standard executor + Roblox APIs only.
--]]

repeat task.wait(0.1) until game:IsLoaded()

local okInit, initErr = pcall(function()

local Players    = game:GetService("Players")
local UIS        = game:GetService("UserInputService")
local Tween      = game:GetService("TweenService")
local LogService = game:GetService("LogService")

-- ---------------------------------------------------------------------------
-- environment helpers (executor APIs with safe fallbacks)
-- ---------------------------------------------------------------------------
local function call(name, ...)
    local f = nil
    if type(getgenv) == "function" then
        local ok, g = pcall(getgenv)
        if ok and type(g) == "table" then f = g[name] end
    end
    if type(f) ~= "function" then f = _G[name] end
    if type(f) ~= "function" then
        local ok, v = pcall(rawget, _G, name)
        if ok then f = v end
    end
    if type(f) == "function" then
        local ok, a, b, c = pcall(f, ...)
        if ok then return a, b, c end
    end
    return nil
end

local function env()
    if getgenv then
        local ok, g = pcall(getgenv)
        if ok and type(g) == "table" then return g end
    end
    return _G
end

local G = env()

-- ---------------------------------------------------------------------------
-- theme
-- ---------------------------------------------------------------------------
local C = {
    bg      = Color3.fromRGB(14, 15, 21),
    panel   = Color3.fromRGB(22, 24, 33),
    panel2  = Color3.fromRGB(29, 32, 43),
    panel3  = Color3.fromRGB(37, 41, 55),
    accent  = Color3.fromRGB(126, 87, 255),
    accent2 = Color3.fromRGB(56, 199, 255),
    text    = Color3.fromRGB(232, 236, 245),
    sub     = Color3.fromRGB(148, 156, 172),
    ok      = Color3.fromRGB(74, 222, 148),
    err     = Color3.fromRGB(255, 92, 108),
    warn    = Color3.fromRGB(255, 196, 84),
}

local FONT       = Enum.Font.Gotham
local FONT_BOLD  = Enum.Font.GothamBold
local FONT_MONO  = Enum.Font.Code

local VERSION = "1.0.0"

-- ---------------------------------------------------------------------------
-- root gui
-- ---------------------------------------------------------------------------
local function parentFor(gui)
    local hui = call("gethui")
    if hui then return hui end
    local pg = Players.LocalPlayer and Players.LocalPlayer:FindFirstChild("PlayerGui")
    if pg then return pg end
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    if ok and cg then return cg end
    error("no gui parent available")
end

local gui = Instance.new("ScreenGui")
gui.Name = "ZemvarUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
gui.Parent = parentFor(gui)

-- ---------------------------------------------------------------------------
-- console model
-- ---------------------------------------------------------------------------
local consoleLines = {}
local MAX_LINES = 400
local consoleDirty = false

local function now()
    return os.date("%H:%M:%S")
end

local function pushConsole(text, kind)
    consoleLines[#consoleLines + 1] = { t = now(), s = tostring(text), k = kind or "info" }
    while #consoleLines > MAX_LINES do table.remove(consoleLines, 1) end
    consoleDirty = true
end

-- ---------------------------------------------------------------------------
-- ui construction helpers
-- ---------------------------------------------------------------------------
local function mk(class, props, parent)
    local o = Instance.new(class)
    for k, v in pairs(props) do
        if k ~= "Parent" then o[k] = v end
    end
    if parent then o.Parent = parent end
    return o
end

local function corner(parent, r)
    return mk("UICorner", { CornerRadius = UDim.new(0, r or 8) }, parent)
end

local function stroke(parent, col, th)
    return mk("UIStroke", { Color = col or C.panel3, Thickness = th or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, parent)
end

local function label(parent, text, size, col, font)
    return mk("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextSize = size or 14,
        TextColor3 = col or C.text,
        Font = font or FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
    }, parent)
end

local function button(parent, text, w, h)
    local b = mk("TextButton", {
        BackgroundColor3 = C.panel3,
        AutoButtonColor = true,
        Text = text,
        TextSize = 13,
        Font = FONT_BOLD,
        TextColor3 = C.text,
        Size = UDim2.new(0, w, 0, h or 30),
    }, parent)
    corner(b, 7)
    return b
end

-- ---------------------------------------------------------------------------
-- main window
-- ---------------------------------------------------------------------------
local W, H = 520, 380
local win = mk("Frame", {
    Name = "Main",
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
    Size = UDim2.new(0, W, 0, H),
    Position = UDim2.new(0.5, -W / 2, 0.5, -H / 2),
    ClipsDescendants = false,
}, gui)
corner(win, 12)
stroke(win, C.panel3, 1)

-- header --------------------------------------------------------------------
local header = mk("Frame", {
    Name = "Header",
    BackgroundColor3 = C.panel2,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 44),
}, win)
corner(header, 12)
mk("Frame", {
    BackgroundColor3 = C.panel2,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 16),
    Position = UDim2.new(0, 0, 1, -16),
}, header)

local accentBar = mk("Frame", {
    BackgroundColor3 = C.accent,
    BorderSizePixel = 0,
    Size = UDim2.new(0, 4, 0, 24),
    Position = UDim2.new(0, 12, 0, 10),
}, header)
corner(accentBar, 2)

local title = label(header, "ZEMVAR", 18, C.text, FONT_BOLD)
title.Position = UDim2.new(0, 24, 0, 6)
title.Size = UDim2.new(0, 160, 0, 20)

local subtitle = label(header, "executor  ·  v" .. VERSION, 11, C.sub, FONT)
subtitle.Position = UDim2.new(0, 24, 0, 25)
subtitle.Size = UDim2.new(0, 200, 0, 14)

local statusDot = mk("Frame", {
    BackgroundColor3 = C.ok,
    BorderSizePixel = 0,
    Size = UDim2.new(0, 8, 0, 8),
    Position = UDim2.new(1, -108, 0, 18),
}, header)
corner(statusDot, 4)

local statusLbl = label(header, "ready", 11, C.ok, FONT_BOLD)
statusLbl.Position = UDim2.new(1, -96, 0, 12)
statusLbl.Size = UDim2.new(0, 60, 0, 20)

local minBtn = button(header, "—", 26, 24)
minBtn.Position = UDim2.new(1, -40, 0, 10)
corner(minBtn, 6)

-- tab bar -------------------------------------------------------------------
local tabBar = mk("Frame", {
    Name = "Tabs",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -24, 0, 30),
    Position = UDim2.new(0, 12, 0, 52),
}, win)

local tabs = { "Editor", "Scripts", "Console", "About" }
local tabButtons = {}
local contentHolder = mk("Frame", {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -24, 1, -96),
    Position = UDim2.new(0, 12, 0, 88),
}, win)

local pages = {}
local function makePage(name)
    local p = mk("Frame", {
        Name = name,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = false,
    }, contentHolder)
    pages[name] = p
    return p
end

local function selectTab(name)
    for _, p in pairs(pages) do p.Visible = false end
    if pages[name] then pages[name].Visible = true end
    for t, b in pairs(tabButtons) do
        b.BackgroundColor3 = (t == name) and C.accent or C.panel2
        b.TextColor3 = (t == name) and Color3.new(1, 1, 1) or C.sub
    end
end

for i, name in ipairs(tabs) do
    local b = button(tabBar, name, 84, 28)
    b.Position = UDim2.new(0, (i - 1) * 90, 0, 0)
    b.TextSize = 12
    b.MouseButton1Click:Connect(function() selectTab(name) end)
    tabButtons[name] = b
    makePage(name)
end

-- ---------------------------------------------------------------------------
-- Editor page
-- ---------------------------------------------------------------------------
local editorPage = pages["Editor"]

local editorBox = mk("ScrollingFrame", {
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, -46),
    CanvasSize = UDim2.new(0, 0, 0, 0),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = C.panel3,
}, editorPage)
corner(editorBox, 8)
stroke(editorBox, C.panel3, 1)

local editorText = mk("TextBox", {
    BackgroundTransparency = 1,
    Text = "",
    PlaceholderText = "-- Zemvar editor: paste or type Lua here",
    PlaceholderColor3 = C.sub,
    TextColor3 = C.text,
    TextSize = 13,
    Font = FONT_MONO,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    MultiLine = true,
    ClearTextOnFocus = false,
    Size = UDim2.new(1, -16, 0, 0),
    Position = UDim2.new(0, 8, 0, 8),
    AutomaticSize = Enum.AutomaticSize.Y,
}, editorBox)
editorText.TextWrapped = false

local function refreshEditorCanvas()
    editorBox.CanvasSize = UDim2.new(0, 0, 0, math.max(editorText.TextBounds.Y + 24, editorBox.AbsoluteSize.Y))
end
editorText:GetPropertyChangedSignal("Text"):Connect(refreshEditorCanvas)
editorText:GetPropertyChangedSignal("TextBounds"):Connect(refreshEditorCanvas)

local execBtn = button(editorPage, "Execute", 96, 32)
execBtn.BackgroundColor3 = C.accent
execBtn.Position = UDim2.new(0, 0, 1, -36)
corner(execBtn, 8)

local clearBtn = button(editorPage, "Clear", 72, 32)
clearBtn.Position = UDim2.new(0, 104, 1, -36)
corner(clearBtn, 8)

local copyBtn = button(editorPage, "Copy", 72, 32)
copyBtn.Position = UDim2.new(0, 184, 1, -36)
corner(copyBtn, 8)

-- ---------------------------------------------------------------------------
-- Scripts page
-- ---------------------------------------------------------------------------
local scriptsPage = pages["Scripts"]
local scriptList = mk("ScrollingFrame", {
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, -46),
    CanvasSize = UDim2.new(0, 0, 0, 0),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = C.panel3,
}, scriptsPage)
corner(scriptList, 8)
stroke(scriptList, C.panel3, 1)
mk("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, scriptList)

local refreshBtn = button(scriptsPage, "Refresh", 96, 32)
refreshBtn.BackgroundColor3 = C.accent
refreshBtn.Position = UDim2.new(0, 0, 1, -36)
corner(refreshBtn, 8)

local folderHint = label(scriptsPage, "", 11, C.sub, FONT)
folderHint.Position = UDim2.new(0, 104, 1, -32)
folderHint.Size = UDim2.new(1, -104, 0, 24)

local function clearScriptList()
    for _, ch in ipairs(scriptList:GetChildren()) do
        if ch:IsA("TextButton") then ch:Destroy() end
    end
end

local function addScriptRow(name, text)
    local row = button(scriptList, name, 0, 30)
    row.Size = UDim2.new(1, -8, 0, 30)
    row.TextXAlignment = Enum.TextXAlignment.Left
    row.Text = "  " .. name
    row.MouseButton1Click:Connect(function()
        editorText.Text = text
        selectTab("Editor")
        pushConsole("loaded script: " .. name, "info")
    end)
    return row
end

local function loadScripts()
    clearScriptList()
    local root = "Zemvar/scripts"
    local files = call("listfiles", root)
    if type(files) ~= "table" then
        files = call("listfiles", "")
        root = ""
    end
    local n = 0
    if type(files) == "table" then
        for _, f in ipairs(files) do
            if type(f) == "string" and f:sub(-4):lower() == ".lua" then
                local src = call("readfile", f)
                if type(src) == "string" then
                    n = n + 1
                    addScriptRow(f:match("([^/\\]+)$") or f, src)
                end
            end
        end
    end
    folderHint.Text = (n > 0) and (n .. " script(s) found") or "no .lua scripts found (use writefile)"
end

refreshBtn.MouseButton1Click:Connect(function()
    pcall(loadScripts)
    pushConsole("script list refreshed", "info")
end)

-- ---------------------------------------------------------------------------
-- Console page
-- ---------------------------------------------------------------------------
local consolePage = pages["Console"]
local consoleBox = mk("ScrollingFrame", {
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, -46),
    CanvasSize = UDim2.new(0, 0, 0, 0),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = C.panel3,
}, consolePage)
corner(consoleBox, 8)
stroke(consoleBox, C.panel3, 1)
mk("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }, consoleBox)

local consoleClear = button(consolePage, "Clear", 80, 32)
consoleClear.Position = UDim2.new(0, 0, 1, -36)
corner(consoleClear, 8)

local consoleHint = label(consolePage, "script output and executor messages appear here", 11, C.sub, FONT)
consoleHint.Position = UDim2.new(0, 92, 1, -32)
consoleHint.Size = UDim2.new(1, -92, 0, 24)

local consoleRows = {}
local function renderConsole()
    for _, r in ipairs(consoleRows) do r:Destroy() end
    consoleRows = {}
    local shown = 0
    for i = #consoleLines, 1, -1 do
        local line = consoleLines[i]
        local col = C.text
        if line.k == "err" then col = C.err
        elseif line.k == "warn" then col = C.warn
        elseif line.k == "ok" then col = C.ok end
        local row = mk("TextLabel", {
            BackgroundTransparency = 1,
            Text = "[" .. line.t .. "] " .. line.s,
            TextSize = 12,
            Font = FONT_MONO,
            TextColor3 = col,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            Size = UDim2.new(1, -12, 0, 16),
            LayoutOrder = shown,
        }, consoleBox)
        row.AutomaticSize = Enum.AutomaticSize.Y
        table.insert(consoleRows, row)
        shown = shown + 1
        if shown >= 120 then break end
    end
    consoleBox.CanvasSize = UDim2.new(0, 0, 0, math.max(shown * 18, consoleBox.AbsoluteSize.Y))
end
consoleClear.MouseButton1Click:Connect(function()
    consoleLines = {}
    consoleDirty = true
end)

-- ---------------------------------------------------------------------------
-- About page
-- ---------------------------------------------------------------------------
local aboutPage = pages["About"]
local aboutTitle = label(aboutPage, "ZEMVAR", 34, C.text, FONT_BOLD)
aboutTitle.Position = UDim2.new(0, 8, 0, 8)
aboutTitle.Size = UDim2.new(1, -16, 0, 44)

local aboutSub = label(aboutPage, "executor platform  ·  v" .. VERSION, 13, C.sub, FONT)
aboutSub.Position = UDim2.new(0, 10, 0, 52)
aboutSub.Size = UDim2.new(1, -20, 0, 20)

local aboutBody = label(aboutPage,
    "Zemvar is an independent executor platform.\n" ..
    "All interface code and assets in this build are Zemvar's own.\n\n" ..
    "Shortcuts:\n" ..
    "  · Execute — run the editor contents\n" ..
    "  · Scripts — browse .lua files from the executor workspace\n" ..
    "  · Console — live script output\n",
    12, C.sub, FONT)
aboutBody.Position = UDim2.new(0, 10, 0, 84)
aboutBody.Size = UDim2.new(1, -20, 1, -92)
aboutBody.TextYAlignment = Enum.TextYAlignment.Top
aboutBody.TextWrapped = true

-- ---------------------------------------------------------------------------
-- execution
-- ---------------------------------------------------------------------------
local function setStatus(text, col)
    statusLbl.Text = text
    statusLbl.TextColor3 = col
    statusDot.BackgroundColor3 = col
end

local function execute(code)
    if type(code) ~= "string" or code:match("^%s*$") then
        pushConsole("nothing to execute", "warn")
        return
    end
    setStatus("running", C.warn)
    pushConsole("execute (" .. #code .. " bytes)", "info")
    task.spawn(function()
        local ls = loadstring
        if type(ls) ~= "function" then
            local ok, g = pcall(function() return getgenv and getgenv() end)
            if ok and type(g) == "table" then ls = g.loadstring end
        end
        if type(ls) ~= "function" then
            pushConsole("executor loadstring unavailable", "err")
            setStatus("error", C.err)
            return
        end
        local fn, err = ls(code)
        if not fn then
            pushConsole("compile error: " .. tostring(err), "err")
            setStatus("error", C.err)
            return
        end
        local ok, e = pcall(fn)
        if not ok then
            pushConsole("runtime error: " .. tostring(e), "err")
            setStatus("error", C.err)
        else
            if e ~= nil then pushConsole("result: " .. tostring(e), "ok") end
            pushConsole("execution finished", "ok")
            setStatus("ready", C.ok)
        end
    end)
end

execBtn.MouseButton1Click:Connect(function()
    execute(editorText.Text)
end)

clearBtn.MouseButton1Click:Connect(function()
    editorText.Text = ""
end)

copyBtn.MouseButton1Click:Connect(function()
    local ok = call("setclipboard", editorText.Text)
    pushConsole(ok ~= nil and "copied to clipboard" or "clipboard unavailable", ok ~= nil and "ok" or "warn")
end)

-- ---------------------------------------------------------------------------
-- log capture (Roblox LogService -> our console)
-- ---------------------------------------------------------------------------
pcall(function()
    LogService.MessageOut:Connect(function(message, msgType)
        if type(message) ~= "string" then return end
        local kind = "info"
        if msgType == Enum.MessageType.MessageError then kind = "err"
        elseif msgType == Enum.MessageType.MessageWarning then kind = "warn" end
        pushConsole(message, kind)
    end)
end)

-- ---------------------------------------------------------------------------
-- window drag (mouse + touch)
-- ---------------------------------------------------------------------------
local dragging, dragStart, startPos = false, nil, nil
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = win.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        win.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ---------------------------------------------------------------------------
-- minimize
-- ---------------------------------------------------------------------------
local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    local target = minimized and UDim2.new(0, W, 0, 44) or UDim2.new(0, W, 0, H)
    Tween:Create(win, TweenInfo.new(0.2, Enum.EasingStyle.Quad), { Size = target }):Play()
    for _, p in pairs(pages) do
        if minimized then p.Visible = false
        else
            for _, q in pairs(pages) do q.Visible = false end
            selectTab("Editor")
        end
    end
    tabBar.Visible = not minimized
    minBtn.Text = minimized and "+" or "—"
end)

-- ---------------------------------------------------------------------------
-- boot
-- ---------------------------------------------------------------------------
selectTab("Editor")
pcall(loadScripts)
pushConsole("Zemvar UI v" .. VERSION .. " loaded", "ok")
setStatus("ready", C.ok)

return gui

end)

if not okInit then
    warn("Zemvar UI failed to load: " .. tostring(initErr))
end
