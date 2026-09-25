-- ==============================================================================
-- 🚀 ZYNK MENU - DESIGN PREMIUM (BLUR LOADING + NOTIFICATIONS + DARK UI)
-- ==============================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 0. Limpeza de interfaces anteriores
for _, guiName in ipairs({"ZynkMenuGui", "ZynkHotbarGui", "ZynkLoadingGui", "ZynkNotifGui"}) do
	if playerGui:FindFirstChild(guiName) then playerGui[guiName]:Destroy() end
end
if Lighting:FindFirstChild("ZynkBlur") then Lighting.ZynkBlur:Destroy() end

--------------------------------------------------------------------------------
-- 🔔 SISTEMA DE NOTIFICAÇÕES AGLOMERADAS (STACKING NOTIFICATIONS)
--------------------------------------------------------------------------------
local notifGui = Instance.new("ScreenGui")
notifGui.Name = "ZynkNotifGui"
notifGui.ResetOnSpawn = false
notifGui.Parent = playerGui

local notifContainer = Instance.new("Frame")
notifContainer.Name = "NotifContainer"
notifContainer.Size = UDim2.new(0, 260, 1, -30)
notifContainer.Position = UDim2.new(1, -270, 0, 15)
notifContainer.BackgroundTransparency = 1
notifContainer.Parent = notifGui

local notifLayout = Instance.new("UIListLayout")
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notifLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifLayout.Padding = UDim.new(0, 8)
notifLayout.Parent = notifContainer

local function Notify(title, message, duration, accentColor)
	duration = duration or 3
	accentColor = accentColor or Color3.fromRGB(255, 255, 255)

	local card = Instance.new("CanvasGroup")
	card.Size = UDim2.new(0, 250, 0, 52)
	card.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
	card.GroupTransparency = 1
	card.Parent = notifContainer

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = card

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(45, 45, 58)
	stroke.Thickness = 1
	stroke.Parent = card

	-- Indicador Lateral de Cor
	local indicator = Instance.new("Frame")
	indicator.Size = UDim2.new(0, 3, 0, 28)
	indicator.Position = UDim2.new(0, 10, 0.5, -14)
	indicator.BackgroundColor3 = accentColor
	indicator.BorderSizePixel = 0
	indicator.Parent = card

	local indCorner = Instance.new("UICorner")
	indCorner.CornerRadius = UDim.new(1, 0)
	indCorner.Parent = indicator

	-- Título
	local tLbl = Instance.new("TextLabel")
	tLbl.Text = title
	tLbl.Font = Enum.Font.GothamBold
	tLbl.TextSize = 12
	tLbl.TextColor3 = Color3.fromRGB(240, 240, 245)
	tLbl.Position = UDim2.new(0, 22, 0, 8)
	tLbl.Size = UDim2.new(1, -30, 0, 16)
	tLbl.TextXAlignment = Enum.TextXAlignment.Left
	tLbl.BackgroundTransparency = 1
	tLbl.Parent = card

	-- Mensagem
	local mLbl = Instance.new("TextLabel")
	mLbl.Text = message
	mLbl.Font = Enum.Font.GothamMedium
	mLbl.TextSize = 11
	mLbl.TextColor3 = Color3.fromRGB(150, 150, 165)
	mLbl.Position = UDim2.new(0, 22, 0, 24)
	mLbl.Size = UDim2.new(1, -30, 0, 18)
	mLbl.TextXAlignment = Enum.TextXAlignment.Left
	mLbl.BackgroundTransparency = 1
	mLbl.Parent = card

	-- Animação de Entrada
	TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		GroupTransparency = 0
	}):Play()

	-- Remoção Automática após a Duração
	task.delay(duration, function()
		local fade = TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			GroupTransparency = 1
		})
		fade:Play()
		fade.Completed:Wait()
		card:Destroy()
	end)
end

--------------------------------------------------------------------------------
-- 1. TELA DE LOADING TRANSLÚCIDA COM BLUR
--------------------------------------------------------------------------------
local blur = Instance.new("BlurEffect")
blur.Name = "ZynkBlur"
blur.Size = 0
blur.Parent = Lighting

TweenService:Create(blur, TweenInfo.new(0.6), { Size = 20 }):Play()

local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "ZynkLoadingGui"
loadingGui.ResetOnSpawn = false
loadingGui.Parent = playerGui

local loadingBg = Instance.new("Frame")
loadingBg.Size = UDim2.new(1, 0, 1, 0)
loadingBg.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
loadingBg.BackgroundTransparency = 0.45 -- Translucido
loadingBg.Parent = loadingGui

local loadCard = Instance.new("CanvasGroup")
loadCard.Size = UDim2.new(0, 280, 0, 140)
loadCard.Position = UDim2.new(0.5, -140, 0.5, -70)
loadCard.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
loadCard.GroupTransparency = 1
loadCard.Parent = loadingBg

local loadCorner = Instance.new("UICorner")
loadCorner.CornerRadius = UDim.new(0, 16)
loadCorner.Parent = loadCard

local loadStroke = Instance.new("UIStroke")
loadStroke.Color = Color3.fromRGB(45, 45, 58)
loadStroke.Thickness = 1
loadStroke.Parent = loadCard

local loadTitle = Instance.new("TextLabel")
loadTitle.Text = "ZYNK MENU"
loadTitle.Font = Enum.Font.GothamBold
loadTitle.TextSize = 16
loadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loadTitle.Position = UDim2.new(0, 0, 0, 24)
loadTitle.Size = UDim2.new(1, 0, 0, 20)
loadTitle.BackgroundTransparency = 1
loadTitle.Parent = loadCard

local loadStatus = Instance.new("TextLabel")
loadStatus.Text = "Carregando módulos..."
loadStatus.Font = Enum.Font.GothamMedium
loadStatus.TextSize = 12
loadStatus.TextColor3 = Color3.fromRGB(140, 140, 155)
loadStatus.Position = UDim2.new(0, 0, 0, 48)
loadStatus.Size = UDim2.new(1, 0, 0, 18)
loadStatus.BackgroundTransparency = 1
loadStatus.Parent = loadCard

-- Barra de Progresso
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0, 200, 0, 6)
barBg.Position = UDim2.new(0.5, -100, 0, 82)
barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
barBg.Parent = loadCard

Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
barFill.Parent = barBg

Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

-- Animação da Entrada do Loading Card
TweenService:Create(loadCard, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	GroupTransparency = 0
}):Play()

local fillTween = TweenService:Create(barFill, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	Size = UDim2.new(1, 0, 1, 0)
})
fillTween:Play()

fillTween.Completed:Wait()
loadStatus.Text = "Pronto!"
task.wait(0.2)

-- Animação de Saída
TweenService:Create(blur, TweenInfo.new(0.5), { Size = 0 }):Play()
local outTween = TweenService:Create(loadCard, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
	GroupTransparency = 1
})
outTween:Play()
outTween.Completed:Wait()

loadingGui:Destroy()
blur:Destroy()

-- Disparar Notificação de Boas-Vindas
Notify("Zynk Menu", "Sistema carregado com sucesso!", 3, Color3.fromRGB(80, 220, 120))

--------------------------------------------------------------------------------
-- 2. HOTBAR FLUTUANTE (DESIGN MINIMALISTA)
--------------------------------------------------------------------------------
local hotbarGui = Instance.new("ScreenGui")
hotbarGui.Name = "ZynkHotbarGui"
hotbarGui.ResetOnSpawn = false
hotbarGui.Parent = playerGui

local hotbarFrame = Instance.new("Frame")
hotbarFrame.Size = UDim2.new(0, 280, 0, 46)
hotbarFrame.Position = UDim2.new(0.5, -140, 1, -65)
hotbarFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
hotbarFrame.Parent = hotbarGui

local hbCorner = Instance.new("UICorner")
hbCorner.CornerRadius = UDim.new(0, 12)
hbCorner.Parent = hotbarFrame

local hbStroke = Instance.new("UIStroke")
hbStroke.Color = Color3.fromRGB(45, 45, 58)
hbStroke.Thickness = 1
hbStroke.Parent = hotbarFrame

local hbLayout = Instance.new("UIListLayout")
hbLayout.FillDirection = Enum.FillDirection.Horizontal
hbLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
hbLayout.VerticalAlignment = Enum.VerticalAlignment.Center
hbLayout.Padding = UDim.new(0, 6)
hbLayout.Parent = hotbarFrame

for _, key in ipairs({ "Q", "1", "2", "3", "4", "E" }) do
	local slot = Instance.new("Frame")
	slot.Size = UDim2.new(0, 34, 0, 34)
	slot.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
	slot.Parent = hotbarFrame

	Instance.new("UICorner", slot).CornerRadius = UDim.new(0, 8)

	local lbl = Instance.new("TextLabel")
	lbl.Text = key
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 12
	lbl.TextColor3 = Color3.fromRGB(200, 200, 215)
	lbl.Size = UDim2.new(1, 0, 1, 0)
	lbl.BackgroundTransparency = 1
	lbl.Parent = slot
end

--------------------------------------------------------------------------------
-- 3. INTERFACE PRINCIPAL (REDESIGN BASEADO NAS REFERÊNCIAS)
--------------------------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZynkMenuGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("CanvasGroup")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 330)
mainFrame.Position = UDim2.new(0.5, -180, 0.45, -165)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.Active = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(45, 45, 58)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

-- Sistema de Arraste
local dragging, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 42)
topBar.BackgroundTransparency = 1
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "ZYNK MENU"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 13
titleLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
titleLabel.Size = UDim2.new(0, 150, 1, 0)
titleLabel.Position = UDim2.new(0, 16, 0, 0)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = topBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 16
minimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 195)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
minimizeBtn.Size = UDim2.new(0, 26, 0, 24)
minimizeBtn.Position = UDim2.new(1, -64, 0.5, -12)
minimizeBtn.Modal = true
minimizeBtn.Parent = topBar

Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)

local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 11
closeBtn.TextColor3 = Color3.fromRGB(240, 90, 90)
closeBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
closeBtn.Size = UDim2.new(0, 26, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0.5, -12)
closeBtn.Modal = true
closeBtn.Parent = topBar

Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

-- Content Container
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -24, 1, -100)
contentContainer.Position = UDim2.new(0, 12, 0, 42)
contentContainer.BackgroundTransparency = 1
contentContainer.ClipsDescendants = true
contentContainer.Parent = mainFrame

local function createPage(name)
	local page = Instance.new("CanvasGroup")
	page.Name = name .. "Page"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.GroupTransparency = 1
	page.Parent = contentContainer
	
	local list = Instance.new("UIListLayout")
	list.SortOrder = Enum.SortOrder.LayoutOrder
	list.Padding = UDim.new(0, 8)
	list.HorizontalAlignment = Enum.HorizontalAlignment.Center
	list.VerticalAlignment = Enum.VerticalAlignment.Center
	list.Parent = page

	return page
end

local principalPage = createPage("Principal")
local serverPage = createPage("Server")
local statusPage = createPage("Status")

--------------------------------------------------------------------------------
-- ⚙️ SCRIPT DOS CHEATS (NOCLIP, ESP, REGEN)
--------------------------------------------------------------------------------
local noclipEnabled, espEnabled, regenEnabled = false, false, false

RunService.Stepped:Connect(function()
	if noclipEnabled and player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
	end
end)

local function updateESP()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local highlight = p.Character:FindFirstChild("ZynkESP")
			if espEnabled then
				if not highlight then
					highlight = Instance.new("Highlight")
					highlight.Name = "ZynkESP"
					highlight.FillColor = Color3.fromRGB(255, 70, 70)
					highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
					highlight.Parent = p.Character
				end
			else
				if highlight then highlight:Destroy() end
			end
		end
	end
end

task.spawn(function()
	while true do
		task.wait(0.5)
		if regenEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
			local hum = player.Character.Humanoid
			if hum.Health < hum.MaxHealth and hum.Health > 0 then
				hum.Health = math.min(hum.MaxHealth, hum.Health + 3)
			end
		end
	end
end)

--------------------------------------------------------------------------------
-- 🎨 CRIAÇÃO DE ELEMENTOS VISUAIS
--------------------------------------------------------------------------------
local function createToggleCard(parentPage, text, callback)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 42)
	card.BackgroundColor3 = Color3.fromRGB(26, 26, 34)
	card.Parent = parentPage

	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(38, 38, 50)
	stroke.Thickness = 1
	stroke.Parent = card

	local lbl = Instance.new("TextLabel")
	lbl.Text = text
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextSize = 12
	lbl.TextColor3 = Color3.fromRGB(220, 220, 230)
	lbl.Size = UDim2.new(0.6, 0, 1, 0)
	lbl.Position = UDim2.new(0, 12, 0, 0)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.BackgroundTransparency = 1
	lbl.Parent = card

	local btn = Instance.new("TextButton")
	btn.Text = "OFF"
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 11
	btn.TextColor3 = Color3.fromRGB(150, 150, 165)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 46)
	btn.Size = UDim2.new(0, 50, 0, 24)
	btn.Position = UDim2.new(1, -60, 0.5, -12)
	btn.Modal = true
	btn.Parent = card

	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = state and "ON" or "OFF"
		btn.TextColor3 = state and Color3.fromRGB(18, 18, 24) or Color3.fromRGB(150, 150, 165)
		btn.BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(35, 35, 46)
		
		Notify(text, state and "Ativado com sucesso" or "Desativado", 2.5, state and Color3.fromRGB(100, 220, 120) or Color3.fromRGB(240, 90, 90))
		callback(state)
	end)

	return card
end

createToggleCard(principalPage, "No Clip", function(val) noclipEnabled = val end)
createToggleCard(principalPage, "ESP Jogadores", function(val) espEnabled = val; updateESP() end)
createToggleCard(principalPage, "Regen de Vida", function(val) regenEnabled = val end)

local function createStatusCard(icon, defaultText)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 42)
	card.BackgroundColor3 = Color3.fromRGB(26, 26, 34)
	card.Parent = statusPage

	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(38, 38, 50)
	stroke.Thickness = 1
	stroke.Parent = card

	local label = Instance.new("TextLabel")
	label.Text = icon .. "  " .. defaultText
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 12
	label.TextColor3 = Color3.fromRGB(220, 220, 230)
	label.Size = UDim2.new(1, -20, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.BackgroundTransparency = 1
	label.Parent = card

	return label
end

local fpsLabel = createStatusCard("⚡", "FPS: --")
local pingLabel = createStatusCard("📡", "Ping: -- ms")
local playersLabel = createStatusCard("👥", "Jogadores: --/--")

--------------------------------------------------------------------------------
-- 🎞️ ANIMAÇÃO SEQUENCIAL (GERAR 1 DE CADA VEZ)
--------------------------------------------------------------------------------
local function animatePageElements(page)
	for _, child in ipairs(page:GetChildren()) do
		if child:IsA("Frame") then
			child.Position = UDim2.new(0, 0, 0.08, 0)
			child.BackgroundTransparency = 1
			for _, desc in pairs(child:GetDescendants()) do
				if desc:IsA("TextLabel") or desc:IsA("TextButton") then
					desc.TextTransparency = 1
				end
			end
		end
	end

	task.spawn(function()
		for _, child in ipairs(page:GetChildren()) do
			if child:IsA("Frame") then
				TweenService:Create(child, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(0, 0, 0, 0),
					BackgroundTransparency = 0
				}):Play()

				for _, desc in pairs(child:GetDescendants()) do
					if desc:IsA("TextLabel") or desc:IsA("TextButton") then
						TweenService:Create(desc, TweenInfo.new(0.2), { TextTransparency = 0 }):Play()
					end
				end
				task.wait(0.07) -- Delay da geração 1 por 1
			end
		end
	end)
end

--------------------------------------------------------------------------------
-- 📊 TAB BAR & NAVEGAÇÃO
--------------------------------------------------------------------------------
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -24, 0, 42)
tabBar.Position = UDim2.new(0, 12, 1, -52)
tabBar.BackgroundColor3 = Color3.fromRGB(26, 26, 34)
tabBar.Parent = mainFrame

Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0, 10)

local tabStroke = Instance.new("UIStroke")
tabStroke.Color = Color3.fromRGB(38, 38, 50)
tabStroke.Thickness = 1
tabStroke.Parent = tabBar

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Padding = UDim.new(0, 4)
tabLayout.Parent = tabBar

local function createTabButton(name)
	local btn = Instance.new("TextButton")
	btn.Text = name
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 12
	btn.TextColor3 = Color3.fromRGB(140, 140, 155)
	btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundTransparency = 1
	btn.Size = UDim2.new(0.31, 0, 0.82, 0)
	btn.Modal = true
	btn.Parent = tabBar

	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	return btn
end

local principalBtn = createTabButton("Principal")
local serverBtn = createTabButton("Server")
local statusBtn = createTabButton("Status")

local currentPage = principalPage
currentPage.Visible = true
currentPage.GroupTransparency = 0
principalBtn.BackgroundTransparency = 0
principalBtn.TextColor3 = Color3.fromRGB(18, 18, 24)
animatePageElements(principalPage)

local function switchTab(targetPage, targetBtn)
	if currentPage == targetPage then return end
	
	currentPage.Visible = false
	currentPage.GroupTransparency = 1
	
	currentPage = targetPage
	targetPage.Visible = true
	targetPage.GroupTransparency = 0
	
	for _, btn in pairs({principalBtn, serverBtn, statusBtn}) do
		btn.BackgroundTransparency = 1
		btn.TextColor3 = Color3.fromRGB(140, 140, 155)
	end
	targetBtn.BackgroundTransparency = 0
	targetBtn.TextColor3 = Color3.fromRGB(18, 18, 24)

	animatePageElements(targetPage)
end

principalBtn.MouseButton1Click:Connect(function() switchTab(principalPage, principalBtn) end)
serverBtn.MouseButton1Click:Connect(function() switchTab(serverPage, serverBtn) end)
statusBtn.MouseButton1Click:Connect(function() switchTab(statusPage, statusBtn) end)

-- Loop de Atualização de Status
local frameCount = 0
local lastCheck = tick()
RunService.RenderStepped:Connect(function()
	frameCount += 1
	local now = tick()
	if now - lastCheck >= 1 then
		fpsLabel.Text = "⚡  FPS: " .. tostring(frameCount)
		frameCount = 0
		lastCheck = now
		pingLabel.Text = "📡  Ping: " .. tostring(math.round(player:GetNetworkPing() * 1000)) .. " ms"
		playersLabel.Text = "👥  Jogadores: " .. tostring(#Players:GetPlayers()) .. " / " .. tostring(Players.MaxPlayers)
	end
end)

-- Minimizar e Fechar
local isMinimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = isMinimized and UDim2.new(0, 360, 0, 42) or UDim2.new(0, 360, 0, 330)
	}):Play()
	contentContainer.Visible = not isMinimized
	tabBar.Visible = not isMinimized
end)

closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
	hotbarGui:Destroy()
	notifGui:Destroy()
end)

print("✅ [Zynk Menu] Atualizado com o Novo Visual Premium!")
