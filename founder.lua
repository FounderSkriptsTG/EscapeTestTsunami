-- 🌊 Tsunami Hub | Founder Scripts 🌊
-- 💎 Поддержка: Delta Executor | PC & Mobile
-- 📱 Работает на всех устройствах | АвтоФарм | Бессмертие | Удаление VIP Стен
-- 🔗 Telegram: @FounderScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Переменные
local Tsunami = Workspace:WaitForChild("Tsunami")
local VIPWalls = Workspace:FindFirstChild("VIPWalls") or Workspace.VIP
local Brainrots = Workspace:FindFirstChild("Brainrots") or Workspace.Collectibles
local MoneyOrbs = Workspace:FindFirstChild("Money") or Workspace.Orbs

local Config = {
    AutoFarm = false,
    AutoCollectMoney = false,
    GodMode = true,
    RemoveVIPWalls = true,
    AutoTPFarm = false
}

-- GUI Создание
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local ToggleFarm = Instance.new("TextButton")
local ToggleMoney = Instance.new("TextButton")
local ToggleGod = Instance.new("TextButton")
local ToggleWalls = Instance.new("TextButton")
local ToggleTPFarm = Instance.new("TextButton")
local TelegramBtn = Instance.new("TextButton")
local Credits = Instance.new("TextLabel")

ScreenGui.Name = "TsunamiHub"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Главное окно
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Visible = false

-- Скругление
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Тень
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Parent = MainFrame
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0, -10, 0, 10)
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.7
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)

-- Заголовок
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 20, 0, 15)
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "🌊 TSUNAMI HUB 🌊"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка закрытия
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -45, 0, 15)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextScaled = true

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- Функция кнопки (зеленая/красная)
local function CreateToggle(parent, text, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Name = text
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = "✅ " .. text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 220, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 180, 40))
    }
    gradient.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        callback()
        btn.BackgroundColor3 = btn.BackgroundColor3 == Color3.fromRGB(50, 200, 50) and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(50, 200, 50)
        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, btn.BackgroundColor3),
            ColorSequenceKeypoint.new(1, btn.BackgroundColor3:lerp(Color3.new(0,0,0), 0.3))
        }
    end)
    
    return btn
end

-- Telegram кнопка
local TelegramBtn = Instance.new("TextButton")
TelegramBtn.Name = "Telegram"
TelegramBtn.Parent = MainFrame
TelegramBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
TelegramBtn.BorderSizePixel = 0
TelegramBtn.Position = UDim2.new(0.05, 0, 0, 250)
TelegramBtn.Size = UDim2.new(0.9, 0, 0, 40)
TelegramBtn.Font = Enum.Font.GothamBold
TelegramBtn.Text = "📱 Telegram: @FounderScripts"
TelegramBtn.TextColor3 = Color3.new(1,1,1)
TelegramBtn.TextScaled = true

local TgCorner = Instance.new("UICorner")
TgCorner.CornerRadius = UDim.new(0, 8)
TgCorner.Parent = TelegramBtn

-- Кредиты
Credits.Name = "Credits"
Credits.Parent = MainFrame
Credits.BackgroundTransparency = 1
Credits.Position = UDim2.new(0, 10, 1, -25)
Credits.Size = UDim2.new(1, -20, 0, 20)
Credits.Font = Enum.Font.Gotham
Credits.Text = "💎 Founder Scripts | Delta Compatible"
Credits.TextColor3 = Color3.fromRGB(150, 150, 150)
Credits.TextScaled = true
Credits.TextXAlignment = Enum.TextXAlignment.Center

-- Создание кнопок
ToggleFarm = CreateToggle(MainFrame, "Auto Farm Brainrots", 60, function()
    Config.AutoFarm = not Config.AutoFarm
end)

ToggleMoney = CreateToggle(MainFrame, "Auto Collect Money", 110, function()
    Config.AutoCollectMoney = not Config.AutoCollectMoney
end)

ToggleGod = CreateToggle(MainFrame, "God Mode (Waves)", 160, function()
    Config.GodMode = not Config.GodMode
end)

ToggleWalls = CreateToggle(MainFrame, "Remove VIP Walls", 60, function()
    Config.RemoveVIPWalls = not Config.RemoveVIPWalls
    RemoveVIPWalls()
end)

ToggleTPFarm = CreateToggle(MainFrame, "Auto TP Farm", 110, function()
    Config.AutoTPFarm = not Config.AutoTPFarm
end)

-- Анимация открытия/закрытия
local function TweenFrame(target, goal)
    local tween = TweenService:Create(target, TweenInfo.new(0.3, Enum.EasingStyle.Back), goal)
    tween:Play()
end

-- Открыть/Закрыть GUI
local GuiOpen = false
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        GuiOpen = not GuiOpen
        MainFrame.Visible = GuiOpen
        if GuiOpen then
            TweenFrame(MainFrame, {Size = UDim2.new(0, 400, 0, 300)})
        else
            TweenFrame(MainFrame, {Size = UDim2.new(0, 0, 0, 0)})
        end
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    TweenFrame(MainFrame, {Size = UDim2.new(0, 0, 0, 0)})
    wait(0.3)
    MainFrame.Visible = false
    GuiOpen = false
end)

-- ОСНОВНЫЕ ФУНКЦИИ

-- Удаление VIP стен
function RemoveVIPWalls()
    if not Config.RemoveVIPWalls then return end
    
    for _, wall in pairs(Workspace:GetDescendants()) do
        if wall.Name:lower():find("vip") or wall.Name:lower():find("wall") or wall:FindFirstChild("VIP") then
            if wall:IsA("BasePart") and wall.CanCollide then
                wall.CanCollide = false
                wall.Transparency = 1
                wall.Material = Enum.Material.ForceField
            end
        end
    end
end

-- Бессмертие от волн
function GodMode()
    if not Config.GodMode then return end
    
    LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
    
    -- Защита от урона волны
    for _, part in pairs(Tsunami:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Touched:Connect(function(hit)
                if hit.Parent == LocalPlayer.Character then
                    LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
                end
            end)
        end
    end
end

-- Авто фарм брейнротов с ТП
local function AutoFarmBrainrots()
    if not Config.AutoFarm and not Config.AutoTPFarm then return end
    
    spawn(function()
        while Config.AutoFarm or Config.AutoTPFarm do
            local closestBrainrot = nil
            local shortestDistance = math.huge
            
            -- Поиск ближайшего брейнрота
            for _, brainrot in pairs(Brainrots:GetChildren()) do
                if brainrot:IsA("BasePart") or brainrot:FindFirstChild("HumanoidRootPart") then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - brainrot.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestBrainrot = brainrot
                    end
                end
            end
            
            if closestBrainrot and shortestDistance < 500 then
                -- Быстрое ТП
                LocalPlayer.Character.HumanoidRootPart.CFrame = closestBrainrot.CFrame * CFrame.new(0, 5, 0)
                wait(0.1)
                
                -- Кликер для сбора
                fireclickdetector(closestBrainrot:FindFirstChildOfClass("ClickDetector"))
                firesignal(closestBrainrot.Touched, LocalPlayer.Character.HumanoidRootPart)
                
                -- ТП назад если нужно
                if Config.AutoTPFarm then
                    wait(0.2)
                    LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)
                end
            end
            
            wait(0.05) -- Супер быстрая скорость
        end
    end)
end

-- Авто сбор денег
local function AutoCollectMoney()
    if not Config.AutoCollectMoney then return end
    
    spawn(function()
        while Config.AutoCollectMoney do
            for _, orb in pairs(MoneyOrbs:GetChildren()) do
                if orb:IsA("BasePart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = orb.CFrame
                    fireclickdetector(orb:FindFirstChildOfClass("ClickDetector"))
                end
            end
            wait(0.1)
        end
    end)
end

-- Основной цикл
spawn(function()
    while true do
        RemoveVIPWalls()
        GodMode()
        AutoFarmBrainrots()
        AutoCollectMoney()
        wait(0.1)
    end
end)

-- Авто подключение при респавне
LocalPlayer.CharacterAdded:Connect(function()
    wait(2)
    RemoveVIPWalls()
end)

print("🌊 Tsunami Hub загружен! Нажми INSERT для открытия")
print("📱 Telegram: @FounderScripts")
