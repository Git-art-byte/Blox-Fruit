local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()


local MainWindow = Rayfield:CreateWindow({
   Name = "HAKAIJAS",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "LOADING.......",
   LoadingSubtitle = "by HARJAS",
   ShowText = "HAKAIJAS", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "HAKAIJAS"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "HAKAIJAS",
      Subtitle = "Key : HAKAIJAS",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"HAKAIJAS"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})



local MainTab = MainWindow:CreateTab("PVP", 4483362458) -- Title, Image



local UserInputService = game:GetService("UserInputService")
local InfiniteJumpEnabled = false
local JumpConnection

local Toggle = MainTab:CreateToggle({
    Name = "FLY",
    CurrentValue = false,
    Flag = "ToggleFLY",
    Callback = function(value)
        InfiniteJumpEnabled = value

        if InfiniteJumpEnabled then
            -- connect only once
            if not JumpConnection then
                JumpConnection = UserInputService.JumpRequest:Connect(function()
                    if InfiniteJumpEnabled then
                        local player = game.Players.LocalPlayer
                        local char = player.Character
                        if char and char:FindFirstChildOfClass("Humanoid") then
                            char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end
                end)
            end
        else
            -- disconnect when turned off
            if JumpConnection then
                JumpConnection:Disconnect()
                JumpConnection = nil
            end
        end
    end,
})


local player = game.Players.LocalPlayer
local humanoid = (player.Character or player.CharacterAdded:Wait()):WaitForChild("Humanoid")
local speedConn -- to store the connection
local defaultSpeed = 16

-- SLIDER VERSION of your working Speed system
local SpeedSlider = MainTab:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 300},
    Increment = 10,
    Suffix = " Speed",
    CurrentValue = defaultSpeed,
    Flag = "SliderSpeed",
    Callback = function(v)
        -- disconnect old connection if it exists
        if speedConn then
            speedConn:Disconnect()
            speedConn = nil
        end

        -- set speed
        humanoid.WalkSpeed = v

        -- keep forcing speed against resets
        speedConn = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if humanoid.WalkSpeed ~= v then
                humanoid.WalkSpeed = v
            end
        end)
    end,
})

-- Reapply speed & reconnect on respawn
player.CharacterAdded:Connect(function(char)
    humanoid = char:WaitForChild("Humanoid")
    if SpeedSlider.CurrentValue and SpeedSlider.CurrentValue > 16 then
        humanoid.WalkSpeed = SpeedSlider.CurrentValue
        if speedConn then speedConn:Disconnect() end
        speedConn = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if humanoid.WalkSpeed ~= SpeedSlider.CurrentValue then
                humanoid.WalkSpeed = SpeedSlider.CurrentValue
            end
        end)
    end
end)


local Slider = MainTab:CreateSlider({
    Name = "JUMP",
    Range = {50, 150},
    Increment = 10,
    Suffix = " JUMP",
    CurrentValue = 50,
    Flag = "SliderJump", -- make sure this flag is unique
    Callback = function(v)
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            humanoid.UseJumpPower = true
            humanoid.JumpPower = v
        end
    end,
})


local Button = MainTab:CreateButton({
    Name = "CAMLOCK",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/HARJASCREATOR/2ad2f4e026e480a520a1d4251f80428b/raw", true))()
    end,
})


  
  local Toggle = MainTab:CreateToggle({
   Name = "WALLWALKER",
   CurrentValue = false,
   Flag = "ToggleWALWALKER",
   Callback = function(Value)
      local Players = game:GetService("Players")
      local RunService = game:GetService("RunService")
      local LocalPlayer = Players.LocalPlayer
      local wallwalkConn

      if Value then
         -- ENABLE WALLWALKER
         wallwalkConn = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
               for _, part in pairs(char:GetDescendants()) do
                  if part:IsA("BasePart") then
                     part.CanCollide = false
                  end
               end
            end
         end)
         -- store connection so we can turn it off later
         getgenv().wallwalkConn = wallwalkConn
      else
         -- DISABLE WALLWALKER
         if getgenv().wallwalkConn then
            getgenv().wallwalkConn:Disconnect()
            getgenv().wallwalkConn = nil
         end

         -- restore collisions
         local char = LocalPlayer.Character
         if char then
            for _, part in pairs(char:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.CanCollide = true
               end
            end
         end
      end
   end,
})





local Toggle = MainTab:CreateToggle({
   Name = "ESP",
   CurrentValue = false,
   Flag = "ToggleESP",
   Callback = function(Value)
      local Players = game:GetService("Players")
      local LocalPlayer = Players.LocalPlayer
      local espObjects = getgenv().espObjects or {}
      getgenv().espObjects = espObjects

      -- function to create ESP for one player
      local function createESP(plr)
         if espObjects[plr] then return end
         if plr.Character and plr.Character:FindFirstChild("Head") then
            -- highlight
            local highlight = Instance.new("Highlight")
            highlight.FillTransparency = 1
            highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
            highlight.OutlineTransparency = 0
            highlight.Parent = plr.Character
            highlight.Adornee = plr.Character

            -- name tag
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESP_Name"
            billboard.Adornee = plr.Character.Head
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 2.5, 0)
            billboard.AlwaysOnTop = true
            billboard.MaxDistance = math.huge
            billboard.Parent = plr.Character

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = plr.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextSize = 16
            nameLabel.Parent = billboard

            espObjects[plr] = {Highlight = highlight, Billboard = billboard}
         end
      end

      -- function to remove ESP
      local function removeESP(plr)
         if espObjects[plr] then
            if espObjects[plr].Highlight then espObjects[plr].Highlight:Destroy() end
            if espObjects[plr].Billboard then espObjects[plr].Billboard:Destroy() end
            espObjects[plr] = nil
         end
      end

      if Value then
         -- ENABLE ESP
         for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
               createESP(plr)
            end
         end

         -- connections to track joins/leaves
         getgenv().espPlayerAdded = Players.PlayerAdded:Connect(function(plr)
            plr.CharacterAdded:Connect(function()
               task.wait(1)
               createESP(plr)
            end)
         end)

         getgenv().espPlayerRemoving = Players.PlayerRemoving:Connect(function(plr)
            removeESP(plr)
         end)

      else
         -- DISABLE ESP
         for plr, _ in pairs(espObjects) do
            removeESP(plr)
         end
         if getgenv().espPlayerAdded then getgenv().espPlayerAdded:Disconnect() end
         if getgenv().espPlayerRemoving then getgenv().espPlayerRemoving:Disconnect() end
      end
   end,
})



local Button = MainTab:CreateButton({
   Name = "HITBOX",
   Callback = function()
      local Players = game:GetService("Players")
      local RunService = game:GetService("RunService")
      local LocalPlayer = Players.LocalPlayer

      if getgenv().HitboxUI then
         getgenv().HitboxUI.Enabled = not getgenv().HitboxUI.Enabled
         return
      end

      local orig = {}
      local size = 5
      local on = false

      -- keep last state across respawn
      getgenv().HitboxSettings = getgenv().HitboxSettings or {
         size = 5,
         enabled = false
      }
      size = getgenv().HitboxSettings.size
      on = getgenv().HitboxSettings.enabled

      -- Main UI
      local gui = Instance.new("ScreenGui", game.CoreGui)
      gui.Name = "HitboxExpanderUI"
      getgenv().HitboxUI = gui

      local main = Instance.new("Frame", gui)
      main.Size = UDim2.new(0, 180, 0, 120)
      main.Position = UDim2.new(0.5, -90, 0, 10)
      main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
      main.Active = true
      main.Draggable = true
      Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

      local toggleBtn = Instance.new("TextButton", main)
      toggleBtn.Size = UDim2.new(1, -20, 0, 30)
      toggleBtn.Position = UDim2.new(0, 10, 0, 10)
      toggleBtn.Text = on and "Hitbox: ON" or "Hitbox: OFF"
      toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
      toggleBtn.TextColor3 = Color3.new(1, 1, 1)
      toggleBtn.TextScaled = true
      toggleBtn.Font = Enum.Font.GothamBold

      local sizeBox = Instance.new("TextBox", main)
      sizeBox.Size = UDim2.new(1, -20, 0, 30)
      sizeBox.Position = UDim2.new(0, 10, 0, 50)
      sizeBox.Text = tostring(size)
      sizeBox.PlaceholderText = "Size (1-100)"
      sizeBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
      sizeBox.TextColor3 = Color3.new(1, 1, 1)
      sizeBox.TextScaled = true
      sizeBox.ClearTextOnFocus = false
      sizeBox.Font = Enum.Font.Gotham

      local closeBtn = Instance.new("TextButton", main)
      closeBtn.Size = UDim2.new(0, 25, 0, 25)
      closeBtn.Position = UDim2.new(1, -30, 0, 5)
      closeBtn.Text = "X"
      closeBtn.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
      closeBtn.TextColor3 = Color3.new(1, 1, 1)
      closeBtn.TextScaled = true
      closeBtn.Font = Enum.Font.GothamBold
      Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 4)

      local miniBtn = Instance.new("TextButton", gui)
      miniBtn.Size = UDim2.new(0, 50, 0, 30)
      miniBtn.Position = UDim2.new(0, 10, 0.5, -90)
      miniBtn.Text = "HB"
      miniBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
      miniBtn.TextColor3 = Color3.new(1, 1, 1)
      miniBtn.TextScaled = true
      miniBtn.Font = Enum.Font.GothamBold
      miniBtn.Visible = false
      miniBtn.Active = true
      miniBtn.Draggable = true
      Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 6)

      -- restore normal
      local function restore()
         for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
               local hrp = plr.Character.HumanoidRootPart
               if orig[plr] then
                  hrp.Size = orig[plr]
                  hrp.Transparency = 1
                  hrp.Material = Enum.Material.Plastic
                  hrp.CanCollide = true
                  orig[plr] = nil
               end
            end
         end
      end

      -- expand boxes
      local function update()
         if on then
            for _, plr in pairs(Players:GetPlayers()) do
               if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                  local hrp = plr.Character.HumanoidRootPart
                  if not orig[plr] then
                     orig[plr] = hrp.Size
                  end
                  hrp.Size = Vector3.new(size, size, size)
                  hrp.Transparency = 0.7
                  hrp.Material = Enum.Material.ForceField
                  hrp.CanCollide = false
               end
            end
         else
            restore()
         end
      end

      -- Toggle ON/OFF
      toggleBtn.MouseButton1Click:Connect(function()
         on = not on
         getgenv().HitboxSettings.enabled = on
         toggleBtn.Text = on and "Hitbox: ON" or "Hitbox: OFF"
         if not on then restore() end
      end)

      -- Size input
      sizeBox.FocusLost:Connect(function()
         local v = tonumber(sizeBox.Text)
         if v and v >= 1 and v <= 100 then
            size = v
            getgenv().HitboxSettings.size = v
         else
            sizeBox.Text = tostring(size)
         end
      end)

      -- Close → HB mini button
      closeBtn.MouseButton1Click:Connect(function()
         main.Visible = false
         miniBtn.Visible = true
      end)

      miniBtn.MouseButton1Click:Connect(function()
         main.Visible = true
         miniBtn.Visible = false
      end)

      -- Keep updating hitboxes
      RunService.RenderStepped:Connect(update)

      -- Reapply on respawn
      Players.PlayerAdded:Connect(function(plr)
         plr.CharacterAdded:Connect(function()
            if on then task.wait(1) update() end
         end)
      end)
      LocalPlayer.CharacterAdded:Connect(function()
         task.wait(1)
         if on then update() end
      end)
   end,
})
