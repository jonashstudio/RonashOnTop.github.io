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

-- 🤖 AI Chat Tab (fixed + merged)
local AITab = Window:CreateTab("AI Chat", 4483345998)
local ChatLog = ""

local ChatHistory = AITab:CreateParagraph({Title="Chat History", Content=ChatLog})

AITab:CreateTextbox({
    Name = "Chat with AI",
    CurrentValue = "",
    PlaceholderText = "Type something...",
    Callback = function(msg)
        if msg:match("^%s*$") then
            Rayfield:Notify({
                Title = "AI Reply",
                Content = "Please type something first!",
                Duration = 3
            })
            return
        end

        local reply
        local lower = msg:lower()

        -- Commands and keyword replies
        if lower:find("hello") or lower:find("hi") then
            reply = "Hello! How are you?"
        elseif lower:find("hub") then
            reply = "Ronash Hub is always on top 🔥"
        elseif lower:find("joke") then
            reply = "Why did the Robloxian cross the road? To finish the obby!"
        elseif lower:find("status") then
            reply = "✅ Hub is working fine!"
        elseif lower:find("/walkspeed") then
            local val = tonumber(lower:match("%d+"))
            if val then
                humanoid.WalkSpeed = val
                reply = "WalkSpeed set to "..val
            else
                reply = "⚠ Invalid WalkSpeed value!"
            end
        elseif lower:find("/jump") then
            local val = tonumber(lower:match("%d+"))
            if val then
                humanoid.JumpPower = val
                reply = "JumpPower set to "..val
            else
                reply = "⚠ Invalid JumpPower value!"
            end
        else
            local generic = {
                "Interesting... tell me more!",
                "Haha true!",
                "That’s cool!",
                "Hmm, I see!"
            }
            reply = generic[math.random(1,#generic)]
        end

        -- Update chat log
        ChatLog = ChatLog .. "\nYou: " .. msg .. "\nAI: " .. reply
        AITab:UpdateParagraph("Chat History", {Title="Chat History", Content=ChatLog})

        Rayfield:Notify({
            Title = "AI Reply",
            Content = reply,
            Duration = 3
        })
    end
})
