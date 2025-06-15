--[[
  Ceeshytam Hub - Improved Version
  Created by goroiz
  Version: 2.0
  No Key System
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

-- Tema warna coklat
local ColorScheme = {
    Main = Color3.fromRGB(139, 69, 19),   -- SaddleBrown
    Secondary = Color3.fromRGB(160, 82, 45), -- Sienna
    Background = Color3.fromRGB(40, 30, 20),
    Text = Color3.fromRGB(255, 250, 240),  -- FloralWhite
    Accent = Color3.fromRGB(210, 105, 30)  -- Chocolate
}

-- Variabel global untuk GUI
local ScreenGui = nil
local MainFrame = nil
local Minimized = false

-- Fungsi untuk membuat GUI
local function CreateCeeshytamGUI()
    if ScreenGui then ScreenGui:Destroy() end
    
    -- Main ScreenGui
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CeeshytamHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game.CoreGui

    -- Main Frame
    MainFrame = Instance.new("Frame")
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

    -- Tombol Minimize
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = ColorScheme.Text
    MinimizeButton.TextSize = 18
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
    MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Parent = Header

    MinimizeButton.MouseButton1Click:Connect(function()
        if Minimized then
            MainFrame.Size = UDim2.new(0, 400, 0, 400)
            Minimized = false
        else
            MainFrame.Size = UDim2.new(0, 400, 0, 40)
            Minimized = true
        end
    end)

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
        ScreenGui = nil
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
    
    local FlyToggle = CreateToggle("Fly", false, PlayerTab, 10, 130)
    local NoclipToggle = CreateToggle("Noclip", false, PlayerTab, 10, 180)
    
    local ResetButton = CreateButton("Reset Character", PlayerTab, 10, 250)
    
    ResetButton.MouseButton1Click:Connect(function()
        if LocalPlayer.Character then
            LocalPlayer.Character:BreakJoints()
        end
    end)

    -- Teleport Tab
    local TeleportTab = Instance.new("Frame")
    TeleportTab.Name = "TeleportTab"
    TeleportTab.Size = UDim2.new(1, 0, 1, 0)
    TeleportTab.Position = UDim2.new(0, 0, 0, 0)
    TeleportTab.BackgroundTransparency = 1
    TeleportTab.Visible = false
    TeleportTab.Parent = TabContainer

    -- Teleport Locations
    local TeleportLocations = {
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
        end}
    }

    -- Teleport to Player
    local PlayerList = Instance.new("Frame")
    PlayerList.Name = "PlayerList"
    PlayerList.Size = UDim2.new(0.9, 0, 0, 30)
    PlayerList.Position = UDim2.new(0.05, 0, 0, 160)
    PlayerList.BackgroundColor3 = ColorScheme.Secondary
    PlayerList.Parent = TeleportTab
    
    local CornerPlayer = Instance.new("UICorner")
    CornerPlayer.CornerRadius = UDim.new(0, 6)
    CornerPlayer.Parent = PlayerList
    
    local PlayerDropdown = Instance.new("TextButton")
    PlayerDropdown.Name = "PlayerDropdown"
    PlayerDropdown.Text = "Select Player"
    PlayerDropdown.TextColor3 = ColorScheme.Text
    PlayerDropdown.TextSize = 14
    PlayerDropdown.Font = Enum.Font.Gotham
    PlayerDropdown.Size = UDim2.new(1, 0, 1, 0)
    PlayerDropdown.BackgroundTransparency = 1
    PlayerDropdown.Parent = PlayerList
    
    local PlayerScroll = Instance.new("ScrollingFrame")
    PlayerScroll.Name = "PlayerScroll"
    PlayerScroll.Size = UDim2.new(1, 0, 0, 150)
    PlayerScroll.Position = UDim2.new(0, 0, 1, 0)
    PlayerScroll.BackgroundColor3 = ColorScheme.Background
    PlayerScroll.Visible = false
    PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    PlayerScroll.Parent = PlayerList
    
    PlayerDropdown.MouseButton1Click:Connect(function()
        PlayerScroll.Visible = not PlayerScroll.Visible
        if PlayerScroll.Visible then
            PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 30)
            PlayerScroll:ClearAllChildren()
            
            for i, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local PlayerBtn = Instance.new("TextButton")
                    PlayerBtn.Name = player.Name
                    PlayerBtn.Text = player.Name
                    PlayerBtn.TextColor3 = ColorScheme.Text
                    PlayerBtn.TextSize = 14
                    PlayerBtn.Font = Enum.Font.Gotham
                    PlayerBtn.Size = UDim2.new(1, 0, 0, 30)
                    PlayerBtn.Position = UDim2.new(0, 0, 0, (i-1)*30)
                    PlayerBtn.BackgroundColor3 = ColorScheme.Secondary
                    PlayerBtn.Parent = PlayerScroll
                    
                    PlayerBtn.MouseButton1Click:Connect(function()
                        PlayerDropdown.Text = player.Name
                        PlayerScroll.Visible = false
                    end)
                end
            end
        end
    end)
    
    local TeleportPlayerBtn = CreateButton("TP to Player", TeleportTab, 10, 200)
    TeleportPlayerBtn.MouseButton1Click:Connect(function()
        local targetName = PlayerDropdown.Text
        if targetName ~= "Select Player" then
            local target = Players:FindFirstChild(targetName)
            if target and target.Character then
                local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    LocalPlayer.Character:MoveTo(hrp.Position)
                end
            end
        end
    end)

    -- Visuals Tab
    local VisualsTab = Instance.new("Frame")
    VisualsTab.Name = "VisualsTab"
    VisualsTab.Size = UDim2.new(1, 0, 1, 0)
    VisualsTab.Position = UDim2.new(0, 0, 0, 0)
    VisualsTab.BackgroundTransparency = 1
    VisualsTab.Visible = false
    VisualsTab.Parent = TabContainer

    -- Visuals Tab Content
    CreateToggle("Player ESP", false, VisualsTab, 10, 10)
    CreateToggle("Tracers", false, VisualsTab, 10, 60)
    CreateToggle("Fullbright", false, VisualsTab, 10, 110)

    -- Misc Tab
    local MiscTab = Instance.new("Frame")
    MiscTab.Name = "MiscTab"
    MiscTab.Size = UDim2.new(1, 0, 1, 0)
    MiscTab.Position = UDim2.new(0, 0, 0, 0)
    MiscTab.BackgroundTransparency = 1
    MiscTab.Visible = false
    MiscTab.Parent = TabContainer

    -- Misc Tab Content
    CreateButton("FPS Boost", MiscTab, 10, 10).MouseButton1Click:Connect(function()
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
    
    CreateButton("Server Hop", MiscTab, 10, 70).MouseButton1Click:Connect(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end)
    
    CreateButton("Copy Discord", MiscTab, 10, 130).MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/ceeshytam")
    end)

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
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    game:GetService("RunService").Heartbeat:Connect(function()
        if dragging then
            local mousePos = UserInputService:GetMouseLocation()
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
    
    return Button
end

-- Fungsi draggable yang diperbaiki
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

    UserInputService.InputChanged:Connect(function(input)
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

-- Toggle GUI dengan F5
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.F5 and not gameProcessed then
        if ScreenGui then
            ScreenGui:Destroy()
            ScreenGui = nil
        else
            CreateCeeshytamGUI()
        end
    end
end)

-- Initialize GUI
CreateCeeshytamGUI()
