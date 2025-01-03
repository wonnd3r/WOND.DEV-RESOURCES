local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.Name = "PixelGroupGUI"

local pixelWidth = 240 / 2
local pixelHeight = 135 / 2
local scaleFactor = 1.2

local pixels = {}

for y = 0, pixelHeight - 1 do
	for x = 0, pixelWidth - 1 do
		local pixelFrame = Instance.new("Frame")
		pixelFrame.Name = "Pixel"

		pixelFrame.Size = UDim2.new(1 / pixelWidth * scaleFactor, 0, 1 / pixelHeight * scaleFactor, 0)
		pixelFrame.Position = UDim2.new((x / pixelWidth) * scaleFactor - (scaleFactor - 1) / 2, 0, (y / pixelHeight) * scaleFactor - (scaleFactor - 1) / 2, 0)

		pixelFrame.BackgroundColor3 = Color3.new(1, 1, 1)
		pixelFrame.BorderSizePixel = 0
		pixelFrame.Parent = screenGui
		table.insert(pixels, pixelFrame)
	end
end

local camera = workspace.CurrentCamera

local function updatePixelColors()
	for i, pixel in pairs(pixels) do
		local pixelPosX = (i % pixelWidth) / pixelWidth
		local pixelPosY = math.floor(i / pixelWidth) / pixelHeight

		local screenPoint = Vector2.new(pixelPosX * camera.ViewportSize.X, pixelPosY * camera.ViewportSize.Y)
		local rayOrigin = camera.CFrame.Position
		local rayDirection = camera:ScreenPointToRay(screenPoint.X, screenPoint.Y).Direction * 500 -- Distancia del rayo

		local ray = Ray.new(rayOrigin, rayDirection)
		local hitPart, hitPosition = workspace:FindPartOnRay(ray, nil)

		if hitPart then
			pixel.BackgroundColor3 = hitPart.Color
		else
			pixel.BackgroundColor3 = Color3.fromRGB(135, 206, 235)
		end
	end
end

game:GetService("RunService").RenderStepped:Connect(updatePixelColors)
