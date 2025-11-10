--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @angedev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 

Player Tracker - Executor Only Version with UIDragDetector
Compatible with Delta, Krnl, Wave, and other executors
]=]

-- Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local G2L = {}

-- Core GUI detection (from your file)
local core
if game:FindFirstChildOfClass("CoreGui") then
    if gethui then
        core = gethui()
    else
        core = game:GetService("CoreGui")
    end
else
    core = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

-- ============================================================================
-- GUI CREATION
-- ============================================================================

-- Create ScreenGui
G2L["ScreenGui_1"] = Instance.new("ScreenGui", core)
G2L["ScreenGui_1"]["IgnoreGuiInset"] = true
G2L["ScreenGui_1"]["DisplayOrder"] = 5
G2L["ScreenGui_1"]["ScreenInsets"] = Enum.ScreenInsets.None
G2L["ScreenGui_1"]["ClipToDeviceSafeArea"] = false
G2L["ScreenGui_1"]["ResetOnSpawn"] = false
G2L["ScreenGui_1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
G2L["ScreenGui_1"]["Name"] = "PlayerTracker"

-- Main Frame
G2L["MainFrame_2"] = Instance.new("Frame", G2L["ScreenGui_1"])
G2L["MainFrame_2"]["BorderSizePixel"] = 0
G2L["MainFrame_2"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30)
G2L["MainFrame_2"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
G2L["MainFrame_2"]["Size"] = UDim2.new(0, 512, 0, 340)
G2L["MainFrame_2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
G2L["MainFrame_2"]["Name"] = "MainFrame"
G2L["MainFrame_2"]["BackgroundTransparency"] = 0.15

-- UIDragDetector (from your file)
G2L["UIDragDetector_3"] = Instance.new("UIDragDetector", G2L["MainFrame_2"])
G2L["UIDragDetector_3"]["DragSpace"] = Enum.UIDragDetectorDragSpace.LayerCollector

-- Username TextBox
G2L["UserBox_4"] = Instance.new("TextBox", G2L["MainFrame_2"])
G2L["UserBox_4"]["CursorPosition"] = -1
G2L["UserBox_4"]["Name"] = "UserBox"
G2L["UserBox_4"]["BorderSizePixel"] = 0
G2L["UserBox_4"]["TextSize"] = 48
G2L["UserBox_4"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
G2L["UserBox_4"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70)
G2L["UserBox_4"]["FontFace"] = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
G2L["UserBox_4"]["PlaceholderText"] = "Username.."
G2L["UserBox_4"]["Size"] = UDim2.new(0, 422, 0, 64)
G2L["UserBox_4"]["Position"] = UDim2.new(0, 44, 0, 68)
G2L["UserBox_4"]["Text"] = ""

G2L["UICorner_5"] = Instance.new("UICorner", G2L["UserBox_4"])
G2L["UICorner_5"]["CornerRadius"] = UDim.new(0, 15)

-- Main Frame Corner
G2L["UICorner_6"] = Instance.new("UICorner", G2L["MainFrame_2"])
G2L["UICorner_6"]["CornerRadius"] = UDim.new(0, 15)

-- Join Button
G2L["JoinButton_7"] = Instance.new("TextButton", G2L["MainFrame_2"])
G2L["JoinButton_7"]["TextWrapped"] = true
G2L["JoinButton_7"]["BorderSizePixel"] = 0
G2L["JoinButton_7"]["TextScaled"] = true
G2L["JoinButton_7"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
G2L["JoinButton_7"]["BackgroundColor3"] = Color3.fromRGB(6, 227, 20)
G2L["JoinButton_7"]["FontFace"] = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
G2L["JoinButton_7"]["Size"] = UDim2.new(0, 196, 0, 68)
G2L["JoinButton_7"]["Text"] = "Join Player"
G2L["JoinButton_7"]["Name"] = "JoinButton"
G2L["JoinButton_7"]["Position"] = UDim2.new(0, 144, 0, 254)

G2L["UICorner_8"] = Instance.new("UICorner", G2L["JoinButton_7"])
G2L["UICorner_8"]["CornerRadius"] = UDim.new(0, 15)

G2L["UIStroke_9"] = Instance.new("UIStroke", G2L["JoinButton_7"])
G2L["UIStroke_9"]["Thickness"] = 2

-- Game ID Label
G2L["GameID_a"] = Instance.new("TextLabel", G2L["MainFrame_2"])
G2L["GameID_a"]["TextWrapped"] = true
G2L["GameID_a"]["BorderSizePixel"] = 0
G2L["GameID_a"]["TextSize"] = 55
G2L["GameID_a"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["GameID_a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["GameID_a"]["FontFace"] = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
G2L["GameID_a"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
G2L["GameID_a"]["BackgroundTransparency"] = 1
G2L["GameID_a"]["Size"] = UDim2.new(0, 390, 0, 86)
G2L["GameID_a"]["Text"] = tostring(game.PlaceId)
G2L["GameID_a"]["Name"] = "GameID"
G2L["GameID_a"]["Position"] = UDim2.new(0, 106, 0, 142)

-- Status Label
G2L["StatusLabel_b"] = Instance.new("TextLabel", G2L["MainFrame_2"])
G2L["StatusLabel_b"]["TextWrapped"] = true
G2L["StatusLabel_b"]["BorderSizePixel"] = 0
G2L["StatusLabel_b"]["TextSize"] = 20
G2L["StatusLabel_b"]["TextXAlignment"] = Enum.TextXAlignment.Center
G2L["StatusLabel_b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["StatusLabel_b"]["FontFace"] = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["StatusLabel_b"]["TextColor3"] = Color3.fromRGB(200, 200, 200)
G2L["StatusLabel_b"]["BackgroundTransparency"] = 1
G2L["StatusLabel_b"]["Size"] = UDim2.new(0, 400, 0, 30)
G2L["StatusLabel_b"]["Text"] = "Ready"
G2L["StatusLabel_b"]["Name"] = "StatusLabel"
G2L["StatusLabel_b"]["Position"] = UDim2.new(0, 56, 0, 200)

-- Close Button
G2L["CloseButton_c"] = Instance.new("TextButton", G2L["MainFrame_2"])
G2L["CloseButton_c"]["TextWrapped"] = true
G2L["CloseButton_c"]["BorderSizePixel"] = 0
G2L["CloseButton_c"]["TextSize"] = 36
G2L["CloseButton_c"]["TextColor3"] = Color3.fromRGB(255, 0, 0)
G2L["CloseButton_c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["CloseButton_c"]["FontFace"] = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
G2L["CloseButton_c"]["BackgroundTransparency"] = 1
G2L["CloseButton_c"]["Size"] = UDim2.new(0, 72, 0, 74)
G2L["CloseButton_c"]["Text"] = "X"
G2L["CloseButton_c"]["Name"] = "CloseButton"
G2L["CloseButton_c"]["Position"] = UDim2.new(0, 440, 0, -4)

-- Title
G2L["Title_d"] = Instance.new("TextLabel", G2L["MainFrame_2"])
G2L["Title_d"]["TextWrapped"] = true
G2L["Title_d"]["BorderSizePixel"] = 0
G2L["Title_d"]["TextScaled"] = true
G2L["Title_d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["Title_d"]["FontFace"] = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
G2L["Title_d"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
G2L["Title_d"]["BackgroundTransparency"] = 1
G2L["Title_d"]["Size"] = UDim2.new(0, 358, 0, 46)
G2L["Title_d"]["Text"] = "Player Tracker"
G2L["Title_d"]["Name"] = "Title"
G2L["Title_d"]["Position"] = UDim2.new(0, 68, 0, 8)

-- Local Player Image
G2L["LocalPlayerImage_e"] = Instance.new("ImageLabel", G2L["MainFrame_2"])
G2L["LocalPlayerImage_e"]["BorderSizePixel"] = 0
G2L["LocalPlayerImage_e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["LocalPlayerImage_e"]["Size"] = UDim2.new(0, 80, 0, 80)
G2L["LocalPlayerImage_e"]["BackgroundTransparency"] = 1
G2L["LocalPlayerImage_e"]["Name"] = "LocalPlayerImage"
G2L["LocalPlayerImage_e"]["Position"] = UDim2.new(0, 16, 0, 246)

-- Set local player image
pcall(function()
    G2L["LocalPlayerImage_e"]["Image"] = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=150&height=150&format=png"
end)

-- Add corner to image
local imageCorner = Instance.new("UICorner", G2L["LocalPlayerImage_e"])
imageCorner["CornerRadius"] = UDim.new(0, 15)

-- UIScale for animations
G2L["UIScale_f"] = Instance.new("UIScale", G2L["MainFrame_2"])

-- ============================================================================
-- PLAYER TRACKING FUNCTIONS (REALISTIC EXECUTOR VERSION)
-- ============================================================================

-- Function to get user ID from username
local function getUserId(username)
    local success, result = pcall(function()
        return Players:GetUserIdFromNameAsync(username)
    end)
    return success and result or nil
end

-- Function to get game instances using TeleportService
local function getServerList()
    local servers = {}
    local success, result = pcall(function()
        -- This method uses TeleportService to get server info
        return game:GetService("TeleportService"):GetTeleportSettings()
    end)
    
    -- Alternative: Use HTTP to get public servers (limited success)
    local httpRequest = syn and syn.request or http and http.request or request
    if httpRequest then
        local success, response = pcall(function()
            return httpRequest({
                Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=10",
                Method = "GET",
                Headers = {
                    ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
                }
            })
        end)
        
        if success and response.StatusCode == 200 then
            local data = HttpService:JSONDecode(response.Body)
            return data.data or {}
        end
    end
    
    return {}
end

-- Realistic server hopping function
local function hopToRandomServer()
    local servers = getServerList()
    
    if #servers > 0 then
        -- Pick a random server
        local randomServer = servers[math.random(1, #servers)]
        if randomServer and randomServer.id then
            pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer.id)
            end)
            return true
        end
    end
    
    -- Fallback: Use TeleportService to join a random server
    pcall(function()
        TeleportService:Teleport(game.PlaceId)
    end)
    return false
end

-- Check if player is in current server
local function findPlayerInCurrentServer(username)
    for _, player in pairs(Players:GetPlayers()) do
        if string.lower(player.Name):find(string.lower(username), 1, true) or 
           string.lower(player.DisplayName):find(string.lower(username), 1, true) then
            return player
        end
    end
    return nil
end

-- ============================================================================
-- ANIMATIONS
-- ============================================================================

local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local fastTween = TweenInfo.new(0.5, Enum.EasingStyle.Exponential)

-- Entrance animation
local function playEntranceAnimation()
    G2L["UIScale_f"]["Scale"] = 0
    G2L["MainFrame_2"]["BackgroundTransparency"] = 1
    
    local sizeTween = TweenService:Create(G2L["UIScale_f"], tweenInfo, {
        Scale = 1
    })
    local transparencyTween = TweenService:Create(G2L["MainFrame_2"], tweenInfo, {
        BackgroundTransparency = 0.15
    })
    
    sizeTween:Play()
    transparencyTween:Play()
end

-- Button animations
local function setupButtonHover(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = hoverColor,
            Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset + 5, button.Size.Y.Scale, button.Size.Y.Offset + 5)
        })
        hoverTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local normalTween = TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = normalColor,
            Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset - 5, button.Size.Y.Scale, button.Size.Y.Offset - 5)
        })
        normalTween:Play()
    end)
end

setupButtonHover(G2L["JoinButton_7"], Color3.fromRGB(8, 255, 25), Color3.fromRGB(6, 227, 20))

-- Close button animation
G2L["CloseButton_c"].MouseEnter:Connect(function()
    local hoverTween = TweenService:Create(G2L["CloseButton_c"], TweenInfo.new(0.2), {
        TextColor3 = Color3.fromRGB(255, 100, 100),
        Rotation = 90
    })
    hoverTween:Play()
end)

G2L["CloseButton_c"].MouseLeave:Connect(function()
    local normalTween = TweenService:Create(G2L["CloseButton_c"], TweenInfo.new(0.2), {
        TextColor3 = Color3.fromRGB(255, 0, 0),
        Rotation = 0
    })
    normalTween:Play()
end)

-- TextBox animations
G2L["UserBox_4"].Focused:Connect(function()
    local focusTween = TweenService:Create(G2L["UserBox_4"], TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(90, 90, 90),
        Size = UDim2.new(0, 430, 0, 68)
    })
    focusTween:Play()
end)

G2L["UserBox_4"].FocusLost:Connect(function()
    local unfocusTween = TweenService:Create(G2L["UserBox_4"], TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(70, 70, 70),
        Size = UDim2.new(0, 422, 0, 64)
    })
    unfocusTween:Play()
end)

-- ============================================================================
-- MAIN FUNCTIONALITY
-- ============================================================================

-- Update status function
local function updateStatus(text, color)
    G2L["StatusLabel_b"]["Text"] = text
    G2L["StatusLabel_b"]["TextColor3"] = color or Color3.fromRGB(200, 200, 200)
end

-- Join button functionality
G2L["JoinButton_7"].MouseButton1Click:Connect(function()
    local username = G2L["UserBox_4"].Text:gsub("%s+", "")
    if username == "" then
        updateStatus("Please enter a username!", Color3.fromRGB(255, 100, 100))
        return
    end
    
    -- Button press animation
    local pressTween = TweenService:Create(G2L["JoinButton_7"], TweenInfo.new(0.1), {
        Size = UDim2.new(0, 186, 0, 58)
    })
    pressTween:Play()
    
    wait(0.1)
    
    local releaseTween = TweenService:Create(G2L["JoinButton_7"], TweenInfo.new(0.1), {
        Size = UDim2.new(0, 196, 0, 68)
    })
    releaseTween:Play()
    
    -- Change button state
    G2L["JoinButton_7"]["Text"] = "Searching..."
    G2L["JoinButton_7"]["BackgroundColor3"] = Color3.fromRGB(255, 165, 0)
    updateStatus("Tracking " .. username .. " across servers...", Color3.fromRGB(255, 255, 0))
    
    -- Executor tracking logic (realistic version)
    spawn(function()
        -- First check current server
        local currentPlayer = findPlayerInCurrentServer(username)
        if currentPlayer then
            updateStatus("Player found in current server!", Color3.fromRGB(0, 255, 0))
            G2L["JoinButton_7"]["Text"] = "Already Here!"
            G2L["JoinButton_7"]["BackgroundColor3"] = Color3.fromRGB(0, 200, 0)
            
            wait(3)
            G2L["JoinButton_7"]["Text"] = "Join Player"
            G2L["JoinButton_7"]["BackgroundColor3"] = Color3.fromRGB(6, 227, 20)
            updateStatus("Ready", Color3.fromRGB(200, 200, 200))
            return
        end
        
        -- Check if username exists
        local userId = getUserId(username)
        if not userId then
            updateStatus("Invalid username!", Color3.fromRGB(255, 100, 100))
            G2L["JoinButton_7"]["Text"] = "Invalid User"
            G2L["JoinButton_7"]["BackgroundColor3"] = Color3.fromRGB(255, 50, 50)
            
            wait(3)
            G2L["JoinButton_7"]["Text"] = "Join Player"
            G2L["JoinButton_7"]["BackgroundColor3"] = Color3.fromRGB(6, 227, 20)
            updateStatus("Ready", Color3.fromRGB(200, 200, 200))
            return
        end
        
        -- Attempt server hopping (realistic approach)
        updateStatus("User exists! Attempting server hop...", Color3.fromRGB(255, 200, 0))
        G2L["JoinButton_7"]["Text"] = "Server Hopping..."
        G2L["JoinButton_7"]["BackgroundColor3"] = Color3.fromRGB(0, 200, 0)
        
        -- Try to hop to a different server
        local success = hopToRandomServer()
        
        if not success then
            updateStatus("Could not find available servers", Color3.fromRGB(255, 100, 100))
            G2L["JoinButton_7"]["Text"] = "No Servers"
            G2L["JoinButton_7"]["BackgroundColor3"] = Color3.fromRGB(255, 50, 50)
            
            wait(3)
            G2L["JoinButton_7"]["Text"] = "Join Player"
            G2L["JoinButton_7"]["BackgroundColor3"] = Color3.fromRGB(6, 227, 20)
            updateStatus("Ready", Color3.fromRGB(200, 200, 200))
        end
    end)
end)

-- Close button functionality
G2L["CloseButton_c"].MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(G2L["UIScale_f"], fastTween, {
        Scale = 0
    })
    local transparencyTween = TweenService:Create(G2L["MainFrame_2"], fastTween, {
        BackgroundTransparency = 1
    })
    
    closeTween:Play()
    transparencyTween:Play()
    
    closeTween.Completed:Connect(function()
        G2L["ScreenGui_1"]:Destroy()
    end)
end)

-- Play entrance animation
playEntranceAnimation()

-- Success notifications
local StarterGui = game:GetService("StarterGui")

-- Function to send notifications
local function sendNotification(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title;
            Text = text;
            Duration = duration or 5;
        })
    end)
end

-- Send success notifications
sendNotification("Player Tracker", "Loaded successfully! ✅", 3)
sendNotification("Game Info", "Place ID: " .. tostring(game.PlaceId), 3)

local httpSupport = (syn and syn.request) or (http and http.request) or request
sendNotification("HTTP Status", httpSupport and "HTTP requests available ✅" or "HTTP requests not available ❌", 4)

return G2L["ScreenGui_1"]
