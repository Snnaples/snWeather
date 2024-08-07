local WeatherTypes = {
    ['Clear'] = 'CLEAR', 
    ['Clouds']  = 'CLOUDS', 
    ['Drizzle'] = 'CLEARING', 
    ['Rain'] = 'RAIN', 
    ['Thunderstorm'] = 'THUNDER', 
    ['Fog'] = 'FOGGY',
    ['Snow'] = 'SNOW'
}

local niceWeathers = Config.weatherNames

local getNiceWeatherName = function(weather)
    if niceWeathers[weather] then 
        return niceWeathers[weather]
    end
    return weather
end

local apiKey = Config.apiKey

local httpRequest = ('https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s'):format(Config.City, apiKey)


local getCurrentWeather = function(cb)
    PerformHttpRequest(httpRequest, function(errCode,resultData,header)
            local data = json.decode(resultData)
            if not data then return print'City name is incorrect' end
            cb(data.weather[1].main)
    end)
end



Citizen.CreateThread(function()
    while true do 
        getCurrentWeather(function(weather)
            local fWeather = WeatherTypes[weather]
            local time = os.date"*t"
            TriggerClientEvent('updateWeather',-1,fWeather)
            TriggerClientEvent('updateTime',-1,time.hour,time.min)
            TriggerClientEvent('sn:updateCurrentWeather',-1,getNiceWeatherName(weather))
        end)
        Citizen.Wait(1000 * 60)
    end
end)


AddEventHandler('playerJoining',function(user_id,source,first_spawn)
    
    getCurrentWeather(function(weather)
        local fWeather = WeatherTypes[weather]
        local time = os.date"*t"
        TriggerClientEvent('updateWeather',-1,fWeather)
        TriggerClientEvent('updateTime',-1,time.hour,time.min)
    end)

end)

AddEventHandler(Config.playerSpawnedEvent,function(user_id,source,first_spawn)
    
        getCurrentWeather(function(weather)
            local fWeather = WeatherTypes[weather]
            local time = os.date"*t"
            TriggerClientEvent('updateWeather',-1,fWeather)
            TriggerClientEvent('updateTime',-1,time.hour,time.min)
        end)
  
end)