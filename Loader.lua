local HttpService = game:GetService("HttpService")
local root = script.Parent
local Settings = require(root.Settings)

function retrieveCount()
	local success, result = pcall(function()
		local headers = {
			["x-api-key"] = Settings.APIKEY
		}
		local url = "https://api.galacticinspired.com/"..Settings.GUILD.."/membercount"
		return HttpService:RequestAsync({
			Url = url,
			Method = "GET",
			Headers = headers,
		})
	end)

	return success, result
end

local success, result = retrieveCount()
if not success then
	print("Failed to retrieve member count:", result)
end

root.SurfaceGui.Main.Visible = true
root.SurfaceGui.Main.Message.Text = Settings.Message

while true do
	local success, result = retrieveCount()

	if success then
		local response = HttpService:JSONDecode(result.Body)
		local count = response.value
		root.SurfaceGui.Main.Count.Text = count
	else
		print("Failed to retrieve member count:", result)
	end
	wait(120)
end
