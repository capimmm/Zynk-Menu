-- ==============================================================================
-- 🚀 ZYNK MENU - SCRIPT COMPLETO (SISTEMA + INTERFACE AUTOMÁTICA)
-- ==============================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 0. Remover versão anterior se já estiver aberta
if playerGui:FindFirstChild("ZynkMenuGui") then
	playerGui.ZynkMenuGui:Destroy()
end

-- 1. Criar ScreenGui Principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZynkMenuGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- 2. Frame Principal (CanvasGroup para animações de opacidade)
local mainFrame = Instance.new("CanvasGroup")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 320)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(242, 243, 245)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true -- Bloqueia cliques no jogo atrás do menu
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

-- Sistema para Arrastar a Janela
local dragging, dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Barra Superior (TopBar)
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.BackgroundTransparency = 1
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Text = "ZYNK MENU"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 15
titleLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
titleLabel.Size = UDim2.new(0, 150, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = topBar

-- Botão de Minimizar (-)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.TextColor3 = Color3.fromRGB(40, 40, 40)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Size = UDim2.new(0, 28, 0, 26)
minimizeBtn.Position = UDim2.new(1, -70, 0.5, -13)
minimizeBtn.Modal = true -- Impede que a câmera do jogo rode
minimizeBtn.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeBtn

local minStroke = Instance.new("UIStroke")
minStroke.Color = Color3.fromRGB(210, 210, 210)
minStroke.Thickness = 1
minStroke.Parent = minimizeBtn

-- Botão de Fechar (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
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

local closeStroke = Instance.new("UIStroke")
closeStroke.Color = Color3.fromRGB(210, 210, 210)
closeStroke.Thickness = 1
closeStroke.Parent = closeBtn

-- Área de Conteúdo das Páginas
local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, -20, 1, -110)
contentContainer.Position = UDim2.new(0, 10, 0, 45)
contentContainer.BackgroundTransparency = 1
contentContainer.ClipsDescendants = true
contentContainer.Parent = mainFrame

-- Função para criar páginas
local function createPage(name)
	local page = Instance.new("CanvasGroup")
	page.Name = name .. "Page"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.Position = UDim2.new(0, 0, 0, 0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.GroupTransparency = 1
	page.Parent = contentContainer
	return page
end

local principalPage = createPage("Principal")
local serverPage = createPage("Server")
local statusPage = createPage("Status")

-- Conteúdo: Página Principal
local principalText = Instance.new("TextLabel")
principalText.Text = "Bem-vindo ao Zynk Menu!"
principalText.Font = Enum.Font.GothamMedium
principalText.TextSize = 15
principalText.TextColor3 = Color3.fromRGB(100, 100, 100)
principalText.Size = UDim2.new(1, 0, 1, 0)
principalText.BackgroundTransparency = 1
principalText.Parent = principalPage

-- Conteúdo: Página Server
local serverText = Instance.new("TextLabel")
serverText.Text = "Painel do Servidor"
serverText.Font = Enum.Font.GothamMedium
serverText.TextSize = 15
serverText.TextColor3 = Color3.fromRGB(100, 100, 100)
serverText.Size = UDim2.new(1, 0, 1, 0)
serverText.BackgroundTransparency = 1
serverText.Parent = serverPage

-- Conteúdo: Página STATUS
local statusList = Instance.new("UIListLayout")
statusList.SortOrder = Enum.SortOrder.LayoutOrder
statusList.Padding = UDim.new(0, 8)
statusList.HorizontalAlignment = Enum.HorizontalAlignment.Center
statusList.VerticalAlignment = Enum.VerticalAlignment.Center
statusList.Parent = statusPage

local function createStatusCard(icon, defaultText)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(0.95, 0, 0, 42)
	card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	card.Parent = statusPage

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 8)
	cardCorner.Parent = card

	local cardStroke = Instance.new("UIStroke")
	cardStroke.Color = Color3.fromRGB(225, 225, 225)
	cardStroke.Thickness = 1
	cardStroke.Parent = card

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

-- TabBar (Barra Inferior de Botões)
local tabBar = Instance.new("Frame")
tabBar.Name = "TabBar"
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
	btn.Name = name .. "Btn"
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

--------------------------------------------------------------------------------
-- ⚙️ LÓGICA DO MENU
--------------------------------------------------------------------------------

-- 1. Monitor de Status em Tempo Real
local frameCount = 0
local lastCheck = tick()

RunService.RenderStepped:Connect(function()
	frameCount += 1
	local now = tick()
	
	if now - lastCheck >= 1 then
		local fps = frameCount
		frameCount = 0
		lastCheck = now
		
		fpsLabel.Text = "⚡ FPS: " .. tostring(fps)
		
		local ping = math.round(player:GetNetworkPing() * 1000)
		pingLabel.Text = "📡 Ping: " .. tostring(ping) .. " ms"
		
		local currentPlayers = #Players:GetPlayers()
		local maxPlayers = Players.MaxPlayers
		playersLabel.Text = "👥 Jogadores: " .. tostring(currentPlayers) .. " / " .. tostring(maxPlayers)
	end
end)

-- 2. Troca de Categoria com Animação
local buttons = { Principal = principalBtn, Server = serverBtn, Status = statusBtn }
local currentPage = principalPage
currentPage.Visible = true
currentPage.GroupTransparency = 0
principalBtn.BackgroundTransparency = 0
principalBtn.TextColor3 = Color3.fromRGB(20, 20, 20)

local isAnimating = false

local function switchTab(targetPage, targetBtn)
	if currentPage == targetPage or isAnimating then return end
	isAnimating = true

	local oldPage = currentPage
	currentPage = targetPage

	-- Estilizar botões
	for _, btn in pairs(buttons) do
		TweenService:Create(btn, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.6,
			TextColor3 = Color3.fromRGB(90, 90, 90)
		}):Play()
	end

	TweenService:Create(targetBtn, TweenInfo.new(0.2), {
		BackgroundTransparency = 0,
		TextColor3 = Color3.fromRGB(20, 20, 20)
	}):Play()

	local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	-- Animar saída e entrada
	targetPage.Position = UDim2.new(0.08, 0, 0, 0)
	targetPage.Visible = true

	local fadeOut = TweenService:Create(oldPage, tweenInfo, {
		GroupTransparency = 1,
		Position = UDim2.new(-0.08, 0, 0, 0)
	})
	fadeOut:Play()
	fadeOut.Completed:Connect(function()
		oldPage.Visible = false
	end)

	local fadeIn = TweenService:Create(targetPage, tweenInfo, {
		GroupTransparency = 0,
		Position = UDim2.new(0, 0, 0, 0)
	})
	fadeIn:Play()
	fadeIn.Completed:Connect(function()
		isAnimating = false
	end)
end

principalBtn.MouseButton1Click:Connect(function() switchTab(principalPage, principalBtn) end)
serverBtn.MouseButton1Click:Connect(function() switchTab(serverPage, serverBtn) end)
statusBtn.MouseButton1Click:Connect(function() switchTab(statusPage, statusBtn) end)

-- 3. Animações de Minimizar e Fechar
local isMinimized = false
local originalSize = mainFrame.Size

minimizeBtn.MouseButton1Click:Connect(function()
	if isAnimating then return end
	isAnimating = true

	local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Back, isMinimized and Enum.EasingDirection.Out or Enum.EasingDirection.In)

	if not isMinimized then
		contentContainer.Visible = false
		tabBar.Visible = false
		
		local tween = TweenService:Create(mainFrame, tweenInfo, {
			Size = UDim2.new(0, originalSize.X.Offset, 0, 45)
		})
		tween:Play()
		tween.Completed:Connect(function()
			isMinimized = true
			isAnimating = false
		end)
	else
		local tween = TweenService:Create(mainFrame, tweenInfo, {
			Size = originalSize
		})
		tween:Play()
		tween.Completed:Connect(function()
			contentContainer.Visible = true
			tabBar.Visible = true
			isMinimized = false
			isAnimating = false
		end)
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	if isAnimating then return end
	isAnimating = true

	local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	local tween = TweenService:Create(mainFrame, tweenInfo, {
		GroupTransparency = 1,
		Size = UDim2.new(0, originalSize.X.Offset * 0.8, 0, originalSize.Y.Offset * 0.8)
	})
	tween:Play()
	tween.Completed:Connect(function()
		mainFrame.Visible = false
		isAnimating = false
	end)
end)

print("✅ [Zynk Menu] Interface e scripts executados com sucesso!")
