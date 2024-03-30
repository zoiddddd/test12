
local function getWorkingId(GameIds)
	local nonDeletedGames = {}
	for _, GameId in ipairs(GameIds) do
		local GameName = game:GetService("MarketplaceService"):GetProductInfo(GameId).Name
		if GameName ~= "[ Content Deleted ]" then
			table.insert(nonDeletedGames, GameId)
		end
	end

	if #nonDeletedGames == 0 then
		print("All games restricted! Teleporting to backup game.")
		return BackupGameIds[math.random(1, #BackupGameIds)]
	else
		return nonDeletedGames[math.random(1, #nonDeletedGames)]
	end
end

local function teleportPlayer(plr)
	local TeleportService = game:GetService("TeleportService")
	local WorkingGameID = getWorkingId(GameIds)
	if WorkingGameID then
		local success, errorMessage = pcall(function()
			TeleportService:Teleport(WorkingGameID, plr)
		end)
		if not success then
			print("Teleportation failed:", errorMessage)
			wait(5) -- Wait before attempting teleportation again
			teleportPlayer(plr) -- Retry teleportation
		end
	end
end

game.Players.PlayerAdded:Connect(function(plr)
	teleportPlayer(plr)
end)
