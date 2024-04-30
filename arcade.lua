local blue = "rbxassetid://13987312142"
local pink = "rbxassetid://13987314678"
local valids = {}

local function hop()
    queue_on_teleport([[
        wait(20)
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

repeat wait() until workspace.__THINGS:WaitForChild('Instances'):WaitForChild('ClawMachine'):WaitForChild('Teleports')

firetouchtransmitter(workspace.__THINGS.Instances.ClawMachine.Teleports.Enter, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)

repeat wait() until workspace.__THINGS.__INSTANCE_CONTAINER.Active:WaitForChild('ClawMachine')

for i,v in workspace.__THINGS.__INSTANCE_CONTAINER.Active.ClawMachine.Items:GetChildren() do
    for j,k in v:GetChildren() do
        if k:IsA("MeshPart") then
            if k.TextureID == blue then
                valids[k] = "20"
            elseif k.TextureID == pink then
                valids[k] = "50"
            end
        end
    end
end

if next(valids) ~= nil then
    hop()
end
