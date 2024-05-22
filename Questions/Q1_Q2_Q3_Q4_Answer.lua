--Q1
local function releaseStorage(location, player) --Instead of hardcoding a magic number "1000" the function takes an argument instead
	player:setStorageValue(location, -1)
end

function onLogout(player, locationArgument)
	--Declaring all variables used in the function
	local location --I'm assuming the value "1000" corresponds to some sort of location in the storage of the player who logged out.
	
	--Seperating declaration of a variable and assigning value to a variable for better readability.
	location = locationArgument 
	
	if player:getStorageValue(location) == 1 then
		addEvent(releaseStorage, location, player) --Replaced the hardcoded value "1000" with a variable for better readability(no more magic number) and makes extending and reusing the code easier.
	end

	return true
end

--[[Overall, the biggest problem I notice is the hardcoded arbitrary number "1000" that's reused multiple times throughout the 2 function. 
I fixed this by modifying the functions to take in an extra argument for this value instead. Now, calling onLogout(player, 1000) will have the same effect]]


---------------------------------------------------------
--Q2
function printSmallGuildNames(memberCount)
	-- this method is supposed to print names of all guilds that have less than memberCount max members
	local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
	local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
	local guildNames = resultId.getString("name") --[["result" is not defined, corrected to "resultId" instead. Since there could be multiple guilds that have less that memberCount max members,
	the variable "guildName" is changed to "guildNames" instead for better readablity]]
	
	print(guildNames) --Assuming "resultId.getString("name")" returns a single string containing the name of all guilds with less than memberCount max members.
	
	--If "resultId.getString("name")" returns a table containing all the names instead, the function will need a loop to print the names like so
	for i = 1, #guildNames do
		print(guildNames[i])
	end
end

--[[The biggest problem I found with this function was the typo from "resultId" to "result" which is not defined anywhere. 
I also included some codes that iterate through a table and print all the names in case "resultId.getString("name")" returns a table instead of a single string.]]


---------------------------------------------------------
--Q3
function do_sth_with_PlayerParty(playerId, memberName) --changed "membername" to use camel case for consistency
	--Declaring all variables used in the function
	local party 
	
	--Seperating declaration of a variable and assigning value to a variable for better readability.
	party = Player(playerId):getParty() --the variable "player" is not needed as it's only used once to assist in getting the party information for the "party" variable.

	for k, v in pairs(party:getMembers()) do
		if v == Player(memberName) then
			party:removeMember(v) --Changed to remove the player referenced by "v" instead to make sure the function removes the right player.
		end
	end
end

--[[The code used "player" and "Player" for two different things, which can lead to confusion and bugs down the line, and the variable "player" was not necessary, so I removed it completely.
Other than that, the biggest problem was trying to remove Player(memberName) instead of the player that the function's loop found in the party. This might cause some problems down the line, 
so I changed to to removing the player that the loop found instead.]]


---------------------------------------------------------
