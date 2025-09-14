local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/Cat-/refs/heads/main/main.lua"))()

local Confirmed = false

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

WindUI:Popup({
    Title = "LED v1.20",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Content = "By:Ccat\nQQ:3395858053 欢迎使用吃掉世界",
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
        Title = "v1.20",
        Color = Color3.fromHex("#30ff6a")
    })
    Window:Tag({
        Title = "吃掉世界", 
        Color = Color3.fromHex("#315dff")
    })
    local TimeTag = Window:Tag({
        Title = "正在开发更多服务器",
        Color = Color3.fromHex("#000000")
    })
local Tabs = {
    Home = Window:Tab({ Title = "主页", Icon = "crown" }),
    NaturalDisastersTab = Window:Tab({ Title = "吃掉世界", Icon = "cloud-rain" }),
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
    Desc = "当前设备: " .. identifyDevice(),
    Image = "https://img.icons8.com/ios-filled/100/ffffff/computer.png",
    ImageSize = 42,
    Thumbnail = getDeviceThumbnail(),
    ThumbnailSize = 120
})

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
        if state then
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

            antiWalkFlingConn = RunService.Heartbeat:Connect(function()
                for _, player in ipairs(Players:GetPlayers()) do
                    local character = player.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        local humanoid = character:FindFirstChild("Humanoid")
                        
                        if rootPart and humanoid and humanoid.Health > 0 then
                            local currentVelocity = rootPart.AssemblyLinearVelocity
                            local velocityMagnitude = currentVelocity.Magnitude

                            if velocityMagnitude > MAX_VELOCITY_MAGNITUDE then
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
        else
            if antiWalkFlingConn then
                antiWalkFlingConn:Disconnect()
                antiWalkFlingConn = nil
            end
        end
    end
})

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
    Desc = "重置角色即可关闭",
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

Tabs.Home:Button({
    Title = "同款LAT加密",
    Desc = "点击复制",
    Callback = function()
        local obflink = "https://bypass.ceo/obfuscator"
        setclipboard(obflink)
        WindUI:Notify({
            Title = "已复制LAT obf",
            Content = "已复制至剪贴板",
            Duration = 3
        })
    end
})

local main = {
    AutoGrab = false,
    AutoEat = false,
    AutoThrow = false,
    AutoSell = false,
    AutoBox = false,
    AutoTele = false,
    AutoMap = false,
    AutoSellInterval = 300,
    teleThread = nil
}

Tabs.NaturalDisastersTab:Toggle({
    Title = "自动抓",
    Image = "bird",
    Value = main.AutoGrab,
    Callback = function(state)
        main.AutoGrab = state
        if state then
          WindUI:Notify({
                Title = "自动抓",
                Content = "自动抓已开启",
                Duration = 3
            })
            startLoop("AutoGrab", function()
                game:GetService("Players").LocalPlayer.Character.Events.Grab:FireServer(false,false,false)
            end, 2)
        else
          WindUI:Notify({
                Title = "自动抓",
                Content = "自动抓已关闭",
                Duration = 3
            })
            stopLoop("AutoGrab")
        end
    end
})

Tabs.NaturalDisastersTab:Toggle({
    Title = "自动吃",
    Image = "bird",
    Value = main.AutoEat,
    Callback = function(state)
        main.AutoEat = state
        if state then
            WindUI:Notify({
                Title = "自动吃",
                Content = "自动吃已开启",
                Duration = 3
            })
            startLoop("AutoEat", function()
                game:GetService("Players").LocalPlayer.Character.Events.Eat:FireServer()
            end, 0.1)
        else
            WindUI:Notify({
                Title = "自动吃",
                Content = "自动吃已关闭",
                Duration = 3
            })
            stopLoop("AutoEat")
        end
    end
})

Tabs.NaturalDisastersTab:Toggle({
    Title = "自动扔",
    Image = "bird",
    Value = main.AutoThrow,
    Callback = function(state)
        main.AutoThrow = state
        if state then
            WindUI:Notify({
                Title = "自动扔",
                Content = "自动扔已开启",
                Duration = 3
            })
            startLoop("AutoThrow", function()
                game:GetService("Players").LocalPlayer.Character.Events.Throw:FireServer()
            end, 0.1)
        else
            WindUI:Notify({
                Title = "自动扔",
                Content = "自动扔已关闭",
                Duration = 3
            })
            stopLoop("AutoThrow")
        end
    end
})

Tabs.NaturalDisastersTab:Toggle({
    Title = "自动卖",
    Desc = "间隔为300s",
    Image = "bird",
    Value = main.AutoSell,
    Callback = function(state)
        main.AutoSell = state
        if state then
            WindUI:Notify({
                Title = "自动卖",
                Content = "自动卖已开启",
                Duration = 3
            })
            startLoop("AutoSell", function()
                game:GetService("Players").LocalPlayer.Character.Events.Sell:FireServer()
            end, 300)
        else
            WindUI:Notify({
                Title = "自动卖",
                Content = "自动卖已关闭",
                Duration = 3
            })
            stopLoop("AutoSell")
        end
    end
})

Tabs.NaturalDisastersTab:Slider({
    Title = "设置间隔时间",
    Desc = "可输入(秒)",
    Value = { Min = 1, Max = 600, Default = 300 },
    Callback = function(val)
        main.AutoSellInterval = val
        if main.AutoSell then
            stopLoop("AutoSell")
            startLoop("AutoSell", function()
                game:GetService("Players").LocalPlayer.Character.Events.Sell:FireServer()
            end, val)
            WindUI:Notify({
                Title = "自动卖",
                Content = "间隔时间已更新: " .. val .. "秒",
                Duration = 3
            })
        end
    end
})

Tabs.NaturalDisastersTab:Toggle({
    Title = "自动领箱子",
    Image = "bird",
    Value = main.AutoBox,
    Callback = function(state)
        main.AutoBox = state
        if state then
            WindUI:Notify({
                Title = "自动领箱子",
                Content = "自动领箱子已开启",
                Duration = 3
            })
            startLoop("AutoBox", function()
                game:GetService("ReplicatedStorage").Events.RewardEvent:FireServer(game:GetService("Players").LocalPlayer.TimedRewards.SmallReward)
            end, 0.1)
        else
            WindUI:Notify({
                Title = "自动领箱子",
                Content = "自动领箱子已关闭",
                Duration = 3
            })
            stopLoop("AutoBox")
        end
    end
})

Tabs.NaturalDisastersTab:Toggle({
    Title = "自动领箱子",
    Image = "bird",
    Value = main.AutoBox,
    Callback = function(state)
        main.AutoBox = state
        if state then
            WindUI:Notify({
                Title = "自动领箱子",
                Content = "自动领箱子已开启",
                Duration = 3
            })
            startLoop("AutoBox", function()
                local args = {
                    game:GetService("Players").LocalPlayer:WaitForChild("TimedRewards"):WaitForChild("SmallReward")
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RewardEvent"):FireServer(unpack(args))
            end, 0.1)
        else
            WindUI:Notify({
                Title = "自动领箱子",
                Content = "自动领箱子已关闭",
                Duration = 3
            })
            stopLoop("AutoBox")
        end
    end
})

Tabs.NaturalDisastersTab:Toggle({
    Title = "移除地图",
    Image = "bird",
    Value = main.AutoMap,
    Callback = function(state)
        main.AutoMap = state
        if state then
            WindUI:Notify({
                Title = "自动移除地图",
                Content = "自动移除地图已开启",
                Duration = 3
            })
            startLoop("AutoMap", function()
                pcall(function() workspace.Map.Buildings:Destroy() end)
                pcall(function() workspace.Map.Fragmentable:Destroy() end)
                pcall(function() workspace.Chunks:Destroy() end)
            end, 0.1)
        else
            WindUI:Notify({
                Title = "自动移除地图",
                Content = "自动移除地图已开启",
                Duration = 3
            })
            stopLoop("AutoMap")
        end
    end
})

Tabs.NaturalDisastersTab:Toggle({
    Title = "自动传送",
    Image = "bird",
    Value = main.AutoTele,
    Callback = function(state)
        main.AutoTele = state
        
        if main.teleThread then
            task.cancel(main.teleThread)
            main.teleThread = nil
        end
        
        if state then
            main.teleThread = task.spawn(function()
                local telePoints = {
                    CFrame.new(67.5105209350586, 2.617709159851074, 49.95643615722656),
                    CFrame.new(66.61660766601562, 2.617709159851074, 27.347152709960938),
                    CFrame.new(62.12251281738281, 2.617709159851074, 11.004171371459961),
                    CFrame.new(57.77750778198242, 2.617709159851074, -3.3018038272857666),
                    CFrame.new(52.71255874633789, 2.617709159851074, -17.906509399414062),
                    CFrame.new(38.93976593017578, 2.617709159851074, -35.72473907470703),
                    CFrame.new(25.061079025268555, 2.617709159851074, -46.44431686401367),
                    CFrame.new(7.925309658050537, 2.617709159851074, -58.25339889526367),
                    CFrame.new(-13.032307624816895, 2.617709159851074, -62.51304626464844),
                    CFrame.new(-28.29254150390625, 2.617709159851074, -54.87309265136719),
                    CFrame.new(-56.19231414794922, 2.617709159851074, -32.02164840698242),
                    CFrame.new(-64.64066314697266, 2.617709159851074, -20.583925247192383),
                    CFrame.new(-91.2260513305664, 2.617709159851074, -12.719565391540527),
                    CFrame.new(-116.47618103027344, 2.6177096366882324, -9.312110900878906),
                    CFrame.new(-139.49990844726562, 2.6177096366882324, 23.60348892211914),
                    CFrame.new(-139.42808532714844, 2.6177096366882324, 55.475135803222656),
                    CFrame.new(-137.9814453125, 2.6177096366882324, 78.55432891845703),
                    CFrame.new(-136.70278930664062, 2.6177096366882324, 95.68263244628906),
                    CFrame.new(-38.68806838989258, 2.617709159851074, -48.66199493408203)
                }
                
                local currentIndex = 1
                
                while main.AutoTele do
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()
                    local hrp = character:FindFirstChild("HumanoidRootPart")
                    
                    if hrp and main.AutoTele then
                        hrp.CFrame = telePoints[currentIndex]
                        currentIndex = currentIndex + 1
                        if currentIndex > #telePoints then
                            currentIndex = 1
                        end
                    end
                    
                    task.wait(2)
                end
            end)
        end
    end
})

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
            Content = "LED Hub v1.20\n作者: Ccat\nQQ:3395858053",
            Duration = 10
        })
    end
})

WindUI:Notify({
    Title = "LED Hub已加载",
    Content = "欢迎使用 v1.20",
    Duration = 5
})