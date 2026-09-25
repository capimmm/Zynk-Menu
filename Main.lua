-- ==============================================================================
-- 🚀 ZYNK MENU - SISTEMA COMPLETO (LOADING + HACKS + HOTBAR + ANIMATION)
-- ==============================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Destruir interfaces antigas para evitar duplicidade
if playerGui:FindFirstChild("ZynkMenuGui") then playerGui.ZynkMenuGui:Destroy() end
if playerGui:FindFirstChild("ZynkHotbarGui") then playerGui.ZynkHotbarGui:Destroy() end
if playerGui:FindFirstChild("ZynkLoadingGui") then playerGui.ZynkLoadingGui:Destroy() end

--------------------------------------------------------------------------------
-- 1. TELA DE LOADING (LOADING SCREEN)
--------------------------------------------------------------------------------
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "ZynkLoadingGui"
loadingGui.ResetOnSpawn = false
loadingGui.Parent = playerGui

local loadingBg = Instance.new("Frame")
loadingBg.Size = UDim2.new(1, 0, 1, 0)
loadingBg.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
loadingBg.Parent = loadingGui

local loadingTitle = Instance.new("TextLabel")
loadingTitle.Text = "ZYNK MENU"
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.TextSize = 28
loadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingTitle.Size = UDim2.new(1, 0, 0, 40)
loadingTitle.Position = UDim2.new(0, 0, 0.4, -30)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Parent = loadingBg

local loadingSub = Instance.new("TextLabel")
loadingSub.Text = "Carregando módulos..."
loadingSub.Font = Enum.Font.GothamMedium
loadingSub.TextSize = 14
loadingSub.TextColor3 = Color3.fromRGB(150, 150, 160)
loadingSub.Size = UDim2.new(1, 0, 0, 20)
loadingSub.Position = UDim2.new(0, 0, 0.4, 15)
loadingSub.BackgroundTransparency = 1
loadingSub.Parent = loadingBg

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0, 260, 0, 8)
barBg.Position = UDim2.new(0.5, -130, 0.4, 50)
barBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
barBg.Parent = loadingBg

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBg

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(90, 120, 255)
barFill.Parent = barBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = barFill

-- Animação da barra de carregamento
local fillTween = TweenService:Create(barFill, TweenInfo.new(1.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	Size = UDim2.new(1, 0, 1, 0)
})
fillTween:Play()

fillTween.Completed:Wait()
loadingSub.Text = "Pronto!"
task.wait(0.3)

-- Smooth Fade-out da tela de loading
for i = 0, 1, 0.1 do
	loadingBg.BackgroundTransparency = i
	loadingTitle.TextTransparency = i
	loadingSub.TextTransparency = i
	barBg.BackgroundTransparency = i
	barFill.BackgroundTransparency = i
	task.wait(0.02)
end
loadingGui:Destroy()

--------------------------------------------------------------------------------
-- 2. HOTBAR FLUTUANTE
--------------------------------------------------------------------------------
local hotbarGui = Instance.new("ScreenGui")
hotbarGui.Name = "ZynkHotbarGui"
hotbarGui.ResetOnSpawn = false
hotbarGui.Parent = playerGui

local hotbarFrame = Instance.new("Frame")
hotbarFrame.Name = "HotbarFrame"
hotbarFrame.Size = UDim2.new(0, 320, 0, 50)
hotbarFrame.Position = UDim2.new(0.5, -160, 1, -70)
hotbarFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
hotbarFrame.Parent = hotbarGui

local hbCorner = Instance.new("UICorner")
hbCorner.CornerRadius = UDim.new(0, 12)
hbCorner.Parent = hotbarFrame

local hbStroke = Instance.new("UIStroke")
hbStroke.Color = Color3.fromRGB(50, 50, 60)
hbStroke.Thickness = 1.5
hbStroke.Parent = hotbarFrame

local hbLayout = Instance.new("UIListLayout")
hbLayout.FillDirection = Enum.FillDirection.Horizontal
hbLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
hbLayout.VerticalAlignment = Enum.VerticalAlignment.Center
hbLayout.Padding = UDim.new(0, 8)
hbLayout.Parent = hotbarFrame

local hotbarSlots = { "Q", "1", "2", "3", "4", "E" }

for _, key in ipairs(hotbarSlots) do
	local slot = Instance.new("Frame")
	slot.Size = UDim2.new(0, 38, 0, 38)
	slot.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	slot.Parent = hotbarFrame

	local sCorner = Instance.new("UICorner")
	sCorner.CornerRadius = UDim.new(0, 8)
	sCorner.Parent = slot

	local lbl = Instance.new("TextLabel")
	lbl.Text = key
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 14
	lbl.TextColor3 = Color3.fromRGB(220, 220, 230)
	lbl.Size = UDim2.new(1, 0, 1, 0)
	lbl.BackgroundTransparency = 1
	lbl.Parent = slot
end

--------------------------------------------------------------------------------
-- 3. INTERFACE PRINCIPAL DO MENU
--------------------------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZynkMenuGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("CanvasGroup")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 340)
mainFrame.Position = UDim2.new(0.5, -180, 0.45, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(242, 243, 245)
mainFrame.Active = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

-- Arrastar Menu
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

-- Barra Superior
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.BackgroundTransparency = 1
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "ZYNK MENU"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 15
titleLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
titleLabel.Size = UDim2.new(0, 150, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = topBar

-- Botão Minimizar
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.TextColor3 = Color3.fromRGB(40, 40, 40)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Size = UDim2.new(0, 28, 0, 26)
minimizeBtn.Position = UDim2.new(1, -70, 0.5, -13)
minimizeBtn.Modal = true
minimizeBtn.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeBtn

-- Botão Fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.TextColor3 = Color3.fromRGB(220, 60, 60)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Size = UDim2.new(0, 28, 0, 26)
closeBtn.Position = UDim2.new(1, -36, 0.5, -13)
closeBtn.Modal = true
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- Container de Páginas
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -20, 1, -110)
contentContainer.Position = UDim2.new(0, 10, 0, 45)
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
-- ⚙️ SCRIPT DOS CHEATS (NOCLIP, ESP, REGEN DE VIDA)
--------------------------------------------------------------------------------
local noclipEnabled = false
local espEnabled = false
local regenEnabled = false

-- Loop NoClip
RunService.Stepped:Connect(function()
	if noclipEnabled and player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- Loop ESP
local function updateESP()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local highlight = p.Character:FindFirstChild("ZynkESP")
			if espEnabled then
				if not highlight then
					highlight = Instance.new("Highlight")
					highlight.Name = "ZynkESP"
					highlight.FillColor = Color3.fromRGB(255, 60, 60)
					highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
					highlight.Parent = p.Character
				end
			else
				if highlight then highlight:Destroy() end
			end
		end
	end
end

Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function()
		task.wait(0.5)
		updateESP()
	end)
end)

-- Loop Regen de Vida
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
-- 🎨 CRIAÇÃO DE CARDS E BOTOES
--------------------------------------------------------------------------------
local function createToggleCard(parentPage, text, callback)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(0.95, 0, 0, 42)
	card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	card.Parent = parentPage

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 8)
	cardCorner.Parent = card

	local lbl = Instance.new("TextLabel")
	lbl.Text = text
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 13
	lbl.TextColor3 = Color3.fromRGB(60, 60, 60)
	lbl.Size = UDim2.new(0.6, 0, 1, 0)
	lbl.Position = UDim2.new(0, 12, 0, 0)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.BackgroundTransparency = 1
	lbl.Parent = card

	local btn = Instance.new("TextButton")
	btn.Text = "OFF"
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 11
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
	btn.Size = UDim2.new(0, 55, 0, 26)
	btn.Position = UDim2.new(1, -65, 0.5, -13)
	btn.Modal = true
	btn.Parent = card

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = btn

	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = state and "ON" or "OFF"
		btn.BackgroundColor3 = state and Color3.fromRGB(60, 180, 80) or Color3.fromRGB(200, 60, 60)
		callback(state)
	end)

	return card
end

-- Itens da Página Principal
createToggleCard(principalPage, "🚫 No Clip", function(val) noclipEnabled = val end)
createToggleCard(principalPage, "👁️ ESP Jogadores", function(val) espEnabled = val; updateESP() end)
createToggleCard(principalPage, "❤️ Regen de Vida", function(val) regenEnabled = val end)

-- Itens da Página Status
local function createStatusCard(icon, defaultText)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(0.95, 0, 0, 42)
	card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	card.Parent = statusPage

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 8)
	cardCorner.Parent = card

	local label = Instance.new("TextLabel")
	label.Text = icon .. "  " .. defaultText
	label.Font = Enum.Font.GothamBold
	label.TextSize = 13
	label.TextColor3 = Color3.fromRGB(60, 60, 60)
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
			child.Position = UDim2.new(0, 0, 0.1, 0)
			child.BackgroundTransparency = 1
			for _, desc in pairs(child:GetDescendants()) do
				if desc:IsA("TextLabel") or desc:IsA("TextButton") then
					desc.TextTransparency = 1
				end
			end
		end
	end

	-- Anima cada elemento individualmente com delay (1 por 1)
	task.spawn(function()
		for _, child in ipairs(page:GetChildren()) do
			if child:IsA("Frame") then
				TweenService:Create(child, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(0, 0, 0, 0),
					BackgroundTransparency = 0
				}):Play()

				for _, desc in pairs(child:GetDescendants()) do
					if desc:IsA("TextLabel") or desc:IsA("TextButton") then
						TweenService:Create(desc, TweenInfo.new(0.25), { TextTransparency = 0 }):Play()
					end
				end
				task.wait(0.08) -- Delay entre cada item gerado
			end
		end
	end)
end

--------------------------------------------------------------------------------
-- 📊 TAB BAR & NAVEGAÇÃO
--------------------------------------------------------------------------------
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, 45)
tabBar.Position = UDim2.new(0, 10, 1, -55)
tabBar.BackgroundColor3 = Color3.fromRGB(228, 231, 235)
tabBar.Parent = mainFrame

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 12)
tabCorner.Parent = tabBar

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Padding = UDim.new(0, 6)
tabLayout.Parent = tabBar

local function createTabButton(name)
	local btn = Instance.new("TextButton")
	btn.Text = name
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 13
	btn.TextColor3 = Color3.fromRGB(90, 90, 90)
	btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundTransparency = 0.6
	btn.Size = UDim2.new(0.31, 0, 0.8, 0)
	btn.Modal = true
	btn.Parent = tabBar

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = btn

	return btn
end

local principalBtn = createTabButton("Principal")
local serverBtn = createTabButton("Server")
local statusBtn = createTabButton("Status")

local currentPage = principalPage
currentPage.Visible = true
currentPage.GroupTransparency = 0
principalBtn.BackgroundTransparency = 0
animatePageElements(principalPage)

local function switchTab(targetPage, targetBtn)
	if currentPage == targetPage then return end
	
	currentPage.Visible = false
	currentPage.GroupTransparency = 1
	
	currentPage = targetPage
	targetPage.Visible = true
	targetPage.GroupTransparency = 0
	
	for _, btn in pairs({principalBtn, serverBtn, statusBtn}) do
		btn.BackgroundTransparency = 0.6
	end
	targetBtn.BackgroundTransparency = 0

	animatePageElements(targetPage)
end

principalBtn.MouseButton1Click:Connect(function() switchTab(principalPage, principalBtn) end)
serverBtn.MouseButton1Click:Connect(function() switchTab(serverPage, serverBtn) end)
statusBtn.MouseButton1Click:Connect(function() switchTab(statusPage, statusBtn) end)

-- Status Update Loop
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
		Size = isMinimized and UDim2.new(0, 360, 0, 45) or UDim2.new(0, 360, 0, 340)
	}):Play()
	contentContainer.Visible = not isMinimized
	tabBar.Visible = not isMinimized
end)

closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
	hotbarGui:Destroy()
end)

print("✅ [Zynk Menu] Carregado com Sucesso!")
