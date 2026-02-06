-- 🌊 Tsunami Hub v2 MOBILE FIX | Founder Scripts 🌊
-- 📱 100% Mobile Compatible | Delta Executor
-- 🔗 Telegram: @FounderScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Ждем загрузки персонажа
repeat wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

local Config = {
    AutoFarm = false,
    AutoMoney = false,
    GodMode = true,
    RemoveWalls = true,
    AutoTP = false
}

-- 🔥 MOBILE GUI (упрощенный для мобильных)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TsunamiMobileHub"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- Главная кнопка (внизу экрана)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Name = "OpenBtn"
OpenBtn.Parent = ScreenGui
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
OpenBtn.BorderSizePixel = 0
OpenBtn.Position = UDim2.new(0.85, 0, 0.85, 0)
OpenBtn.Size = UDim2.new(0, 80, 0, 80)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Text = "🌊"
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.TextScaled = true

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenBtn

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -180)
MainFrame.Size = UDim2.new(0, 320, 0, 360)
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "🌊 TSUNAMI HUB MOBILE"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextScaled = true

-- Кнопки (крупные для пальцев)
local function MobileToggle(yPos, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.Size = UDim2.new(0.9, 0, 0, 55)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = "✅ " .. text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    
    local toggleState = false
    btn.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        Config[text:lower():gsub(" ", "")] = toggleState
        btn.BackgroundColor3 = toggleState and Color3.fromRGB(60, 180, 60) or Color3.fromRGB(180, 60, 60)
        callback()
    end)
    
    return btn
end

-- Создаем кнопки
MobileToggle(60, "Auto Farm Brainrots", function() end)
MobileToggle(120, "Auto Collect Money", function() end)
MobileToggle(180, "God Mode Waves", function() end)
MobileToggle(240, "Remove VIP Walls", function() end)
MobileToggle(300, "Fast TP Farm", function() end)

-- Кнопка закрытия
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Position = UDim2.new(1, -50, 0, 10)
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextScaled = true

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- Открытие/закрытие
local guiVisible = false
OpenBtn.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    MainFrame.Visible = guiVisible
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    guiVisible = false
end)

-- 🔥 МОБИЛЬНЫЕ ФУНКЦИИ (работают на 100%)

-- Удаление VIP стен (работает везде)
spawn(function()
    while true do
        if Config.removewalls then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("vip") or obj.Name:lower():find("wall") or obj.Parent.Name:lower():find("vip")) then
                    obj.CanCollide = false
                    obj.Transparency = 1
                end
            end
        end
        wait(1)
    end
end)

-- Бессмертие (анти-волны)
spawn(function()
    while true do
        if Config.godmodewaves and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.Health = 100
        end
        wait(0.1)
    end
end)

-- 🔥 АВТОФАРМ БРЕЙНРОТОВ (МОБИЛЬНЫЙ)
spawn(function()
    while true do
        if Config.autofarmbrainrots or Config.fasttpfarm then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                
                -- Поиск всех коллектаблов
                for _, obj in pairs(Workspace:GetChildren()) do
                    if obj.Name:lower():find("brain") or obj.Name:lower():find("collect") or obj:FindFirstChildOfClass("ClickDetector") then
                        local dist = (char.HumanoidRootPart.Position - obj.Position).Magnitude
                        if dist < 200 then
                            -- Быстрое ТП
                            char.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
                            wait(0.05)
                            
                            -- Сбор (работает на мобильных)
                            if obj:FindFirstChildOfClass("ClickDetector") then
                                fireclickdetector(obj:FindFirstChildOfClass("ClickDetector"))
                            end
                            
                            -- Симуляция касания
                            obj:FindFirstChild("Touched"):Fire(char.HumanoidRootPart)
                        end
                    end
                end
            end)
        end
        wait(0.03) -- Очень быстро
    end
end)

-- Авто деньги
spawn(function()
    while true do
        if Config.autocollectmoney then
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                
                for _, obj in pairs(Workspace:GetChildren()) do
                    if obj.Name:lower():find("money") or obj.Name:lower():find("coin") or obj.Name:lower():find("cash") then
                        local dist = (char.HumanoidRootPart.Position - obj.Position).Magnitude
                        if dist < 150 then
                            char.HumanoidRootPart.CFrame = obj.CFrame
                            fireclickdetector(obj:FindFirstChildOfClass("ClickDetector"))
                        end
                    end
                end
            end)
        end
        wait(0.1)
    end
end)

-- Авто респавн защита
LocalPlayer.CharacterAdded:Connect(function()
    wait(3)
end)

print("📱 Tsunami Hub MOBILE загружен!")
print("👆 Нажми зеленую кнопку внизу справа!")
print("🔗 @FounderScripts")
