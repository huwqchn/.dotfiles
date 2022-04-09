require("keyboard") -- Load Hammerspoon bits from https://github.com/jasonrudolph/keyboard

local application = require "hs.application"
local window = require "hs.window"
local hotkey = require "hs.hotkey"
local alert = require "hs.alert"
local grid = require "hs.grid"
local hints = require "hs.hints"
local applescript = require "hs.applescript"

-- hyper
local hyper = {"ctrl", "alt", "cmd", "shift"}

-- hs.loadSpoon("HCalendar")

-- hs.loadSpoon("AClock")
-- hotkey.bind('alt', '6', function() spoon.AClock:toggleShow() end)

-- hs.loadSpoon("WinWin")

-- hs.loadSpoon("CountDown")

-- hs.loadSpoon("TimeFlow") -- time elapsed

require "pomo"
require "slowq"

hs.hotkey.bind(hyper, '9', '🤓 > POMO ON', function() pom_enable() end)
hs.hotkey.bind(hyper, '0', '😌 > POMO OFF', function() pom_disable() end)

-- no animation Duration
window.animationDuration = 0

-- window hints
hints.fontName = "Avenir"
hints.fontSize = 25
hints.hintChars = {"A", "S", "D", "F", "J", "K", "L", "Q", "W"}
hints.iconAlpha = 1.0
hints.showTitleThresh = 0

hotkey.bind(
    "ctrl",
    "tab",
    function()
        hints.windowHints()
    end
)

-- make the alerts look nicer.
alert.defaultStyle.strokeColor = {white = 1, alpha = 0}
alert.defaultStyle.fillColor = {white = 0.05, alpha = 0.75}
alert.defaultStyle.radius = 5
alert.defaultStyle.fadeOutDuration = 0.5
alert.defaultStyle.textFont = "Fira Mono"
alert.defaultStyle.textSize = 20

-- grid sized windows management
grid.GRIDWIDTH = 8
grid.GRIDHEIGHT = 8
grid.MARGINX = 0
grid.MARGINY = 0

local gw = grid.GRIDWIDTH
local gh = grid.GRIDHEIGHT

local gomiddle = {x = 1, y = 1, w = 6, h = 6}
local gocenter = {x = 1, y = 1, w = 4, h = 4}
local gobig = {x = 0, y = 0, w = gw, h = gh}

-- 四个象限的窗口管理
-- local go1 = {x = 4, y = 0, w = 4, h = 4}
-- local go2 = {x = 0, y = 0, w = 4, h = 4}
-- local go3 = {x = 0, y = 4, w = 4, h = 4}
-- local go4 = {x = 4, y = 4, w = 4, h = 4}

-- 中心 小中心 大全屏
hotkey.bind(
    hyper,
    "G",
    function()
        grid.set(window.focusedWindow(), gomiddle)
    end
)
hotkey.bind(
    hyper,
    "H",
    function()
        grid.set(window.focusedWindow(), gocenter)
    end
)
hotkey.bind(
    hyper,
    "O",
    function()
        grid.set(window.focusedWindow(), gobig)
    end
)

-- show app info
hotkey.bind(
    hyper,
    "i",
    function()
        alert.show(
            string.format(
                "App path:      %s\nApp name:      %s\nIM source id:  %s",
                window.focusedWindow():application():path(),
                window.focusedWindow():application():name(),
                hs.keycodes.currentSourceID()
            )
        )
    end
)



-- this part is for open or focus app windows
local key2App = {
    --a = '',
    b = "Google Chrome", -- b for browser
    c = "Visual Studio Code", --vscode
    d = "Eudic", -- d for dict
    e = "Code", -- e for editor
    f = "PathFinder",
    -- g used --center babe
    -- h = '',
    -- i
    -- j = "Spotify",
    -- k = "",
    -- l = 'Dictionary',
    m = "Spotify", -- m for music
    n = 'NetNewsWires',
    -- o used --max babe
    p = "PDFGuru", 
    -- q = "QSpace",
    r = 'Reminders',
    s = 'System Preferences',
    t = "iTerm", -- t for term
    -- u
    -- v = 'Dictionary',
    -- w = 'TaskPaper',
    -- x = 'Sublime Text',
    -- y = 'Dictionary',
    z = 'iTerm2'
}

for key, app in pairs(key2App) do
    hotkey.bind(
        hyper,
        key,
        function()
            --application.launchOrFocus(app)
            toggle_application(app)
            --hs.grid.set(hs.window.focusedWindow(), gomiddle)
        end
    )
end

-- Toggle application focus
function toggle_application(_app)
    -- finds a running applications
    local app = application.find(_app)
    if not app then
        -- application not running, launch app
        application.launchOrFocus(_app)
        return
    end
    -- application running, toggle hide/unhide
    local mainwin = app:mainWindow()
    if mainwin then
        if true == app:isFrontmost() then
            mainwin:application():hide()
        else
            mainwin:application():activate(true)
            mainwin:application():unhide()
            mainwin:focus()
        end
    else
        -- no windows, maybe hide
        if true == app:hide() then
            -- focus app
            application.launchOrFocus(_app)
        else
            -- nothing to do
        end
    end
end

--run applescript
--function: read applescript content
function applescript_reader(string)
    local path = string
    local file = io.open(path, "r")
    local data = file:read("*a")
    file:close()
    return data
end
-- run it // toggle darkmode®
hotkey.bind(
    "alt",
    "D",
    function()
        applescript(applescript_reader("~/.config/.hammerspoon/your.applescript"))
        alert.show("🌜.🌏.🌛")
    end
)

-- alt + R reload
hotkey.bind("alt", "R", function() hs.reload() end) 
alert.show("🤓.🛠.🤓")
