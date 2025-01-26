if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:GetService("Players")
local LocalPlayer = Player.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local interact = function(v2)
	local events = {"Activated","MouseButton1Down","MouseButton1Click","MouseButton1Up"}
	for _,v in pairs(events) do
		for _,connection in pairs(getconnections(v2[v])) do
			connection.Function()
		end
	end
end

local attackccd = function(args)
	if not game:GetService("Players").LocalPlayer.PlayerGui.HUD:FindFirstChild("attack") then
		local attack_ui = Instance.new("Frame")

		attack_ui.Name = "attack"
		attack_ui.Parent = game:GetService("Players").LocalPlayer.PlayerGui.HUD
		attack_ui.Active = true
		attack_ui.AnchorPoint = Vector2.new(0.5, 0.5)
		attack_ui.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		attack_ui.BackgroundTransparency = 1.000
		attack_ui.BorderColor3 = Color3.fromRGB(0, 0, 0)
		attack_ui.BorderSizePixel = 0
		attack_ui.Position = UDim2.new(0.491, 0, 0.208, 0)
		attack_ui.Rotation = 1.000
		attack_ui.Size = UDim2.new(0, 19, 0, 19)
	else
		local attacker = game:GetService("Players").LocalPlayer.PlayerGui.HUD:FindFirstChild("attack")
		local VirtualInputManager = game:GetService("VirtualInputManager")
		VirtualInputManager:SendMouseButtonEvent(attacker.AbsolutePosition.X, attacker.AbsolutePosition.Y, 0, true, game, 0)
		VirtualInputManager:SendMouseButtonEvent(attacker.AbsolutePosition.X, attacker.AbsolutePosition.Y, 0, false, game, 0)
	end
end

local fix = function()
	if game:GetService("Players").LocalPlayer.PlayerGui.UnitView.Enabled == true then
		attackccd()
	end
	return false
end



if game.PlaceId == 123662243100680 then
	game:GetService("Players").LocalPlayer.PlayerGui.QueueScreen.Enabled = false
	game:GetService("Players").LocalPlayer.PlayerGui.QueueScreen.Main.StartScreen.Visible = false
end

local get_unit = function()
	if PlayerGui.FirstUnitSelection.Enabled == true then
		ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("UnitService"):WaitForChild("RF"):WaitForChild("SelectStarterUnit"):InvokeServer("Spongebob")
	end
	return false
end

local get_reward = function()
	if game:GetService("Players").LocalPlayer.PlayerGui["Daily Rewards"].Enabled == true then
		for i = 1,7 do
			ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PlaytimeService"):WaitForChild("RF"):WaitForChild("ClaimDailyReward"):InvokeServer(i)
			interact(PlayerGui["Daily Rewards"].Main.Exit)
		end
	end
	return false
end

local get_speed = function()
	ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("RewardService"):WaitForChild("RF"):WaitForChild("ClaimLikeReward"):InvokeServer()
	return false
end


local get_all = function()
	if game.PlaceId == 123662243100680 then
		if get_unit() then return end
		
		if fix() then return end
		
		if get_reward() then return end
		
		get_speed()
	end
end


local get_queue = function()
	local a = require(LocalPlayer.PlayerScripts.Knit.Controllers.UIController.GuiModules.QueueScreen)
	for i,v in pairs(a.queueReplica) do
		if type(v) == "number" then
			return v
		end
	end
end


local TP_Room = function()
	if game:GetService("Players").LocalPlayer.PlayerGui.QueueScreen.Enabled == false and game:GetService("Players").LocalPlayer.PlayerGui.QueueScreen.Main.StartScreen.Visible == false then
		for i, v in pairs(workspace.Matchmakers:GetChildren()) do
			if not v:GetAttribute("Mode") then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.WorldPivot
			end
		end
	end
	return false
end

local get_room = function()
	if not TP_Room() then
		if game:GetService("Players").LocalPlayer.PlayerGui.QueueScreen.Main.SelectionScreen.Visible == false then
			local args = {
				[1] = get_queue(),
				[2] = "ConfirmMap",
				[3] = {
					["Difficulty"] = 2,
					["Chapter"] = 5,
					["Endless"] = true,
					["World"] = "ConchStreet"
				}
			}

			game:GetService("ReplicatedStorage"):WaitForChild("ReplicaRemoteEvents"):WaitForChild("Replica_ReplicaSignal"):FireServer(unpack(args))
		end
		return false
	end
end

local comfirm = function()
	if game:GetService("Players").LocalPlayer.PlayerGui.QueueScreen.Main.SelectionScreen.Visible == true and game:GetService("Players").LocalPlayer.PlayerGui.QueueScreen.Main.StartScreen.Visible == false then
		interact(PlayerGui.QueueScreen.Main.SelectionScreen.Main.Options.Options.Confirm)
	elseif game:GetService("Players").LocalPlayer.PlayerGui.QueueScreen.Main.StartScreen.Visible == true and game:GetService("Players").LocalPlayer.PlayerGui.QueueScreen.Main.SelectionScreen.Visible == false then
		interact(PlayerGui.QueueScreen.Main.StartScreen.Main.Options.Start)
	end
	return false
end


local join_game = function()
	if game.PlaceId == 123662243100680 then
		if TP_Room() then return end

		if get_room() then return end

		comfirm()
	end
end

local start = function()
	if LocalPlayer.PlayerGui.GameUI.VoteStart.Main:FindFirstChild("Button") and LocalPlayer.PlayerGui.GameUI.VoteStart.Main.Button.Visible then
		interact(LocalPlayer.PlayerGui.GameUI.VoteStart.Main.Button)
	end
	return false
end

local skip = function()
	if game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Top.SkipWave.Button.Visible == true then
		interact(game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Top.SkipWave.Button)
	end
	return false
end

local speed = function()
	local args = {
		[1] = 2
	}

	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RF"):WaitForChild("ChangeGameSpeed"):InvokeServer(unpack(args))
	return false
end

local replay = function()
	if LocalPlayer.PlayerGui.RoundSummary.Enabled == true then
		interact(LocalPlayer.PlayerGui.RoundSummary.Main.Content.Actions.Replay)
	end
	return false
end

local game_function = function()
	if game.PlaceId ~= 123662243100680 then
		if start() then return end

		if skip() then return end

		if speed() then return end

		if replay() then return end
	end
end

function lol()
	if game.PlaceId ~= 123662243100680 then
		local path = workspace.Map.Paths["1"]
		local node0 = path:FindFirstChild("Node0")
		local node1 = path:FindFirstChild("Node1")
		local node2 = path:FindFirstChild("Node2")
		local node3 = path:FindFirstChild("Node3")
		local node4 = path:FindFirstChild("Node4")
		local node5 = path:FindFirstChild("Node5")
		local node6 = path:FindFirstChild("Node6")
		local node7 = path:FindFirstChild("Node7")
		local node8 = path:FindFirstChild("Node8")
		local node9 = path:FindFirstChild("Node9")
		local node10 = path:FindFirstChild("Node10")
		if node0 and node1 and node2 then
			local partIndex = 1
			local function createMiniParts(nodeStart, nodeEnd)
				local totalDistance = (nodeEnd.Position - nodeStart.Position).Magnitude
				local segmentDistance = totalDistance / 10
				local direction = (nodeEnd.Position - nodeStart.Position).Unit
				local perpendicular = Vector3.new(-direction.Z, 0, direction.X)
				for i = 0, 9 do
					local positionOnPath = nodeStart.Position + direction * (segmentDistance * i)
					local miniPathPosition = positionOnPath + perpendicular * 0
					local miniPart = Instance.new("Part")
					miniPart.Size = Vector3.new(0.5, 0.5, 0.5)
					miniPart.Anchored = true
					miniPart.Position = miniPathPosition
					miniPart.BrickColor = BrickColor.new("Bright red")
					miniPart.Name = tostring(partIndex)
					miniPart.Transparency = 1
					miniPart.CanCollide = false
					miniPart.Parent = path
					local radius = 7  -- Increased from 5 to 7
					local numSmallParts = 20
					for j = 1, numSmallParts do
						local randomRadius = radius * math.sqrt(math.random())
						local randomAngle = math.random() * 2 * math.pi
						local offsetX = math.cos(randomAngle) * randomRadius
						local offsetZ = math.sin(randomAngle) * randomRadius
						local smallPart = Instance.new("Part")
						smallPart.Size = Vector3.new(0.25, 0.25, 0.25)
						smallPart.Anchored = true
						smallPart.Position = miniPathPosition + Vector3.new(offsetX, 0, offsetZ)
						smallPart.BrickColor = BrickColor.new("Bright blue")
						smallPart.Transparency = 1
						smallPart.CanCollide = false
						smallPart.Parent = miniPart
					end
					partIndex = partIndex + 1
				end
			end
			createMiniParts(node0, node1)
			createMiniParts(node1, node2)
			createMiniParts(node2, node3)
			createMiniParts(node3, node4)
			createMiniParts(node4, node5)
			createMiniParts(node5, node6)
			createMiniParts(node6, node7)
			createMiniParts(node7, node8)
			createMiniParts(node8, node9)
			createMiniParts(node9, node10)
		else
			warn("Node0, Node1 หรือ Node2 ไม่พบใน path นี้")
		end
	end
end

local afk = function()
	local vu = game:GetService("VirtualUser")
	game.Players.LocalPlayer.Idled:connect(function()
		if true then
			vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			wait(1)
			vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end
	end)
end

lol()
afk()

local auto_play = function()
	if game.PlaceId ~= 123662243100680 then
		repeat task.wait() until workspace.Enemies:FindFirstChildOfClass("Model")
		local enemy = workspace.Enemies:FindFirstChildOfClass("Model").RootPart.Position
		for i, v in pairs(workspace.Map.Paths["1"]:FindFirstChild(tostring(10)):GetChildren()) do
			local args = {
				[1] = CFrame.new(v.Position.X, enemy.Y+0.55, v.Position.Z),
				[2] = 1
			}

			game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("TowerService"):WaitForChild("RF"):WaitForChild("PlaceTower"):InvokeServer(unpack(args))
		end

		for _,unit in pairs(workspace.Friendlies:GetChildren()) do
			local args = {
				[1] = unit:GetAttribute("Id")
			}

			game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RF"):WaitForChild("UpgradeTower"):InvokeServer(unpack(args))
		end
	end
end

task.spawn(function()
	while task.wait() do
		pcall(function()
			get_all()
			join_game()
			game_function()
			auto_play()
		end)
	end
end)


