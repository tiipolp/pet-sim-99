local blue = "rbxassetid://13987312142"
local pink = "rbxassetid://13987314678"

local onlypink = true
local onlyblue = false

local valids = {}

local function hop()
    queue_on_teleport([[
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tiipolp/pet-sim-99/main/arcade.lua"))()
        ]])

    local _place = game.PlaceId
    local _servers = "https://games.roblox.com/v1/games/".._place.."/servers/Public?sortOrder=Asc&limit=100"
    function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    return game:GetService("HttpService"):JSONDecode(Raw)
    end

    local Server, Next; repeat
    local Servers = ListServers(Next)
    Server = Servers.data[1]
    Next = Servers.nextPageCursor
    until Server

    game:GetService("TeleportService"):TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
end

repeat 
    wait(5)
    firetouchtransmitter(workspace.__THINGS.Instances.ClawMachine:WaitForChild('Teleports').Enter, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
until workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild('ClawMachine')

for i,v in workspace.__THINGS.__INSTANCE_CONTAINER.Active.ClawMachine.Items:GetChildren() do
    for j,k in v:GetChildren() do
        if k:IsA("MeshPart") then
            if  onlypink == false and  onlyblue == false then
                if k.TextureID == blue then
                    valids[k] = "20"
                elseif k.TextureID == pink then
                    valids[k] = "50"
                end
            elseif onlypink == true and onlyblue == false and k.TextureID == pink then
                valids[k] = "50"
            elseif onlyblue == true and onlypink == false and k.TextureID == blue then
                valids[k] = "20"
            end
        end
    end
end

for key, value in pairs(valids) do
	print(key, value)
end

if next(valids) == nil then
    wait(5)
    hop()
end
