_G.currentWeather = 'Sunny'
RegisterNetEvent('sn:updateCurrentWeather', function(w)
	_G.currentWeather = w
end)

local function drawText(x,y,z, text, scl)
	scl = Config.marker.textScale

	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = #(vector3(px,py,pz) - vector3(x,y,z))
	local scale = (1/dist)*scl
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov
	if onScreen then
		SetTextScale(0.0*scale, 0.5*scale)
		SetTextFont(Config.marker.textFont)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

local CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local hour,minute = 0,0

Citizen.CreateThread(function()
    while true do
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeOverTime(CurrentWeather, 15.0)
            Citizen.Wait(15000)
        end
        Citizen.Wait(100) 
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        if lastWeather:lower() == 'xmas' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

RegisterNetEvent('updateTime')
AddEventHandler('updateTime', function(hourr, min)
	hour = hourr
	minute = min
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        NetworkOverrideClockTime(hour, minute, 0)
    end
end)



RegisterNetEvent('updateWeather', function(NewWeather)
    CurrentWeather = NewWeather
    
end)




Citizen.CreateThread(function()
	if not Config.marker.show then return end
	while true do 
		Citizen.Wait(1000)
		while #(GetEntityCoords(PlayerPedId()) - vec3(Config.marker.coords.x,Config.marker.coords.y,Config.marker.coords.z)) <= Config.marker.coords.radius do 
			Wait(0)
			drawText(Config.marker.coords.x,Config.marker.coords.y,Config.marker.coords.z+0.60, ('%s'):format(Config.marker.desc) .. ' '.._G.currentWeather,2.0)
			DrawMarker(Config.marker.type,Config.marker.coords.x,Config.marker.coords.y,Config.marker.coords.z,0,0,0,0,0,0,0.65,0.65,0.65,Config.marker.color.r,Config.marker.color.g,Config.marker.color.b,Config.marker.color.a,0,0,0,1)
		end
	end
end)
