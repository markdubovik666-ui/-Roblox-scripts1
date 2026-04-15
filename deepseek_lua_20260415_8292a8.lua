loadstring([[
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local txt = Instance.new("TextBox")
local startBtn = Instance.new("TextButton")
local stopBtn = Instance.new("TextButton")
local status = Instance.new("TextLabel")
local drag = Instance.new("TextButton")
local on = false

gui.Parent = game.Players.LocalPlayer.PlayerGui
gui.Name = "AutoFarmGUI"

-- Основное окно
frame.Parent = gui
frame.Size = UDim2.new(0, 280, 0, 220)
frame.Position = UDim2.new(0.5, -140, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BackgroundTransparency = 0.15
frame.Active = true
frame.Draggable = true

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 15)

-- Заголовок
title.Parent = frame
title.Size = UDim2.new(0, 280, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🎁 AUTO CASE OPENER 🎁"
title.TextColor3 = Color3.fromRGB(255, 200, 100)
title.BackgroundTransparency = 1
title.TextSize = 18

-- Поле для ввода
txt.Parent = frame
txt.Size = UDim2.new(0, 240, 0, 45)
txt.Position = UDim2.new(0.5, -120, 0, 50)
txt.PlaceholderText = "📦 ВВЕДИ НАЗВАНИЕ КЕЙСА"
txt.Text = ""
txt.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
txt.TextColor3 = Color3.fromRGB(255, 255, 255)
txt.TextSize = 16

Instance.new("UICorner", txt).CornerRadius = UDim.new(0, 10)

-- Кнопка СТАРТ
startBtn.Parent = frame
startBtn.Size = UDim2.new(0, 110, 0, 50)
startBtn.Position = UDim2.new(0, 20, 0, 110)
startBtn.Text = "✅ СТАРТ"
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
startBtn.TextSize = 16

Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 10)

-- Кнопка СТОП
stopBtn.Parent = frame
stopBtn.Size = UDim2.new(0, 110, 0, 50)
stopBtn.Position = UDim2.new(0, 150, 0, 110)
stopBtn.Text = "⛔ СТОП"
stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
stopBtn.TextSize = 16

Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 10)

-- Статус
status.Parent = frame
status.Size = UDim2.new(0, 260, 0, 30)
status.Position = UDim2.new(0.5, -130, 0, 175)
status.Text = "🔴 СТАТУС: ОСТАНОВЛЕН"
status.TextColor3 = Color3.fromRGB(255, 100, 100)
status.BackgroundTransparency = 1
status.TextSize = 14

-- Функции
startBtn.MouseButton1Click:Connect(function()
    if txt.Text == "" then
        status.Text = "⚠️ ВВЕДИ НАЗВАНИЕ КЕЙСА!"
        status.TextColor3 = Color3.fromRGB(255, 200, 0)
        task.wait(1)
        status.Text = "🔴 СТАТУС: ОСТАНОВЛЕН"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    if not on then
        on = true
        status.Text = "🟢 СТАТУС: РАБОТАЕТ (кейс: " .. txt.Text .. ")"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
        startBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        
        while on do
            local success = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("OpenCase"):InvokeServer(txt.Text, 10)
            end)
            if not success then
                status.Text = "❌ ОШИБКА! Кейс не найден!"
                status.TextColor3 = Color3.fromRGB(255, 50, 50)
                on = false
                startBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                task.wait(2)
                status.Text = "🔴 СТАТУС: ОСТАНОВЛЕН"
                status.TextColor3 = Color3.fromRGB(255, 100, 100)
                break
            end
            task.wait(2)
        end
    end
end)

stopBtn.MouseButton1Click:Connect(function()
    if on then
        on = false
        status.Text = "🔴 СТАТУС: ОСТАНОВЛЕН"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
        startBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end
end)
]]])