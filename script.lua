-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Window with Key System
local Window = Rayfield:CreateWindow({
    Name = "Ronash Hub | X2ZU Edition",
    LoadingTitle = "Ronash Hub",
    LoadingSubtitle = "Powered by Rayfield UI",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "RonashHub",
        FileName = "RonashConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "nBMb3dh7", -- your Discord
        RememberJoins = true
    },
    KeySystem = true, -- ✅ Key system enabled
    KeySettings = {
        Title = "Ronash Hub Key System",
        Subtitle = "Protecting Ronash Hub",
        Note = "Join our Discord to get the key!",
        FileName = "RonashKey", -- saved locally
        SaveKey = true, -- saves key between executions
        GrabKeyFromSite = false, -- set true if later you want a website key
        Key = {"Ronashhubontop"} -- ✅ only valid key
    }
})

-- Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)
MainTab:CreateLabel("Welcome to Ronash Hub!")

-- Speed
MainTab:CreateToggle({
    Name = "Enable Speed",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end,
})

-- Jump Power
MainTab:CreateToggle({
    Name = "Enable High Jump",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 120
        else
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end,
})

-- Gravity
MainTab:CreateToggle({
    Name = "Low Gravity",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            workspace.Gravity = 50
        else
            workspace.Gravity = 196.2
        end
    end,
})

-- Unlimited Jump
MainTab:CreateToggle({
    Name = "Unlimited Jump",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().UnliJump = Value
        game.UserInputService.JumpRequest:Connect(function()
            if getgenv().UnliJump then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    end,
})

-- ESP
local ESPEnabled = false
MainTab:CreateToggle({
    Name = "ESP (Players)",
    CurrentValue = false,
    Callback = function(Value)
        ESPEnabled = Value
        while ESPEnabled do
            task.wait(1)
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= game.Players.LocalPlayer and plr.Character and not plr.Character:FindFirstChild("ESP") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP"
                    highlight.Parent = plr.Character
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.FillColor = Color3.fromRGB(255,0,0)
                end
            end
        end
        if not ESPEnabled then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("ESP") then
                    plr.Character.ESP:Destroy()
                end
            end
        end
    end,
})

-- Anti-AFK
MainTab:CreateButton({
    Name = "Enable Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
        Rayfield:Notify({
            Title = "Anti-AFK",
            Content = "Anti-AFK Enabled Successfully!",
            Duration = 5
        })
    end,
})

-- Status Tab
local StatusTab = Window:CreateTab("Status", 4483362458)
StatusTab:CreateLabel("Script Status: 🟢 UP")
StatusTab:CreateLabel("Executor: Ronix (Detected)")
