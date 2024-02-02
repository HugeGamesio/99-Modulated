local Module = {}

local internalConfig = {
	moduleInit = false,
	moduleHash = "x",
	modulePass = "y",
	moduleVer = 1,
	scriptObject = nil
}

local internalSecurity = {
	sVer = 1,
	Hash = "test",
	Passkey = "test2",
	requirePrem = false,
	isMBrick = false
}

local internalToLoad = {
	
}

function Module:Init(SVersion, Hash, Passkey, UIObject)
	if SVersion~=internalSecurity.sVer then internalSecurity.isMBrick = true end
	if Hash~=internalSecurity.Hash then internalSecurity.isMBrick = true end
	if Passkey~=internalSecurity.Passkey then internalSecurity.isMBrick = true end
	if internalSecurity.isMBrick then
		pcall(function()
			game.Players.LocalPlayer:Kick("[HugeGames] Modulation Inconsistency")
		end)
		return
	else
		internalConfig.scriptObject = UIObject
	end
end

function Module:SetLoadVars(Table)
	for i,v in pairs(Table) do
		internalToLoad[i] = v
	end
end

local internalUIStorage = {
	
}

local internalFunctions = {
	["KickPlayer"] = function()
		local Tab = internalUIStorage["Tab_Testing"] or internalConfig.scriptObject:Tab("Testing")
		if not internalUIStorage["Tab_Testing"] then internalUIStorage["Tab_Testing"] = Tab end
	end,
}

function Module:Load()
	for i,v in pairs(internalToLoad) do
		if internalFunctions[i] and v == true then
			internalFunctions[i]()
		end
	end
end

return Module