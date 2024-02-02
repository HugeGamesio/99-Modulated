-- Hash: NIAhSGUzswkqXtELqzOZiCbohEeaTmyo

--
-- ██╗  ██╗██╗   ██╗ ██████╗ ███████╗     ██████╗  █████╗ ███╗   ███╗███████╗███████╗
-- ██║  ██║██║   ██║██╔════╝ ██╔════╝    ██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔════╝
-- ███████║██║   ██║██║  ███╗█████╗      ██║  ███╗███████║██╔████╔██║█████╗  ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔══╝      ██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝███████╗    ╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝     ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝ © 2024

-- The following code was written exclusively for the usage within HugeGames scripts
-- Any attempts to tamper with, modify, or unpermitted usage may result in blacklist
-- from all HugeGames services. user data may also be recorded for securty purposes.
--

local Config = {}

function ensureFiles(Table)
	for i,v in pairs(Table) do
		if not v[2](v[1]) then
			if v[3] == makefolder then
				v[3](v[1])
			else
				v[3](v[1], game.HttpService:JSONEncode({}))
			end
		end
	end
end

function initFileSystem()
	local required = {isfile, readfile, writefile, isfolder, makefolder}
	local isFileSystem = false
	for i,v in pairs(required) do if v==nil then isFileSystem = false end end

	ensureFiles({
		{"HugeGames", isfolder, makefolder},
		{"HugeGames/Ps99", isfolder, makefolder},
		{"HugeGames/Ps99/Config.json", isfolder, writefile},
		{"HugeGames/Ps99/Modules.json", isfolder, writefile}
	})
end

function formatModules()
	local Cnf = game.HttpService:JSONDecode(
		readfile("HugeGames/Ps99/Modules.json")
	)
	
	if not Cnf.Modules then Cnf.Modules = {} end
	if not Cnf.Functions then Cnf.Functions = {} end
	
	readfile("HugeGames/Ps99/Modules.json", game.HttpService:JSONEncode(Cnf))
end

initFileSystem()
formatModules()

function loadJson()
	local Cnf = game.HttpService:JSONDecode(
		readfile("HugeGames/Ps99/Modules.json")
	)
	return Cnf
end

function Config:Blacklist_Module(List) -- A List of modules *NOT TO LOAD*
	local JS = loadJson()
	for i,v in pairs(List) do
		if not table.find(JS.Modules, v) then
			table.insert(JS.Modules, v)
		end
	end
	readfile("HugeGames/Ps99/Modules.json", game.HttpService:JSONEncode(JS))
end

function Config:Blacklist_Function(List) -- A List of functions *NOT TO LOAD*
	local JS = loadJson()
	for i,v in pairs(List) do
		if not table.find(JS.Functions, v) then
			table.insert(JS.Functions, v)
		end
	end
	readfile("HugeGames/Ps99/Modules.json", game.HttpService:JSONEncode(JS))
end

function Config:UnBlacklist_Module(List) -- A List of modules *NOT TO LOAD*
	local JS = loadJson()
	for i,v in pairs(List) do
		if table.find(JS.Modules, v) then
			table.remove(JS.Modules, v)
		end
	end
	readfile("HugeGames/Ps99/Modules.json", game.HttpService:JSONEncode(JS))
end

function Config:UnBlacklist_Function(List) -- A List of functions *NOT TO LOAD*
	local JS = loadJson()
	for i,v in pairs(List) do
		if table.find(JS.Functions, v) then
			table.remove(JS.Functions, v)
		end
	end
	readfile("HugeGames/Ps99/Modules.json", game.HttpService:JSONEncode(JS))
end

function Config:ClearBlacklist_Module()
	local JS = loadJson()
	JS.Modules = {}
	readfile("HugeGames/Ps99/Modules.json", game.HttpService:JSONEncode(JS))
end

function Config:ClearBlacklist_Function()
	local JS = loadJson()
	JS.Functions = {}
	readfile("HugeGames/Ps99/Modules.json", game.HttpService:JSONEncode(JS))
end

return Config