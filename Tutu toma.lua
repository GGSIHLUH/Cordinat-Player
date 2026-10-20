-- [[ YSS HUB | STARFALL OPENING & COORDINATES LOADER ]]
-- DEV: GG SIH LUH | YouTube: yys_hub

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer

local function makeGui(name)
    local gui = Instance.new("ScreenGui")
    gui.Name = name
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 99999

    if syn and syn.protect_gui then
        pcall(syn.protect_gui, gui)
    end

    local candidates = {
        function() return gethui and gethui() end,
        function() return CoreGui end,
        function() return LP:WaitForChild("PlayerGui", 5) end,
    }
    for _, getParent in ipairs(candidates) do
        local ok, p = pcall(getParent)
        if ok and p then
            local ok2 = pcall(function() gui.Parent = p end)
            if ok2 and gui.Parent == p then return gui end
        end
    end
    return gui
end

local openingGui = makeGui("YSS_StarfallOpening")

-- 1. FRAME UTAMA OPENING (LATAR HITAM)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0
mainFrame.Parent = openingGui

local viewportSize = workspace.CurrentCamera.ViewportSize

-- 2. SPAWN 100 BINTANG JATUH ACAK
local stars = {}
math.randomseed(tick())

for i = 1, 100 do
    local star = Instance.new("TextLabel")
    star.Size = UDim2.new(0, 30, 0, 30)
    star.AnchorPoint = Vector2.new(0.5, 0.5)
    local startX = math.random(50, viewportSize.X - 50)
    local startY = math.random(-500, -50)
    star.Position = UDim2.fromOffset(startX, startY)
    star.BackgroundTransparency = 1
    star.Text = "⭐"
    star.TextColor3 = Color3.fromRGB(255, 255, 255)
    star.TextSize = math.random(14, 28)
    star.Font = Enum.Font.FredokaOne
    star.Parent = mainFrame
    
    table.insert(stars, star)

    local targetX = viewportSize.X / 2 + math.random(-150, 150)
    local targetY = viewportSize.Y / 2 + math.random(-150, 150)
    local fallDuration = math.random(15, 25) / 10

    TweenService:Create(star, TweenInfo.new(fallDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.fromOffset(targetX, targetY)
    }):Play()
end

-- 3. SETELAH BINTANG JATUH (KUMPUL DI TENGAH & MUTER-MUTER)
task.delay(2.2, function()
    local rotConn
    local tickStart = tick()
    
    rotConn = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - tickStart
        local centerX = viewportSize.X / 2
        local centerY = viewportSize.Y / 2
        local radius = math.clamp(120 - (elapsed * 30), 10, 120)
        
        for idx, s in ipairs(stars) do
            if s and s.Parent then
                local angle = (elapsed * 4) + (idx * (360 / #stars))
                local x = centerX + math.cos(math.rad(angle)) * radius
                local y = centerY + math.sin(math.rad(angle)) * radius
                s.Position = UDim2.fromOffset(x, y)
                s.Rotation = s.Rotation + 8
            end
        end
    end)

    task.delay(2.5, function()
        if rotConn then rotConn:Disconnect() end
        
        for _, s in ipairs(stars) do
            if s and s.Parent then s:Destroy() end
        end

        local centerText = Instance.new("TextLabel")
        centerText.Size = UDim2.new(0, 600, 0, 50)
        centerText.AnchorPoint = Vector2.new(0.5, 0.5)
        centerText.Position = UDim2.new(0.5, 0, 0.35, 0)
        centerText.BackgroundTransparency = 1
        centerText.Text = "「❀」│Welcome┆🌸"
        centerText.TextColor3 = Color3.fromRGB(255, 255, 255)
        centerText.TextSize = 22
        centerText.Font = Enum.Font.FredokaOne
        centerText.TextTransparency = 1
        centerText.Parent = mainFrame
        TweenService:Create(centerText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

        local btnReady = Instance.new("TextButton")
        btnReady.Size = UDim2.new(0, 380, 0, 45)
        btnReady.AnchorPoint = Vector2.new(0.5, 0.5)
        btnReady.Position = UDim2.new(0.5, 0, 0.52, 0)
        btnReady.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
        btnReady.TextColor3 = Color3.fromRGB(255, 255, 255)
        btnReady.TextSize = 12
        btnReady.Font = Enum.Font.FredokaOne
        btnReady.Text = "THE SCRIPT HAS READY CLIK FOR EXECUTE"
        btnReady.AutoButtonColor = false
        btnReady.BackgroundTransparency = 1
        btnReady.TextTransparency = 1
        btnReady.Parent = mainFrame
        Instance.new("UICorner", btnReady).CornerRadius = UDim.new(0, 8)
        
        TweenService:Create(btnReady, TweenInfo.new(0.5), {BackgroundTransparency = 0, TextTransparency = 0}):Play()

        local btnNotGood = Instance.new("TextButton")
        btnNotGood.Size = UDim2.new(0, 380, 0, 40)
        btnNotGood.AnchorPoint = Vector2.new(0.5, 0.5)
        btnNotGood.Position = UDim2.new(0.5, 0, 0.63, 0)
        btnNotGood.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btnNotGood.TextColor3 = Color3.fromRGB(255, 255, 255)
        btnNotGood.TextSize = 12
        btnNotGood.Font = Enum.Font.FredokaOne
        btnNotGood.Text = "Not Thanks I mean the script is Not good"
        btnNotGood.AutoButtonColor = false
        btnNotGood.BackgroundTransparency = 1
        btnNotGood.TextTransparency = 1
        btnNotGood.Parent = mainFrame
        Instance.new("UICorner", btnNotGood).CornerRadius = UDim.new(0, 8)

        TweenService:Create(btnNotGood, TweenInfo.new(0.5), {BackgroundTransparency = 0.2, TextTransparency = 0}):Play()

        local function slideUpAndDestroy()
            local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            
            TweenService:Create(centerText, tweenInfo, {Position = UDim2.new(0.5, 0, -0.3, 0)}):Play()
            TweenService:Create(btnReady, tweenInfo, {Position = UDim2.new(0.5, 0, -0.2, 0)}):Play()
            TweenService:Create(btnNotGood, tweenInfo, {Position = UDim2.new(0.5, 0, -0.1, 0)}):Play()
            
            local fadeBg = TweenService:Create(mainFrame, TweenInfo.new(0.6), {BackgroundTransparency = 1})
            fadeBg:Play()

            fadeBg.Completed:Connect(function()
                openingGui:Destroy()
            end)
        end

        -- FUNGSI MEMUNCULKAN SCRIPT KOORDINAT SETELAH EXECUTE
        local function loadCoordinatesHub()
            if CoreGui:FindFirstChild("YSS_CoordsGui") then
                CoreGui.YSS_CoordsGui:Destroy()
            end

            local ScreenGui = Instance.new("ScreenGui")
            ScreenGui.Name = "YSS_CoordsGui"
            ScreenGui.ResetOnSpawn = false
            ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            ScreenGui.IgnoreGuiInset = true

            if syn and syn.protect_gui then
                syn.protect_gui(ScreenGui)
            end
            ScreenGui.Parent = CoreGui

            local MainFrame = Instance.new("Frame")
            MainFrame.Name = "MainFrame"
            MainFrame.Size = UDim2.fromOffset(240, 95)
            MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
            MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
            MainFrame.BorderSizePixel = 0
            MainFrame.Active = true
            MainFrame.Draggable = true
            MainFrame.Parent = ScreenGui

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 8)
            UICorner.Parent = MainFrame

            local UIStroke = Instance.new("UIStroke")
            UIStroke.Thickness = 2
            UIStroke.Parent = MainFrame

            local UIGradient = Instance.new("UIGradient")
            UIGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 50))
            })
            UIGradient.Rotation = 45
            UIGradient.Parent = UIStroke

            task.spawn(function()
                while ScreenGui.Parent do
                    TweenService:Create(UIGradient, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Rotation = UIGradient.Rotation + 360}):Play()
                    task.wait(1.5)
                end
            end)

            local TitleLabel = Instance.new("TextLabel")
            TitleLabel.Size = UDim2.new(1, 0, 0, 24)
            TitleLabel.Position = UDim2.fromOffset(0, 6)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Text = "📍 LIVE COORDINATES"
            TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleLabel.TextSize = 12
            TitleLabel.Font = Enum.Font.FredokaOne
            TitleLabel.Parent = MainFrame

            local CoordsLabel = Instance.new("TextLabel")
            CoordsLabel.Name = "CoordsLabel"
            CoordsLabel.Size = UDim2.new(1, -16, 0, 22)
            CoordsLabel.Position = UDim2.fromOffset(8, 30)
            CoordsLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            CoordsLabel.BorderSizePixel = 0
            CoordsLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
            CoordsLabel.TextSize = 11
            CoordsLabel.Font = Enum.Font.Code
            CoordsLabel.Text = "X: 0.00 | Y: 0.00 | Z: 0.00"
            CoordsLabel.Parent = MainFrame

            local CoordsCorner = Instance.new("UICorner")
            CoordsCorner.CornerRadius = UDim.new(0, 4)
            CoordsCorner.Parent = CoordsLabel

            local CopyButton = Instance.new("TextButton")
            CopyButton.Size = UDim2.new(1, -16, 0, 26)
            CopyButton.Position = UDim2.fromOffset(8, 58)
            CopyButton.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
            CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            CopyButton.TextSize = 12
            CopyButton.Font = Enum.Font.FredokaOne
            CopyButton.Text = "📋 COPY COORDINATES"
            CopyButton.AutoButtonColor = false
            CopyButton.Parent = MainFrame

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 4)
            BtnCorner.Parent = CopyButton

            local currentCoordsText = "0, 0, 0"

            RunService.RenderStepped:Connect(function()
                local char = LP.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local pos = char.HumanoidRootPart.Position
                    currentCoordsText = string.format("Vector3.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z)
                    CoordsLabel.Text = string.format("X: %.1f | Y: %.1f | Z: %.1f", pos.X, pos.Y, pos.Z)
                end
            end)

            CopyButton.MouseButton1Click:Connect(function()
                if setclipboard then
                    setclipboard(currentCoordsText)
                    CopyButton.Text = "✅ COPIED!"
                    CopyButton.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
                    task.wait(1.2)
                    CopyButton.Text = "📋 COPY COORDINATES"
                    CopyButton.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
                else
                    CopyButton.Text = "❌ UNSUPPORTED"
                    task.wait(1.2)
                    CopyButton.Text = "📋 COPY COORDINATES"
                end
            end)
        end

        btnReady.MouseButton1Click:Connect(function()
            slideUpAndDestroy()
            task.spawn(function()
                loadCoordinatesHub()
            end)
        end)

        btnNotGood.MouseButton1Click:Connect(function()
            slideUpAndDestroy()
        end)
    end)
end)
