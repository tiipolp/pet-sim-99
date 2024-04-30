-- balloon doesnt look like a real word anymore :(
local plr = game.Players.LocalPlayer
local char = plr.Character

local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local Client = require(game.ReplicatedStorage.Library:WaitForChild("Client"))
local CalculateSpeedMultiplier = Client.PlayerPet.CalculateSpeedMultiplier

Client.PlayerPet.CalculateSpeedMultiplier = function(...)
	return 9e9
end

if _G.lag then game:GetService("RunService"):Set3dRenderingEnabled(false) else game:GetService("RunService"):Set3dRenderingEnabled(true) end

local function hop()
    queue_on_teleport([[
		repeat wait() until game:IsLoaded()
		wait(20)
		_G.toggle = true; 
		loadstring(game:HttpGet("https://raw.githubusercontent.com/tiipolp/pet-sim-99-ballon/main/autoballoon.lua"))()]])
 
    local _place = game.PlaceId
    local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
    function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    return Http:JSONDecode(Raw)
    end

    local Server, Next; repeat
    local Servers = ListServers(Next)
    Server = Servers.data[1]
    Next = Servers.nextPageCursor
    until Server

    TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
end

if not char:FindFirstChild("WEAPON_" .. plr.Name) then
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Slingshot_Toggle"):InvokeServer()
end

local function killBalloon(id)
    local args = {
        [1] = Vector3.new(1,1,1),
        [2] = 1,
        [3] = 1,
        [4] = 1
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Slingshot_FireProjectile"):InvokeServer(unpack(args))

    local args = {
        [1] = id
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("BalloonGifts_BalloonHit"):FireServer(unpack(args))
end

repeat 
    wait(3)
    local balloons = workspace.__THINGS.BalloonGifts:GetChildren()
    if #balloons > 1 then
	local balloon = balloons[math.random(1, #balloons)]
	
	if balloon:FindFirstChild("Balloon") then
	     char.HumanoidRootPart.CFrame = balloon:WaitForChild("Balloon").CFrame
	     killBalloon(balloon.Balloon:GetAttribute("BalloonId"))
	end
    end
until #workspace.__THINGS.BalloonGifts:GetChildren() == 1 or _G.toggle == false

hop()
