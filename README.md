local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Namoqp1/dump/refs/heads/main/them"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/barlossxi/barlossxi/main/ZAZA.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/barlossxi/barlossxi/main/InterfaceManager.lua.txt"))()

local ScreenGui1 = Instance.new("ScreenGui")
local ImageButton1 = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")

ScreenGui1.Name = "ImageButton"
ScreenGui1.Parent = game.CoreGui
ScreenGui1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ImageButton1.Parent = ScreenGui1
ImageButton1.BackgroundTransparency = 1
ImageButton1.BorderSizePixel = 0
ImageButton1.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
ImageButton1.Size = UDim2.new(0, 50, 0, 50)
ImageButton1.Draggable = true
ImageButton1.Image = "rbxassetid://10723396107"
ImageButton1.MouseButton1Down:Connect(function()
	game:GetService("VirtualInputManager"):SendKeyEvent(true,305,false,game)
	game:GetService("VirtualInputManager"):SendKeyEvent(false,305,false,game)
end)
UICorner.Parent = ImageButton1

local Window = Fluent:CreateWindow({
	Title = "Rock Fruit",
	SubTitle = "ddcmmc",
	TabWidth = 130,
	Size = UDim2.fromOffset(480, 400),
	Acrylic = false, 
	Theme = "Dark",
	MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
	Setting = Window:AddTab({ Title = "Setting", Icon = "settings" })
}



local interact = function(v2)
	local events = {"Activated","MouseButton1Down","MouseButton1Click","MouseButton1Up","MouseButton1Down"}
	for i,v in pairs(events) do
		for i,v in pairs(getconnections(v2[v])) do
			v.Function()
		end
	end
end


Tabs.Setting:AddToggle("Host Bot", {
	Title = "Host Bot",
	Default = false,
	Callback = function(Host)
		_G.Host= Host
	end
})

spawn(function()
	while task.wait() do
		if _G.Host then
			pcall(function()
				if not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("WaveUI") then
					if not game.workspace:FindFirstChild("DungeonRing") then
						if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Orb Dungeon") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Orb Dungeon") then
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-125.37633514404297, 34.35084533691406, -1178.88818359375)
							wait(1)
							game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
						elseif game:GetService("Players").LocalPlayer.PlayerGui.HUD.Inventory.ScrollingFrameList:FindFirstChild("Orb Dungeon") and not (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Orb Dungeon") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Orb Dungeon")) then
							if game:GetService("Players").LocalPlayer.PlayerGui.HUD.DungeonReward.Visible == false then
								game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Inventory"):FireServer("Orb Dungeon")         
								task.wait(1)
							else
								game.Players.LocalPlayer.CharacterRemoving:Wait()
								game.Players.LocalPlayer.CharacterAdded:Wait()
								interact(game:GetService("Players").LocalPlayer.PlayerGui.HUD.DungeonReward.CloseFrame.CloseButton)
								game:GetService("Players").LocalPlayer.PlayerGui.HUD.DungeonReward.Visible = false
							end
						end
					else
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-123.26849365234375, 34.35084533691406, -1136.7694091796875)
					end
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(18502.501953125, 19.842140197753906, -871.3150024414062)
				end
			end)
		end
	end
end)


Tabs.Setting:AddToggle("Sub Bot", {
	Title = "Sub Bot",
	Default = false,
	Callback = function(Sub)
		_G.Sub= Sub
	end
})

spawn(function()
	while task.wait() do
		if _G.Sub then
			pcall(function()
				if not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("WaveUI") then
					if game.workspace:FindFirstChild("DungeonRing") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-123.26849365234375, 34.35084533691406, -1136.7694091796875)
					else
						return
					end
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(18502.501953125, 19.842140197753906, -871.3150024414062)
				end
			end)
		end
	end
end)
