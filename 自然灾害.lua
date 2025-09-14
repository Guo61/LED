local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Confirmed = false

WindUI:Popup({
    Title = "LED v1.15",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Content = "By:Ccat\nQQ:3395858053 欢迎使用自然灾害",
    Buttons = {
        {
            Title = "进入",
            Icon = "arrow-right",
            Callback = function() Confirmed = true end,
            Variant = "Primary",
        }
    }
})

repeat wait() until Confirmed
local Window = WindUI:CreateWindow({
    Title = "LED Hub",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = "感谢游玩",
    Folder = "LEDHub",
    Size = UDim2.fromOffset(560, 340),
    Transparent = true,
    Theme = "Dark",
    User = { Enabled = true },
    SideBarWidth = 200,
    ScrollBarEnabled = true,
})

Window:Tag({
        Title = "v1.15",
        Color = Color3.fromHex("#30ff6a")
    })
    Window:Tag({
        Title = "自然灾害", 
        Color = Color3.fromHex("#315dff")
    })
    local TimeTag = Window:Tag({
        Title = "正在开发更多服务器",
        Color = Color3.fromHex("#000000")
    })
local Tabs = {
    Home = Window:Tab({ Title = "主页", Icon = "crown" }),
    NaturalDisastersTab = Window:Tab({ Title = "自然灾害", Icon = "cloud-rain" }),
    Misc = Window:Tab({ Title = "杂项", Icon = "settings" }),
}

Window:SelectTab(1)

local autoLoops = {}

local function startLoop(name, callback, delay)
    if autoLoops[name] then return end
    autoLoops[name] = coroutine.wrap(function()
        while autoLoops[name] do
            pcall(callback)
            task.wait(delay)
        end
    end)
    task.spawn(autoLoops[name])
end

local function stopLoop(name)
    if not autoLoops[name] then return end
    autoLoops[name] = nil
end

Tabs.Home:Paragraph({
    Title = "666这么帅",
    Desc = "必须帅",
    Image = "https://raw.githubusercontent.com/Guo61/Cat-/refs/heads/main/1756468599211.png",
    ImageSize = 42,
    Thumbnail = "https://raw.githubusercontent.com/Guo61/Cat-/refs/heads/main/1756468641440.jpg",
    ThumbnailSize = 120
})

Tabs.Home:Paragraph({
    Title = "设备信息",
    Desc = "当前设备: " .. (identifyDevice() or "未知设备"),
    Image = "https://img.icons8.com/ios-filled/100/ffffff/computer.png",
    ImageSize = 42,
    Thumbnail = getDeviceThumbnail(),
    ThumbnailSize = 120
})

function identifyDevice()
    local userInputService = game:GetService("UserInputService")
    local platform = userInputService:GetPlatform()
    
    if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.Linux then
        return "电脑 (PC)"
    elseif platform == Enum.Platform.IOS then
        return "移动端 (iOS)"
    elseif platform == Enum.Platform.Android then
        return "移动端 (Android)"
    elseif platform == Enum.Platform.XBoxOne or platform == Enum.Platform.PS4 then
        return "游戏主机"
    else
        return "其他设备"
    end
end

function getDeviceThumbnail()
    local userInputService = game:GetService("UserInputService")
    local platform = userInputService:GetPlatform()
    
    if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.Linux then
        return "https://img.icons8.com/ios-filled/150/ffffff/computer.png"
    elseif platform == Enum.Platform.IOS then
        return "https://img.icons8.com/ios-filled/150/ffffff/iphone.png"
    elseif platform == Enum.Platform.Android then
        return "https://img.icons8.com/ios-filled/150/ffffff/android.png"
    elseif platform == Enum.Platform.XBoxOne then
        return "https://img.icons8.com/ios-filled/150/ffffff/xbox.png"
    elseif platform == Enum.Platform.PS4 then
        return "https://img.icons8.com/ios-filled/150/ffffff/play-station.png"
    else
        return "https://img.icons8.com/ios-filled/150/ffffff/device-unknown.png"
    end
end

Tabs.Home:Paragraph({
    Title = "欢迎",
    Desc = "需要时开启反挂机。脚本仍在更新中... 作者: Ccat\n脚本免费, 请勿倒卖。",
})

Tabs.Home:Button({
    Title = "反挂机",
    Desc = "从GitHub加载并执行反挂机",
    Callback = function()
        pcall(function()
            local response = game:HttpGet("https://raw.githubusercontent.com/Guo61/Cat-/refs/heads/main/%E5%8F%8D%E6%8C%82%E6%9C%BA.lua", true)
            if response and #response > 100 then
                loadstring(response)()
            end
        end)
    end
})

Tabs.Home:Toggle({
    Title = "显示FPS",
    Desc = "在屏幕上显示当前FPS",
    Callback = function(state)
        local FpsGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("FPSGui")
        if state then
            if not FpsGui then
                FpsGui = Instance.new("ScreenGui")
                local FpsXS = Instance.new("TextLabel")
                FpsGui.Name = "FPSGui"
                FpsGui.ResetOnSpawn = false
                FpsXS.Name = "FpsXS"
                FpsXS.Size = UDim2.new(0, 100, 0, 50)
                FpsXS.Position = UDim2.new(0, 10, 0, 10)
                FpsXS.BackgroundTransparency = 1
                FpsXS.Font = Enum.Font.SourceSansBold
                FpsXS.Text = "FPS: 0"
                FpsXS.TextSize = 20
                FpsXS.TextColor3 = Color3.new(1, 1, 1)
                FpsXS.Parent = FpsGui
                FpsGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
                
                game:GetService("RunService").Heartbeat:Connect(function()
                    local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
                    FpsXS.Text = "FPS: " .. fps
                end)
            end
            FpsGui.Enabled = true
        else
            if FpsGui then
                FpsGui.Enabled = false
            end
        end
    end
})

Tabs.Home:Toggle({
    Title = "显示范围",
    Desc = "显示玩家范围",
    Callback = function(state)
        local HeadSize = 20
        local highlight = Instance.new("Highlight")
        highlight.Adornee = nil
        highlight.OutlineTransparency = 0
        highlight.FillTransparency = 0.7
        highlight.FillColor = Color3.fromHex("#0000FF")

        local function applyHighlight(character)
            if not character:FindFirstChild("WindUI_RangeHighlight") then
                local clone = highlight:Clone()
                clone.Adornee = character
                clone.Name = "WindUI_RangeHighlight"
                clone.Parent = character
            end
        end

        local function removeHighlight(character)
            local h = character:FindFirstChild("WindUI_RangeHighlight")
            if h then
                h:Destroy()
            end
        end

        if state then
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.Name ~= game.Players.LocalPlayer.Name and player.Character then
                    applyHighlight(player.Character)
                end
            end
            game.Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(character)
                    task.wait(1)
                    applyHighlight(character)
                end)
            end)
            game.Players.PlayerRemoving:Connect(function(player)
                if player.Character then
                    removeHighlight(player.Character)
                end
            end)
        else
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.Character then
                    removeHighlight(player.Character)
                end
            end
        end
    end
})

Tabs.Home:Button({
    Title = "半隐身",
    Desc = "从GitHub加载并执行隐身脚本",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invisible-35376"))() end)
    end
})
Tabs.Home:Button({
    Title = "玩家入退提示",
    Desc = "从GitHub加载并执行提示脚本",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))() end)
    end
})

Tabs.Home:Button({
    Title = "甩飞",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
    end
})
local antiWalkFlingConn
Tabs.Home:Toggle({
    Title = "防甩飞",
    Desc = "不要和甩飞同时开启!",
    Callback = function(state)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local MAX_VELOCITY_MAGNITUDE = 80

local TELEPORT_BACK_ON_FLING = true

local lastPositions = {}

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")

        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        
        lastPositions[player.UserId] = rootPart.Position
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    if lastPositions[player.UserId] then
        lastPositions[player.UserId] = nil
    end
end)

RunService.Heartbeat:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        local character = player.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChild("Humanoid")
            
            if rootPart and humanoid and humanoid.Health > 0 then
                local currentVelocity = rootPart.AssemblyLinearVelocity
                local velocityMagnitude = currentVelocity.Magnitude

                if velocityMagnitude > MAX_VELOCITY_MAGNITUDE then
                    print("检测到玩家 " .. player.Name .. " 速度异常: " .. tostring(velocityMagnitude))
                    
                    if TELEPORT_BACK_ON_FLING and lastPositions[player.UserId] then
                        rootPart.CFrame = CFrame.new(lastPositions[player.UserId])
                    end
                    
                    rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                else
                    lastPositions[player.UserId] = rootPart.Position
                end
            end
        end
    end
end)

local function setPlayerHealth(healthValue)
    local player = game.Players.LocalPlayer
    local character = player.Character
    
    if not character then
        character = player.CharacterAdded:Wait()
    end
    
    local humanoid = character:WaitForChild("Humanoid")
    
    humanoid.Health = healthValue
    
    WindUI:Notify({
        Title = "血量设置",
        Content = "血量已设置为: " .. healthValue,
        Duration = 3
    })
end

Tabs.Home:Slider({
    Title = "设置血量",
    Desc = "调整人物血量 (0-1000)",
    Value = { Min = 0, Max = 1000, Default = 100 },
    Callback = function(val)
        setPlayerHealth(val)
    end
})

Tabs.Home:Button({
    Title = "满血",
    Desc = "将血量设置为最大值",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        setPlayerHealth(humanoid.MaxHealth)
    end
})

Tabs.Home:Button({
    Title = "半血",
    Desc = "将血量设置为一半",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        setPlayerHealth(humanoid.MaxHealth / 2)
    end
})

local godModeEnabled = false
local originalHealth
local godModeConnection

Tabs.Home:Toggle({
    Title = "无敌模式",
    Desc = "开启后血量不会减少",
    Default = false,
    Callback = function(state)
        godModeEnabled = state
        local player = game.Players.LocalPlayer
        local character = player.Character
        
        if not character then
            character = player.CharacterAdded:Wait()
        end
        
        local humanoid = character:WaitForChild("Humanoid")
        
        if state then
            originalHealth = humanoid.Health
            
            godModeConnection = humanoid.HealthChanged:Connect(function(newHealth)
                if newHealth < humanoid.MaxHealth then
                    humanoid.Health = humanoid.MaxHealth
                end
            end)
            
            humanoid.Health = humanoid.MaxHealth
            
            WindUI:Notify({
                Title = "无敌模式",
                Content = "无敌模式已开启",
                Duration = 3
            })
        else
            if godModeConnection then
                godModeConnection:Disconnect()
                godModeConnection = nil
            end
            
            if originalHealth then
                humanoid.Health = originalHealth
            end
            
            WindUI:Notify({
                Title = "无敌模式",
                Content = "无敌模式已关闭",
                Duration = 3
            })
        end
    end
})
Tabs.Home:Slider({
    Title = "设置速度",
    Desc = "可输入",
    Value = { Min = 0, Max = 520, Default = 25 },
    Callback = function(val)
        local character = game.Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = val
            end
        end
    end
})
Tabs.Home:Slider({
    Title = "设置个人重力",
    Desc = "默认值即为最大值",
    Value = { Min = 0, Max = 196.2, Default = 196.2, Rounding = 1 },
    Callback = function(val)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")
        local oldGravity = rootPart:FindFirstChild("PersonalGravity")
        if oldGravity then oldGravity:Destroy() end

        if val ~= workspace.Gravity then
            local personalGravity = Instance.new("BodyForce")
            personalGravity.Name = "PersonalGravity"
            local mass = rootPart:GetMass()
            local force = Vector3.new(0, mass * (workspace.Gravity - val), 0)
            personalGravity.Force = force
            personalGravity.Parent = rootPart
        end
    end
})
Tabs.Home:Slider({
    Title = "设置跳跃高度",
    Desc = "可输入",
    Value = { Min = 0, Max = 200, Default = 50 },
    Callback = function(val)
        local character = game.Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = val
            end
        end
    end
})

local function getPlayerNames()
    local names = {}
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(names, player.Name)
        end
    end
    return names
end

local function refreshPlayerDropdown()
    if not playersDropdown then return end

    local currentValues = playersDropdown:GetValues()
    local newValues = getPlayerNames()
    local added = {}
    local removed = {}
    
    local newSet = {}
    for _, name in ipairs(newValues) do
        newSet[name] = true
    end
    
    for _, name in ipairs(currentValues) do
        if not newSet[name] then
            table.insert(removed, name)
        end
    end
    
    local currentSet = {}
    for _, name in ipairs(currentValues) do
        currentSet[name] = true
    end
    
    for _, name in ipairs(newValues) do
        if not currentSet[name] then
            table.insert(added, name)
        end
    end
    
    for _, name in ipairs(removed) do
        playersDropdown:RemoveValue(name)
    end
    
    for _, name in ipairs(added) do
        playersDropdown:AddValue(name)
    end
end

local playersDropdown = Tabs.Home:Dropdown({
    Title = "选择要传送的玩家",
    Values = getPlayerNames(),
})

Tabs.Home:Button({
    Title = "传送至玩家",
    Desc = "传送到选中的玩家",
    Callback = function()
        local selectedPlayerName = playersDropdown.Value
        local targetPlayer = game.Players:FindFirstChild(selectedPlayerName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            humanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
        end
    end
})

game.Players.PlayerAdded:Connect(refreshPlayerDropdown)
game.Players.PlayerRemoving:Connect(refreshPlayerDropdown)

game.Players.PlayerAdded:Connect(refreshPlayerDropdown)
game.Players.PlayerRemoving:Connect(refreshPlayerDropdown)


Tabs.Home:Button({
    Title = "飞行",
    Desc = "从GitHub加载并执行飞行脚本",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/Cat-/refs/heads/main/%E9%A3%9E%E8%A1%8C%E8%84%9A%E6%9C%AC.lua"))() end)
    end
})
Tabs.Home:Button({
    Title = "无限跳",
    Desc = "开启后无法关闭",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))() end)
    end
})
Tabs.Home:Button({
    Title = "自瞄",
    Desc = "宙斯自瞄",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20Aimbot.lua"))() end)
    end
})

local trackData = {}
Tabs.Home:Toggle({
    Title = "子弹追踪",
    Default = false,
    Callback = function(state)
        trackData.enabled = state
        if not state then
            if trackData.workspaceConn then trackData.workspaceConn:Disconnect() end
            for _, conn in pairs(trackData.bulletConns or {}) do conn:Disconnect() end
            trackData.bulletConns = {}
            return
        end
        local function getTarget(bulletPos)
            local nearestTarget, nearestDist = nil, math.huge
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    local char = player.Character
                    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
                    local root = char and char:FindFirstChild("HumanoidRootPart")
                    if humanoid and humanoid.Health > 0 and root then
                        local dist = (bulletPos - root.Position).Magnitude
                        if dist <= 70 and dist < nearestDist then
                            nearestDist = dist
                            nearestTarget = root
                        end
                    end
                end
            end
            return nearestTarget
        end

        local function attachTrack(bullet)
            local bulletPart = bullet:IsA("BasePart") and bullet or bullet:FindFirstChildWhichIsA("BasePart")
            if not bulletPart then return end
            local bodyVel = bulletPart:FindFirstChildOfClass("BodyVelocity")
            if not bodyVel then
                bodyVel = Instance.new("BodyVelocity")
                bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bodyVel.Velocity = bulletPart.Velocity
                bodyVel.Parent = bulletPart
            end

            local bulletConn = game:GetService("RunService").Heartbeat:Connect(function()
                if not bulletPart.Parent or not trackData.enabled then
                    bulletConn:Disconnect()
                    trackData.bulletConns[bulletConn] = nil
                    return
                end
                local target = getTarget(bulletPart.Position)
                if target then
                    local trackDir = (target.Position - bulletPart.Position).Unit
                    bodyVel.Velocity = trackDir * bulletPart.Velocity.Magnitude
                    bulletPart.CFrame = CFrame.new(bulletPart.Position, target.Position)
                end
            end)
            trackData.bulletConns[bulletConn] = true
        end
        trackData.workspaceConn = workspace.ChildAdded:Connect(function(child)
            local isLocalBullet = (child.Name:lower():find("bullet") or child.Name:lower():find("projectile") or child.Name:lower():find("missile")) and (child:FindFirstChild("Owner") and child.Owner.Value == game.Players.LocalPlayer)
            if isLocalBullet then
                task.wait(0.05)
                attachTrack(child)
            end
        end)
    end
})

local nightVisionData = {}
Tabs.Home:Toggle({
    Title = "夜视",
    Default = false,
    Callback = function(isEnabled)
        local lighting = game:GetService("Lighting")
        if isEnabled then
            pcall(function()
                nightVisionData.originalAmbient = lighting.Ambient
                nightVisionData.originalBrightness = lighting.Brightness
                nightVisionData.originalFogEnd = lighting.FogEnd
                lighting.Ambient = Color3.fromRGB(255, 255, 255)
                lighting.Brightness = 1
                lighting.FogEnd = 1e10
                for _, v in pairs(lighting:GetDescendants()) do
                    if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") then
                        v.Enabled = false
                    end
                end
                nightVisionData.changedConnection = lighting.Changed:Connect(function()
                    lighting.Ambient = Color3.fromRGB(255, 255, 255)
                    lighting.Brightness = 1
                    lighting.FogEnd = 1e10
                end)
                local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                if not humanoidRootPart:FindFirstChildWhichIsA("PointLight") then
                    local headlight = Instance.new("PointLight", humanoidRootPart)
                    headlight.Brightness = 1
                    headlight.Range = 60
                    nightVisionData.pointLight = headlight
                end
            end)
        else
            if nightVisionData.originalAmbient then lighting.Ambient = nightVisionData.originalAmbient end
            if nightVisionData.originalBrightness then lighting.Brightness = nightVisionData.originalBrightness end
            if nightVisionData.originalFogEnd then lighting.FogEnd = nightVisionData.originalFogEnd end
            if nightVisionData.changedConnection then nightVisionData.changedConnection:Disconnect() end
            if nightVisionData.pointLight and nightVisionData.pointLight.Parent then nightVisionData.pointLight:Destroy() end
        end
    end
})

local noclipConn
Tabs.Home:Toggle({
    Title = "穿墙",
    Default = false,
    Callback = function(state)
        local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        if state then
            noclipConn = game:GetService("RunService").Stepped:Connect(function()
                if character then
                    for _, v in pairs(character:GetChildren()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConn then noclipConn:Disconnect() end
            if character then
                for _, v in pairs(character:GetChildren()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = true
                    end
                end
            end
        end
    end
})

local espEnabled = false
local espConnections = {}
local espHighlights = {}
local espNameTags = {}

local function createESP(player)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = char:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "WindUI_ESP"
    highlight.Adornee = char
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char
    espHighlights[player] = highlight

    local nameTag = Instance.new("BillboardGui")
    nameTag.Name = "WindUI_NameTag"
    nameTag.Adornee = humanoidRootPart
    nameTag.Size = UDim2.new(0, 150, 0, 20)
    nameTag.StudsOffset = Vector3.new(0, 2.8, 0)
    nameTag.AlwaysOnTop = true
    nameTag.Parent = humanoidRootPart
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = player.Name
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 14
    textLabel.TextScaled = false
    textLabel.Parent = nameTag
    espNameTags[player] = nameTag
end

local function removeESP(player)
    if espHighlights[player] and espHighlights[player].Parent then
        espHighlights[player]:Destroy()
        espHighlights[player] = nil
    end
    if espNameTags[player] and espNameTags[player].Parent then
        espNameTags[player]:Destroy()
        espNameTags[player] = nil
    end
end

local function toggleESP(state)
    espEnabled = state
    if state then
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                pcall(createESP, player)
            end
        end

        espConnections.playerAdded = game.Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Wait()
            pcall(createESP, player)
        end)
        espConnections.playerRemoving = game.Players.PlayerRemoving:Connect(function(player)
            removeESP(player)
        end)
    else
        if espConnections.playerAdded then espConnections.playerAdded:Disconnect() end
        if espConnections.playerRemoving then espConnections.playerRemoving:Disconnect() end
        for player, _ in pairs(espHighlights) do
            removeESP(player)
        end
        espHighlights = {}
        espNameTags = {}
    end
end

Tabs.Home:Toggle({
    Title = "人物透视 (ESP)",
    Desc = "显示其他玩家的透视框和名字。",
    Default = false,
    Callback = toggleESP,
})

Tabs.Home:Button({
    Title = "切换服务器",
    Desc = "切换到相同游戏的另一个服务器",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        
        TeleportService:Teleport(placeId, game.Players.LocalPlayer)
    end
})

Tabs.Home:Button({
    Title = "重新加入服务器",
    Desc = "尝试重新加入当前服务器",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        local jobId = game.JobId
        
        TeleportService:TeleportToPlaceInstance(placeId, jobId, game.Players.LocalPlayer)
    end
})

Tabs.Home:Button({
    Title = "复制服务器邀请链接",
    Desc = "复制当前服务器的邀请链接到剪贴板",
    Callback = function()
        local inviteLink = "roblox://experiences/start?placeId=" .. game.PlaceId .. "&gameInstanceId=" .. game.JobId
        setclipboard(inviteLink)
        WindUI:Notify({
            Title = "邀请链接已复制",
            Content = "链接已复制到剪贴板",
            Duration = 3
        })
    end
})

Tabs.Home:Button({
    Title = "复制服务器ID",
    Desc = "复制当前服务器的Job ID到剪贴板",
    Callback = function()
        setclipboard(game.JobId)
        WindUI:Notify({
            Title = "服务器ID已复制",
            Content = "Job ID: " .. game.JobId,
            Duration = 3
        })
    end
})


Tabs.Home:Button({
    Title = "服务器信息",
    Desc = "显示当前服务器的信息",
    Callback = function()
        local players = game.Players:GetPlayers()
        local maxPlayers = game.Players.MaxPlayers
        local placeId = game.PlaceId
        local jobId = game.JobId
        local serverType = game:GetService("RunService"):IsStudio() and "Studio" or "Live"
        
        WindUI:Notify({
            Title = "服务器信息",
            Content = string.format("玩家数量: %d/%d\nPlace ID: %d\nJob ID: %s\n服务器类型: %s", #players, maxPlayers, placeId, jobId, serverType),
            Duration = 10
        })
    end
})

if Tabs.NaturalDisastersTab then
    Tabs.NaturalDisastersTab:Toggle({
        Title = "在水上行走",
        Desc = "允许在水面上行走",
        Callback = function(state)
            local waterLevel = game.Workspace:FindFirstChild("WaterLevel")
            if waterLevel then
                waterLevel.CanCollide = state
                waterLevel.Size = state and Vector3.new(5000, 1, 5000) or Vector3.new(10, 1, 10)
            end
        end
    })

    Tabs.NaturalDisastersTab:Toggle({
        Title = "自动禁用掉落伤害",
        Desc = "自动移除掉落伤害脚本",
        Callback = function(state)
            _G.NoFallDamage = state
            while wait(0.5) and _G.NoFallDamage do
                local character = game.Players.LocalPlayer.Character
                if character then
                    local FallDamageScript = character:FindFirstChild("FallDamageScript")
                    if FallDamageScript then
                        FallDamageScript:Destroy()
                    end
                end
            end
        end
    })

    Tabs.NaturalDisastersTab:Button({
        Title = "传送到地图",
        Desc = "传送到主地图位置",
        Callback = function()
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = 
                    CFrame.new(-115.828506, 65.4863434, 18.8461514, 0.00697017973, 0.0789371505, -0.996855199, 
                              -3.13589936e-07, 0.996879458, 0.0789390653, 0.999975681, -0.000549906865, 0.00694845384)
            end
        end
    })

    Tabs.NaturalDisastersTab:Button({
        Title = "传送到游戏岛",
        Desc = "传送到游戏岛屿",
        Callback = function()
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = 
                    CFrame.new(-83.5, 38.5, -27.5, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            end
        end
    })

    local nextDisasterPrediction = false
    local disasterMessage = Instance.new("ScreenGui")
    disasterMessage.Name = "DisasterPrediction"
    disasterMessage.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(0, 300, 0, 50)
    messageLabel.Position = UDim2.new(0.5, -150, 0.1, 0)
    messageLabel.BackgroundTransparency = 0.7
    messageLabel.BackgroundColor3 = Color3.new(0, 0, 0)
    messageLabel.TextColor3 = Color3.new(1, 1, 1)
    messageLabel.Font = Enum.Font.SourceSansBold
    messageLabel.TextSize = 18
    messageLabel.Visible = false
    messageLabel.Parent = disasterMessage

    Tabs.NaturalDisastersTab:Button({
        Title = "预测灾害",
        Desc = "显示下一个灾害的类型",
        Callback = function(state)
            nextDisasterPrediction = state
            messageLabel.Visible = state
            
            if state then
                spawn(function()
                    while nextDisasterPrediction do
                        wait(3)
                        local character = game.Players.LocalPlayer.Character
                        if character then
                            local SurvivalTag = character:FindFirstChild("SurvivalTag")
                            if SurvivalTag then
                                if SurvivalTag.Value == "Blizzard" then
                                    messageLabel.Text = "下一个灾难是：暴风雪"
                                elseif SurvivalTag.Value == "Sandstorm" then
                                    messageLabel.Text = "下一个灾难是：沙尘暴"
                                elseif SurvivalTag.Value == "Avalanche" then
                                    messageLabel.Text = "下一个灾难是：雪崩"
                                elseif SurvivalTag.Value == "Tornado" then
                                    messageLabel.Text = "下一个灾难是：龙卷风"
                                elseif SurvivalTag.Value == "Volcanic Eruption" then
                                    messageLabel.Text = "下一个灾难是：火山"
                                elseif SurvivalTag.Value == "Flash Flood" then
                                    messageLabel.Text = "下一个灾难是：洪水"
                                elseif SurvivalTag.Value == "Deadly Virus" then
                                    messageLabel.Text = "下一个灾难是：病毒"
                                elseif SurvivalTag.Value == "Tsunami" then
                                    messageLabel.Text = "下一个灾难是：海啸"
                                elseif SurvivalTag.Value == "Acid Rain" then
                                    messageLabel.Text = "下一个灾难是：酸雨"
                                elseif SurvivalTag.Value == "Fire" then
                                    messageLabel.Text = "下一个灾难是：火焰"
                                elseif SurvivalTag.Value == "Meteor Shower" then
                                    messageLabel.Text = "下一个灾难是：流星雨"
                                elseif SurvivalTag.Value == "Earthquake" then
                                    messageLabel.Text = "下一个灾难是：地震"
                                elseif SurvivalTag.Value == "Thunder Storm" then
                                    messageLabel.Text = "下一个灾难是：暴风雨"
                                else
                                    messageLabel.Text = "下一个灾难是：" .. tostring(SurvivalTag.Value)
                                end
                                messageLabel.Visible = true
                            else
                                messageLabel.Visible = false
                            end
                        end
                    end
                end)
            else
                messageLabel.Visible = false
            end
        end
    })

    Tabs.NaturalDisastersTab:Toggle({
        Title = "地图投票界面",
        Desc = "显示/隐藏地图投票界面",
        Callback = function(state)
            local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
            if playerGui then
                local mainGui = playerGui:FindFirstChild("MainGui")
                if mainGui then
                    local mapVotePage = mainGui:FindFirstChild("MapVotePage")
                    if mapVotePage then
                        mapVotePage.Visible = state
                    end
                end
            end
        end
    })

    Tabs.NaturalDisastersTab:Button({
        Title = "获取气球",
        Desc = "没有实际效果",
        Callback = function()
            local plyr = game.Players.LocalPlayer
            local char = plyr.Character
            if not char then return end
            
            local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
            
            if not torso then
                WindUI:Notify({Title = "错误", Content = "找不到角色躯干", Duration = 3})
                return
            end
            
            local part1 = Instance.new("Part", char)
            part1.FormFactor = "Symmetric"
            part1.Size = Vector3.new(1, 3, 1)
            part1.TopSurface = 0
            part1.BottomSurface = 0
            part1:BreakJoints()
            
            local special = Instance.new("SpecialMesh", part1)
            special.MeshId = "http://www.roblox.com/asset/?id=25498565"
            special.TextureId = "http://www.roblox.com/asset/?id=26725707"
            special.Scale = Vector3.new(2, 2, 2)
            
            local w = Instance.new("Weld", char)
            w.Part0 = part1
            w.Part1 = torso
            w.C0 = CFrame.new(-0.4, -1.4, -0.5) * CFrame.Angles(-0.5, 0, 0.2)
            
            local part2 = Instance.new("Part", char)
            part2.FormFactor = "Symmetric"
            part2.Size = Vector3.new(1, 3, 1)
            part2.TopSurface = 0
            part2.BottomSurface = 0
            part2:BreakJoints()
            
            local special2 = Instance.new("SpecialMesh", part2)
            special2.MeshId = "http://www.roblox.com/asset/?id=25498565"
            special2.TextureId = "http://www.roblox.com/asset/?id=26725707"
            special2.Scale = Vector3.new(2, 2, 2)
            
            local w2 = Instance.new("Weld", char)
            w2.Part0 = part2
            w2.Part1 = torso
            w2.C0 = CFrame.new(0.4, -1.4, -0.5) * CFrame.Angles(-0.5, 0, -0.2)
            
            WindUI:Notify({Title = "成功", Content = "已获得气球道具", Duration = 3})
        end
    })

    local autoVoteEnabled = false
    Tabs.NaturalDisastersTab:Button({
        Title = "自动投票",
        Desc = "自动投票给随机地图",
        Callback = function(state)
            autoVoteEnabled = state
            if state then
                spawn(function()
                    while autoVoteEnabled do
                        wait(5)
                        local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
                        if playerGui then
                            local mainGui = playerGui:FindFirstChild("MainGui")
                            if mainGui then
                                local mapVotePage = mainGui:FindFirstChild("MapVotePage")
                                if mapVotePage and mapVotePage.Visible then
                                    local voteButtons = mapVotePage:GetChildren()
                                    local validButtons = {}
                                    for _, button in ipairs(voteButtons) do
                                        if button:IsA("TextButton") and button.Visible then
                                            table.insert(validButtons, button)
                                        end
                                    end
                                    if #validButtons > 0 then
                                        local randomButton = validButtons[math.random(1, #validButtons)]
                                        fireclickdetector(randomButton:FindFirstChildOfClass("ClickDetector"))
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    })

    local autoCollectEnabled = false
    Tabs.NaturalDisastersTab:Toggle({
        Title = "黑洞",
        Desc = "不知有没有用",
        Callback = function(state)
            autoCollectEnabled = state
            if state then
                spawn(function()
                    while autoCollectEnabled do
                        wait(1)
                        local character = game.Players.LocalPlayer.Character
                        if character then
                            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                for _, item in ipairs(workspace:GetChildren()) do
                                    if item.Name == "Item" and item:FindFirstChild("Handle") then
                                        local distance = (humanoidRootPart.Position - item.Handle.Position).Magnitude
                                        if distance < 1000 then
                                            firetouchinterest(humanoidRootPart, item.Handle, 0)
                                            wait()
                                            firetouchinterest(humanoidRootPart, item.Handle, 1)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    })

    local autoAvoidEnabled = false
    Tabs.NaturalDisastersTab:Toggle({
        Title = "自动躲避灾害",
        Desc = "尝试自动躲避当前灾害",
        Callback = function(state)
            autoAvoidEnabled = state
            if state then
                spawn(function()
                    while autoAvoidEnabled do
                        wait(0.5)
                        local character = game.Players.LocalPlayer.Character
                        if character then
                            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                for _, disaster in ipairs(workspace:GetChildren()) do
                                    if (disaster.Name:find("Tornado") or disaster.Name:find("Flood") or disaster.Name:find("Fire")) and disaster:FindFirstChildOfClass("BasePart") then
                                        local disasterPart = disaster:FindFirstChildOfClass("BasePart")
                                        local distance = (humanoidRootPart.Position - disasterPart.Position).Magnitude
                                        if distance < 30 then
                                            local direction = (humanoidRootPart.Position - disasterPart.Position).Unit
                                            humanoidRootPart.Velocity = direction * 50
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    })

    local infiniteOxygenEnabled = false
    Tabs.NaturalDisastersTab:Toggle({
        Title = "无限氧气",
        Desc = "在水下时保持无限氧气",
        Callback = function(state)
            infiniteOxygenEnabled = state
            if state then
                spawn(function()
                    while infiniteOxygenEnabled do
                        wait(0.1)
                        local character = game.Players.LocalPlayer.Character
                        if character then
                            local humanoid = character:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                humanoid.OxygenLevel = humanoid.MaxOxygenLevel
                            end
                        end
                    end
                end)
            end
        end
    })

    local fastSwimEnabled = false
    Tabs.NaturalDisastersTab:Toggle({
        Title = "快速游泳",
        Desc = "在水下时游泳速度加快",
        Callback = function(state)
            fastSwimEnabled = state
            if state then
                spawn(function()
                    while fastSwimEnabled do
                        wait(0.1)
                        local character = game.Players.LocalPlayer.Character
                        if character then
                            local humanoid = character:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                local head = character:FindFirstChild("Head")
                                if head and head:FindFirstChild("WaterLevel") then
                                    humanoid.WalkSpeed = 32
                                else
                                    humanoid.WalkSpeed = 16
                                end
                            end
                        end
                    end
                end)
            end
        end
    })

    local disasterImmunityEnabled = false
    Tabs.NaturalDisastersTab:Toggle({
        Title = "灾害免疫",
        Desc = "尝试免疫某些灾害的伤害",
        Callback = function(state)
            disasterImmunityEnabled = state
            if state then
                spawn(function()
                    while disasterImmunityEnabled do
                        wait(0.5)
                        local character = game.Players.LocalPlayer.Character
                        if character then
                            for _, child in ipairs(character:GetChildren()) do
                                if child.Name:find("Fire") or child.Name:find("Smoke") or child.Name:find("Sparkles") then
                                    child:Destroy()
                                end
                            end
                        end
                    end
                end)
            end
        end
    })
end

Tabs.Misc:Button({
    Title = "复制作者QQ",
    Callback = function()
        setclipboard("3395858053")
        WindUI:Notify({Title = "QQ群号", Content = "群号已复制到剪贴板", Duration = 3})
    end
})

Tabs.Misc:Button({
    Title = "脚本信息",
    Desc = "显示脚本相关信息",
    Callback = function()
        WindUI:Notify({
            Title = "脚本信息",
            Content = "LED Hub v1.15\n作者: Ccat\nQQ:3395858053",
            Duration = 10
        })
    end
})

WindUI:Notify({
    Title = "LED Hub已加载",
    Content = "欢迎使用自然灾害脚本 v1.15",
    Duration = 5
})