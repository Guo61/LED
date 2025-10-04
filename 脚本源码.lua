local library = loadstring(game:HttpGet("https://pastebin.com/raw/3vQbADjh", true))()
local window = library:new("Cat Hub")
    local creds = window:Tab("关于", "6031097229")
    local bin = creds:section("信息", true)
    bin:Label("ByCcat")    
    bin:Label("免费脚本，禁止倒卖")
    bin:Label("欢迎使用")
    bin:Label("黑名单3395858053(Ccat)")
    local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
    Title = "Cat Hub",
    Text = "欢迎使用Cat Hub",
    Icon = "rbxassetid://108453362719381",
    Duration = 8
})
local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
    Title = "Hub",
    Text = "加载完毕 ",
    Icon = "rbxassetid://108453362719381",
    Duration = 10
})

    local credits = creds:section("Ul设置", true)

credits:Toggle("移除UI颜色", "", false, function(state)
        if state then
            game:GetService("CoreGui")["frosty is cute"].Main.DropShadowHolder.Visible = false
        else
            game:GetService("CoreGui")["frosty is cute"].Main.DropShadowHolder.Visible = true
        end
    end)
   
        credits:Button("关闭脚本",function()
            game:GetService("CoreGui")["frosty is cute"]:Destroy()
        end)

    local creds = window:Tab("通用", "6031097229")
    local credits = creds:section("玩家功能", true)

credits:Slider("速度", "WalkSpeed", game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, 16, 400, false, function(Speed)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Speed end end)
end)

credits:Slider("跳跃高度!", "JumpPower", game.Players.LocalPlayer.Character.Humanoid.JumpPower, 50, 400, false, function(Jump)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jump end end)
end)

credits:Textbox("重力设置!", "Gravity", "输入", function(Gravity)
  spawn(function() while task.wait() do game.Workspace.Gravity = Gravity end end)
end)

credits:Toggle("夜视", "Light", false, function(Light)
  spawn(function() while task.wait() do if Light then game.Lighting.Ambient = Color3.new(1, 1, 1) else game.Lighting.Ambient = Color3.new(0, 0, 0) end end end)
end)

credits:Toggle("穿墙", "NoClip", false, function(NC)  local Workspace = game:GetService("Workspace") local Players = game:GetService("Players") if NC then Clipon = true else Clipon = false end Stepped = game:GetService("RunService").Stepped:Connect(function() if not Clipon == false then for a, b in pairs(Workspace:GetChildren()) do if b.Name == Players.LocalPlayer.Name then for i, v in pairs(Workspace[Players.LocalPlayer.Name]:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end end end else Stepped:Disconnect() end end)
end)

credits:Button("透视", function()
  local Players = game:GetService("Players"):GetChildren() local RunService = game:GetService("RunService") local highlight = Instance.new("Highlight") highlight.Name = "Highlight" for i, v in pairs(Players) do repeat wait() until v.Character if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then local highlightClone = highlight:Clone() highlightClone.Adornee = v.Character highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart") highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop highlightClone.Name = "Highlight" end end game.Players.PlayerAdded:Connect(function(player) repeat wait() until player.Character if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then local highlightClone = highlight:Clone() highlightClone.Adornee = player.Character highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart") highlightClone.Name = "Highlight" end end) game.Players.PlayerRemoving:Connect(function(playerRemoved) playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy() end) RunService.Heartbeat:Connect(function() for i, v in pairs(Players) do repeat wait() until v.Character if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then local highlightClone = highlight:Clone() highlightClone.Adornee = v.Character highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart") highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop highlightClone.Name = "Highlight" task.wait() end end end)
end)

credits:Button("子追",function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/fcsdsss/games/refs/heads/main/Silent%20aim/1.1"))()
end)

  local credits = creds:section("自瞄功能", true)

function lookAt(target, eye)
    workspace.CurrentCamera.CFrame = CFrame.new(target, eye)
end

function getClosestPlayerToCursor(trg_part, teamcheck)
    local nearest = nil
    local last = math.huge
    local plrsService = game:GetService("Players")
    for i, v in ipairs(plrsService:GetPlayers()) do
        if v ~= plrsService.LocalPlayer and plrsService.LocalPlayer.Character and plrsService.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") and plrsService.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Health > 0
            and v.Character and v.Character:FindFirstChildWhichIsA("Humanoid") and v.Character:FindFirstChildWhichIsA("Humanoid").Health > 0
        then
            local allowed = not teamcheck
            if teamcheck and v.Team ~= plrsService.LocalPlayer.Team then
                allowed = true
            end
            if allowed then
                local aimobj = v.Character:FindFirstChild(trg_part) or v.Character:FindFirstChild("UpperTorso")
                if aimobj then
                    if plrsService.LocalPlayer.Character:FindFirstChild("Head") then
                        local ePos, vissss = workspace.CurrentCamera:WorldToViewportPoint(aimobj.Position)
                        local AccPos = Vector2.new(ePos.x, ePos.y)
                        local mousePos = Vector2.new(workspace.CurrentCamera.ViewportSize.x / 2, workspace.CurrentCamera.ViewportSize.y / 2)
                        local distance = (AccPos - mousePos).magnitude
                        if distance < last and vissss and distance < 400 then
                            last = distance
                            nearest = v
                        end
                    end
                end
            end
        end
    end
    return nearest
end

local aimEnabled = false
local teamCheckEnabled = false
local aimPart = "Head"
local aimRenderSteppedConnection

credits:Toggle("[阿尔宙斯]自瞄", "AimToggle", false, function(state)
    aimEnabled = state
    if state then
        aimRenderSteppedConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local closest = getClosestPlayerToCursor(aimPart, teamCheckEnabled)
            if closest then
                local aimobj = closest.Character:FindFirstChild("aimPart") or closest.Character:FindFirstChild("Head")
                if aimobj then
                    lookAt(workspace.CurrentCamera.CFrame.p, aimobj.Position)
                end
            end
        end)
    else
        if aimRenderSteppedConnection then
            aimRenderSteppedConnection:Disconnect()
            aimRenderSteppedConnection = nil
        end
    end
end)

credits:Toggle("团队检测", "TeamCheckToggle", false, function(state)
    teamCheckEnabled = state
end)

    local credits = creds:section("娱乐功能", true)
    credits:Button("伪VR", function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty45.lua"))()
end)

    local creds = window:Tab("脚本区", "6031097229")
    
    local Tab = Window:MakeTab({
    Name = "速度传奇",
    Icon = "rbxassetid://108453362719381",
    PremiumOnly = false})
    
    Tab:AddButton({
Name = "钻石",

Callback = function()while true do
local args = {
	"collectOrb",
	"Gem",
	"City"
}
game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("orbEvent"):FireServer(unpack(args))
wait(0.5)
end
end})
