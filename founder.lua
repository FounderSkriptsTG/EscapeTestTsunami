-- 🌊 Tsunami Mobile Script | Только для телефона
-- Работает на Delta Executor Mobile

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Простая кнопка запуска (внизу экрана)
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.IgnoreGuiInset = true

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 100, 0, 100)
btn.Position = UDim2.new(0.9, 0, 0.8, 0)
btn.BackgroundColor3 = Color3.new(0, 1, 0.5)
btn.Text = "ON"
btn.TextScaled = true
btn.Font = Enum.Font.SourceSansBold
btn.TextColor3 = Color3.new(1,1,1)
btn.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1,0)
corner.Parent = btn

-- Настройки
local farmOn = false
local moneyOn = false
local godOn = true
local wallsOn = true

btn.MouseButton1Click:Connect(function()
    farmOn = not farmOn
    moneyOn = not moneyOn
    godOn = true
    wallsOn = true
    
    btn.Text = farmOn and "FARM ON" or "FARM OFF"
    btn.BackgroundColor3 = farmOn and Color3.new(0,1,0) or Color3.new(1,0.3,0.3)
end)

-- УДАЛЕНИЕ VIP СТЕН (ВСЕГДА РАБОТАЕТ)
spawn(function()
    while true do
        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                local name = part.Name:lower()
                if name:find("vip") or name:find("wall") or name:find("barrier") then
                    part.CanCollide = false
                    part.Transparency = 1
                end
            end
        end
        wait(2)
    end
end)

-- БЕССМЕРТИЕ (ВСЕГДА ВКЛ)
spawn(function()
    while true do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 100
        end
        wait(0.2)
    end
end)

-- АВТОФАРМ (ОЧЕНЬ ПРОСТОЙ)
spawn(function()
    while true do
        if farmOn then
            pcall(function()
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                
                    -- Ищем всё что можно собрать
                    for _, obj in pairs(Workspace:GetChildren()) do
                        local dist = (char.HumanoidRootPart.Position - obj.Position).Magnitude
                        if dist < 100 and (obj.Name:lower():find("brain") or obj.Name:lower():find("collect") or obj:FindFirstChild("ClickDetector")) then
                            -- ТП и сбор
                            char.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0,10,0)
                            wait()
                            if obj:FindFirstChildOfClass("ClickDetector") then
                                fireclickdetector(obj:FindFirstChildOfClass("ClickDetector"))
                            end
                        end
                    end
                end
            end)
        end
        wait(0.05)
    end
end)

-- АВТО ДЕНЬГИ
spawn(function()
    while true do
        if moneyOn or farmOn then
            pcall(function()
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    for _, obj in pairs(Workspace:GetChildren()) do
                        local dist = (char.HumanoidRootPart.Position - obj.Position).Magnitude
                        if dist < 80 and (obj.Name:lower():find("money") or obj.Name:lower():find("coin") or obj.Name:lower():find("cash")) then
                            char.HumanoidRootPart.CFrame = obj.CFrame
                            if obj:FindFirstChildOfClass("ClickDetector") then
                                fireclickdetector(obj:FindFirstChildOfClass("ClickDetector"))
                            end
                        end
                    end
                end
            end)
        end
        wait(0.1)
    end
end)

print("🌊 Tsunami Mobile Script готов!")
print("👆 Зеленая кнопка внизу справа = ВКЛ ФАРМ")
