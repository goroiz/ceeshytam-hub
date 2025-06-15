--[[
  Ceeshytam Hub
  Created by goroiz
  Version: 1.0
  No Key System
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Tema warna coklat
local ColorScheme = {
    Main = Color3.fromRGB(139, 69, 19),   -- SaddleBrown
    Secondary = Color3.fromRGB(160, 82, 45), -- Sienna
    Background = Color3.fromRGB(40, 30, 20),
    Text = Color3.fromRGB(255, 250, 240),  -- FloralWhite
    Accent = Color3.fromRGB(210, 105, 30)  -- Chocolate
}

-- Fungsi untuk membuat GUI
local function CreateCeeshytamGUI()
    -- Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CeeshytamHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game.CoreGui

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 400, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = ColorScheme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = MainFrame

    -- Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.Position = UDim2.new(0, 0, 0, 0)
    Header.BackgroundColor3 = ColorScheme.Main
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 8)
    HeaderCorner.Parent = Header

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Text = "ceeshytam"
    Title.TextColor3 = ColorScheme.Text
    Title.TextSize = 20
    Title.Font = Enum.Font.GothamBold
    Title.Size = UDim2.new(0, 200, 0, 40)
    Title.Position = UDim2.new(0.5, -100, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Parent = Header

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Text = "X"
    CloseButton.TextColor3 = ColorScheme.Text
    CloseButton.TextSize = 18
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Size = UDim2.new(0, 40, 0, 40)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Parent = Header

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, -20, 1, -60)
    TabContainer.Position = UDim2.new(0, 10, 0, 50)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = MainFrame

    -- Tabs
    local Tabs = {"Player", "Teleport", "Visuals", "Misc"}

    -- Tab Buttons
    local TabButtons = {}
    local TabButtonContainer = Instance.new("Frame")
    TabButtonContainer.Name = "TabButtonContainer"
    TabButtonContainer.Size = UDim2.new(1, 0, 0, 40)
    TabButtonContainer.Position = UDim2.new(0, 0, 0, 40)
    TabButtonContainer.BackgroundTransparency = 1
    TabButtonContainer.Parent = MainFrame

    for i, tabName in ipairs(Tabs) do
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName.."TabButton"
        TabButton.Text = tabName
        TabButton.TextColor3 = ColorScheme.Text
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.Gotham
        TabButton.Size = UDim2.new(0.25, -5, 1, 0)
        TabButton.Position = UDim2.new((i-1)*0.25, 0, 0, 0)
        TabButton.BackgroundColor3 = ColorScheme.Secondary
        TabButton.BorderSizePixel = 0
        TabButton.Parent = TabButtonContainer
        
        TabButton.MouseButton1Click:Connect(function()
            for _, frame in ipairs(TabContainer:GetChildren()) do
                if frame:IsA("Frame") then
                    frame.Visible = false
                end
            end
            TabContainer:FindFirstChild(tabName.."Tab").Visible = true
        end)
        
        TabButtons[i] = TabButton
    end

    -- Player Tab
    local PlayerTab = Instance.new("Frame")
    PlayerTab.Name = "PlayerTab"
    PlayerTab.Size = UDim2.new(1, 0, 1, 0)
    PlayerTab.Position = UDim2.new(0, 0, 0, 0)
    PlayerTab.BackgroundTransparency = 1
    PlayerTab.Visible = true
    PlayerTab.Parent = TabContainer

    -- Player Tab Content
    local SpeedSlider = CreateSlider("Walk Speed", 16, 100, 16, PlayerTab, 10, 10)
    local JumpSlider = CreateSlider("Jump Power", 50, 200, 50, PlayerTab, 10, 70)
    
    local NoclipToggle = CreateToggle("Noclip", false, PlayerTab, 10, 130)
    local FlyToggle = CreateToggle("Fly", false, PlayerTab, 10, 180)
    
    local ResetButton = Instance.new("TextButton")
    ResetButton.Name = "ResetButton"
    ResetButton.Text = "Reset Character"
    ResetButton.TextColor3 = ColorScheme.Text
    ResetButton.TextSize = 14
    ResetButton.Font = Enum.Font.Gotham
    ResetButton.Size = UDim2.new(0.9, 0, 0, 40)
    ResetButton.Position = UDim2.new(0.05, 0, 0, 250)
    ResetButton.BackgroundColor3 = ColorScheme.Accent
    ResetButton.Parent = PlayerTab
    
    local Corner2 = Instance.new("UICorner")
    Corner2.CornerRadius = UDim.new(0, 6)
    Corner2.Parent = ResetButton
    
    ResetButton.MouseButton1Click:Connect(function()
        LocalPlayer.Character:BreakJoints()
    end)

    -- Teleport Tab
    local TeleportTab = Instance.new("Frame")
    TeleportTab.Name = "TeleportTab"
    TeleportTab.Size = UDim2.new(1, 0, 1, 0)
    TeleportTab.Position = UDim2.new(0, 0, 0, 0)
    TeleportTab.BackgroundTransparency = 1
    TeleportTab.Visible = false
    TeleportTab.Parent = TabContainer

    -- Teleport Tab Content
    local TeleportButtons = {
        {Name = "Spawn", Position = Vector3.new(0, 5, 0)},
        {Name = "Sky", Position = Vector3.new(0, 500, 0)},
        {Name = "Behind", Position = function() 
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    return hrp.CFrame * CFrame.new(0, 0, 5)
                end
            end
            return CFrame.new(0, 5, 0)
        end},
        {Name = "TP to Player", Position = function() 
            local target = Players:FindFirstChild("PlayerName")
            if target and target.Character then
                local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    return hrp.CFrame
                end
            end
            return nil
        end}
    }

    for i, button in ipairs(TeleportButtons) do
        local btn = Instance.new("TextButton")
        btn.Name = button.Name
        btn.Text = button.Name
        btn.TextColor3 = ColorScheme.Text
        btn.TextSize = 14
        btn.Font = Enum.Font.Gotham
        btn.Size = UDim2.new(0.9, 0, 0, 40)
        btn.Position = UDim2.new(0.05, 0, 0, 10 + (i-1)*50)
        btn.BackgroundColor3 = ColorScheme.Secondary
        btn.Parent = TeleportTab
        
        local CornerBtn = Instance.new("UICorner")
        CornerBtn.CornerRadius = UDim.new(0, 6)
        CornerBtn.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if type(button.Position) == "function" then
                        local pos = button.Position()
                        if pos then
                            hrp.CFrame = pos
                        end
                    else
                        hrp.CFrame = CFrame.new(button.Position)
                    end
                end
            end
        end)
    end

    -- Visuals Tab
    local VisualsTab = Instance.new("Frame")
    VisualsTab.Name = "VisualsTab"
    VisualsTab.Size = UDim2.new(1, 0, 1, 0)
    VisualsTab.Position = UDim2.new(0, 0, 0, 0)
    VisualsTab.BackgroundTransparency = 1
    VisualsTab.Visible = false
    VisualsTab.Parent = TabContainer

    -- Visuals Tab Content
    local EspToggle = CreateToggle("Player ESP", false, VisualsTab, 10, 10)
    local TracersToggle = CreateToggle("Tracers", false, VisualsTab, 10, 60)
    local FullbrightToggle = CreateToggle("Fullbright", false, VisualsTab, 10, 110)

    -- Misc Tab
    local MiscTab = Instance.new("Frame")
    MiscTab.Name = "MiscTab"
    MiscTab.Size = UDim2.new(1, 0, 1, 0)
    MiscTab.Position = UDim2.new(0, 0, 0, 0)
    MiscTab.BackgroundTransparency = 1
    MiscTab.Visible = false
    MiscTab.Parent = TabContainer

    -- Misc Tab Content
    local FpsBoost = CreateButton("FPS Boost", MiscTab, 10, 10)
    local ServerHop = CreateButton("Server Hop", MiscTab, 10, 70)
    local CopyDiscord = CreateButton("Copy Discord", MiscTab, 10, 130)

    -- Make draggable
    MakeDraggable(Header, MainFrame)

    return ScreenGui
end

-- Fungsi pembantu
function CreateSlider(name, min, max, default, parent, x, y)
    local SliderContainer = Instance.new("Frame")
    SliderContainer.Name = name.."Slider"
    SliderContainer.Size = UDim2.new(0.9, 0, 0, 50)
    SliderContainer.Position = UDim2.new(0.05, 0, 0, y)
    SliderContainer.BackgroundTransparency = 1
    SliderContainer.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Text = name .. ": " .. default
    Label.TextColor3 = ColorScheme.Text
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderContainer
    
    local Track = Instance.new("Frame")
    Track.Name = "Track"
    Track.Size = UDim2.new(1, 0, 0, 5)
    Track.Position = UDim2.new(0, 0, 0, 30)
    Track.BackgroundColor3 = ColorScheme.Secondary
    Track.BorderSizePixel = 0
    Track.Parent = SliderContainer
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 3)
    Corner.Parent = Track
    
    local Fill = Instance.new("Frame")
    Fill.Name = "Fill"
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.Position = UDim2.new(0, 0, 0, 0)
    Fill.BackgroundColor3 = ColorScheme.Accent
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    
    local Corner2 = Instance.new("UICorner")
    Corner2.CornerRadius = UDim.new(0, 3)
    Corner2.Parent = Fill
    
    local Handle = Instance.new("TextButton")
    Handle.Name = "Handle"
    Handle.Text = ""
    Handle.Size = UDim2.new(0, 15, 0, 15)
    Handle.Position = UDim2.new(Fill.Size.X.Scale, -7, 0.5, -7)
    Handle.BackgroundColor3 = ColorScheme.Text
    Handle.Parent = SliderContainer
    
    local Corner3 = Instance.new("UICorner")
    Corner3.CornerRadius = UDim.new(1, 0)
    Corner3.Parent = Handle
    
    -- Slider logic
    local dragging = false
    
    local function updateValue(value)
        local ratio = math.clamp((value - min) / (max - min), 0, 1)
        Fill.Size = UDim2.new(ratio, 0, 1, 0)
        Handle.Position = UDim2.new(ratio, -7, 0.5, -7)
        Label.Text = name .. ": " .. math.floor(value)
        
        -- Update game value
        if name == "Walk Speed" then
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = value
                end
            end
        elseif name == "Jump Power" then
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.JumpPower = value
                end
            end
        end
    end
    
    Handle.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    game:GetService("RunService").Heartbeat:Connect(function()
        if dragging then
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
            local relativeX = mousePos.X - Track.AbsolutePosition.X
            local ratio = math.clamp(relativeX / Track.AbsoluteSize.X, 0, 1)
            local value = min + (max - min) * ratio
            updateValue(value)
        end
    end)
    
    updateValue(default)
    return SliderContainer
end

function CreateToggle(name, default, parent, x, y)
    local ToggleContainer = Instance.new("Frame")
    ToggleContainer.Name = name.."Toggle"
    ToggleContainer.Size = UDim2.new(0.9, 0, 0, 40)
    ToggleContainer.Position = UDim2.new(0.05, 0, 0, y)
    ToggleContainer.BackgroundTransparency = 1
    ToggleContainer.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Text = name
    Label.TextColor3 = ColorScheme.Text
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleContainer
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Text = ""
    ToggleButton.Size = UDim2.new(0, 50, 0, 25)
    ToggleButton.Position = UDim2.new(1, -50, 0.5, -12.5)
    ToggleButton.BackgroundColor3 = default and ColorScheme.Accent or ColorScheme.Secondary
    ToggleButton.Parent = ToggleContainer
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.5, 0)
    Corner.Parent = ToggleButton
    
    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Name = "ToggleCircle"
    ToggleCircle.Size = UDim2.new(0, 20, 0, 20)
    ToggleCircle.Position = default and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    ToggleCircle.BackgroundColor3 = ColorScheme.Text
    ToggleCircle.Parent = ToggleButton
    
    local Corner2 = Instance.new("UICorner")
    Corner2.CornerRadius = UDim.new(1, 0)
    Corner2.Parent = ToggleCircle
    
    local state = default
    
    ToggleButton.MouseButton1Click:Connect(function()
        state = not state
        ToggleButton.BackgroundColor3 = state and ColorScheme.Accent or ColorScheme.Secondary
        ToggleCircle.Position = state and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
        
        -- Toggle functionality
        if name == "Noclip" then
            Noclip(state)
        elseif name == "Fly" then
            Fly(state)
        elseif name == "Player ESP" then
            ToggleESP(state)
        end
    end)
    
    return ToggleContainer
end

function CreateButton(name, parent, x, y)
    local Button = Instance.new("TextButton")
    Button.Name = name.."Button"
    Button.Text = name
    Button.TextColor3 = ColorScheme.Text
    Button.TextSize = 14
    Button.Font = Enum.Font.Gotham
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.Position = UDim2.new(0.05, 0, 0, y)
    Button.BackgroundColor3 = ColorScheme.Secondary
    Button.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Button
    
    -- Button functionality
    if name == "FPS Boost" then
        Button.MouseButton1Click:Connect(function()
            settings().Rendering.QualityLevel = 1
            for _, v in ipairs(game:GetDescendants()) do
                if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("Union") then
                    v.Material = Enum.Material.Plastic
                    v.Reflectance = 0
                elseif v:IsA("Decal") then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Enabled = false
                end
            end
        end)
    elseif name == "Server Hop" then
        Button.MouseButton1Click:Connect(function()
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end)
    elseif name == "Copy Discord" then
        Button.MouseButton1Click:Connect(function()
            setclipboard("discord.gg/example")
        end)
    end
    
    return Button
end

function MakeDraggable(dragPart, mainPart)
    local dragging = false
    local dragInput, mousePos, framePos

    dragPart.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = mainPart.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragPart.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            mainPart.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

-- Feature functions
function Noclip(state)
    if state then
        game:GetService("RunService").Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end

function Fly(state)
    -- Fly implementation would go here
end

function ToggleESP(state)
    -- ESP implementation would go here
end

-- Initialize GUI
CreateCeeshytamGUI()
