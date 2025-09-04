-- ⚡ Ronash Hub | Reyfield Edition | Made by Jonash
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Ronash Hub | Reyfield Edition | Made by Jonash",
    LoadingTitle = "Ronash Hub",
    LoadingSubtitle = "Powered by Reyfield UI",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "RonashHub",
        FileName = "RonashHubConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "nBMb3dh7", -- Ronash Hub Discord
        RememberJoins = true
    },
    KeySystem = false
})

-- 📊 Status Tab
local StatusTab = Window:CreateTab("Status", 4483345998)
local statusLabel = StatusTab:CreateLabel("Script Status: ✅ UP")
local executorName = (identifyexecutor and identifyexecutor()) or "Unknown Executor"
StatusTab:CreateLabel("Executor: " .. executorName)
StatusTab:CreateLabel("👑 Made by Jonash")

-- 🛠 Main Tab (Speed, Jump, Gravity, Shiftlock)
local MainTab = Window:CreateTab("Main", 4483345998)
local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")

-- WalkSpeed
local speedEnabled = false
MainTab:CreateToggle({
    Name = "Enable WalkSpeed",
    CurrentValue = false,
    Callback = function(v) speedEnabled = v end
})
MainTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        if speedEnabled then humanoid.WalkSpeed = v end
    end
})

-- JumpPower
local jumpEnabled = false
MainTab:CreateToggle({
    Name = "Enable JumpPower",
    CurrentValue = false,
    Callback = function(v) jumpEnabled = v end
})
MainTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 300},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(v)
        if jumpEnabled then humanoid.JumpPower = v end
    end
})

-- Gravity
local gravEnabled = false
MainTab:CreateToggle({
    Name = "Enable Gravity",
    CurrentValue = false,
    Callback = function(v) gravEnabled = v end
})
MainTab:CreateSlider({
    Name = "Gravity",
    Range = {0, 400},
    Increment = 5,
    CurrentValue = 196,
    Callback = function(v)
        if gravEnabled then workspace.Gravity = v end
    end
})

-- Shiftlock
MainTab:CreateToggle({
    Name = "Shiftlock",
    CurrentValue = false,
    Callback = function(v)
        player.DevEnableMouseLock = v
        player.DevComputerMovementMode = Enum.DevComputerMovementMode.Scriptable
    end
})

-- 🎯 Player Tab
local PlayerTab = Window:CreateTab("Player", 4483345998)
local spectating = false
local spectatingTarget

PlayerTab:CreateDropdown({
    Name = "Spectate Player",
    Options = {},
    CurrentOption = "",
    Callback = function(selected)
        local target = game.Players:FindFirstChild(selected)
        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
            spectating = true
            spectatingTarget = target
            workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
        end
    end
})

PlayerTab:CreateButton({
    Name = "Stop Spectating",
    Callback = function()
        spectating = false
        workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChild("Humanoid")
    end
})

PlayerTab:CreateButton({
    Name = "Freeze Yourself",
    Callback = function()
        player.Character:FindFirstChild("HumanoidRootPart").Anchored = true
    end
})

PlayerTab:CreateButton({
    Name = "Unfreeze Yourself",
    Callback = function()
        player.Character:FindFirstChild("HumanoidRootPart").Anchored = false
    end
})

-- 👁 ESP Tab
local ESPTab = Window:CreateTab("ESP", 4483345998)
local espEnabled = false
local espFolder = Instance.new("Folder", game.CoreGui)
espFolder.Name = "RonashESP"

local function addESP(char)
    if not espEnabled then return end
    if char:FindFirstChild("HumanoidRootPart") then
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.Parent = espFolder
        highlight.Adornee = char
    end
end

ESPTab:CreateToggle({
    Name = "Enable ESP",
    CurrentValue = false,
    Callback = function(v)
        espEnabled = v
        espFolder:ClearAllChildren()
        if v then
            for _,plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    addESP(plr.Character)
                end
            end
        end
    end
})

-- 🌟 Extra Tab
local ExtraTab = Window:CreateTab("Extra", 4483345998)
ExtraTab:CreateButton({
    Name = "ForceField",
    Callback = function()
        Instance.new("ForceField", player.Character)
    end
})

local antiAFK
ExtraTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = false,
    Callback = function(v)
        if v then
            antiAFK = player.Idled:Connect(function()
                game.VirtualUser:CaptureController()
                game.VirtualUser:ClickButton2(Vector2.new())
            end)
        else
            if antiAFK then antiAFK:Disconnect() end
        end
    end
})

-- 🤖 AI Chat Tab with Commands
local AITab = Window:CreateTab("AI Chat", 4483345998)
local ChatHistory = {}

local ChatFrame = Instance.new("ScrollingFrame")
ChatFrame.Size = UDim2.new(1,0,0.6,0)
ChatFrame.Position = UDim2.new(0,0,0,30)
ChatFrame.CanvasSize = UDim2.new(0,0,0,0)
ChatFrame.ScrollBarThickness = 6
ChatFrame.BackgroundTransparency = 1
ChatFrame.Parent = AITab

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ChatFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0,5)

local function addMessage(sender, msg)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-10,0,30)
    label.TextWrapped = true
    label.BackgroundTransparency = 0.5
    label.BackgroundColor3 = sender=="You" and Color3.fromRGB(0,170,255) or Color3.fromRGB(255,85,85)
    label.TextColor3 = Color3.new(1,1,1)
    label.Text = sender..": "..msg
    label.Parent = ChatFrame
    ChatFrame.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y+10)
end

AITab:CreateTextbox({
    Name = "Chat with AI",
    CurrentValue = "",
    PlaceholderText = "Say something...",
    Callback = function(msg)
        if msg:match("^%s*$") then
            Rayfield:Notify({Title="AI Reply", Content="Please type something!", Duration=3})
            return
        end

        addMessage("You", msg)
        table.insert(ChatHistory,"You: "..msg)
        local reply
        local lower = msg:lower()

        -- Command-based responses
        if lower:find("/walkspeed") then
            local val = tonumber(lower:match("%d+"))
            if val then
                humanoid.WalkSpeed = val
                reply = "WalkSpeed set to "..val
            else
                reply = "Invalid WalkSpeed value!"
            end
        elseif lower:find("/jump") then
            local val = tonumber(lower:match("%d+"))
            if val then
                humanoid.JumpPower = val
                reply = "JumpPower set to "..val
            else
                reply = "Invalid JumpPower value!"
            end
        elseif lower:find("/tp") then
            local targetName = lower:match("/tp%s+(%w+)")
            local target = game.Players:FindFirstChild(targetName)
            if target and target.Character then
                player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
                reply = "Teleported to "..targetName
            else
                reply = "Player not found!"
            end
        elseif lower:find("/esp") then
            if lower:find("on") then
                espEnabled = true
                for _,plr in pairs(game.Players:GetPlayers()) do
                    if plr~=player and plr.Character then addESP(plr.Character) end
                end
                reply = "ESP enabled!"
            elseif lower:find("off") then
                espEnabled = false
                espFolder:ClearAllChildren()
                reply = "ESP disabled!"
            end
        else
            -- Keyword AI replies
            if lower:find("hello") then
                reply = "Hello! How's your day?"
            elseif lower:find("hub") or lower:find("ronash") then
                reply = "Ronash Hub is always on top! 🔥"
            elseif lower:find("joke") then
                reply = "Why did the Robloxian cross the road? To get to the other obby!"
            elseif lower:find("status") then
                reply = "All systems operational ✅"
            elseif lower:find("time") then
                reply = "Server time: "..os.date("%H:%M:%S")
            else
                local genericReplies = {
                    "Interesting... tell me more!",
                    "Haha true!",
                    "That’s cool!",
