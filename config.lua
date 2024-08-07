Config = {}
Config.City = 'Bucharest'
Config.apiKey  = '' -- https://openweathermap.org/api generate api key here
Config.marker = { 

    show = true, -- enable/disable marker
    coords = { x = 243.6690, y = -3123.93, z = 5.796, radius = 20.0 }, -- radius is from how far away the marker will show
    desc = 'Vreme actuala:~g~~n~',
    color = { r = 30, g = 129, b = 176, a = 200 },
    type = 42,
    textFont = 7,
    textScale = 2.0

}

-- this is in romanian, you can change it to your language
Config.weatherNames = {
    ['Clear'] = 'sunny', 
    ['Clouds']  = 'Inorat', 
    ['Drizzle'] = 'Picaturi de ploaie', 
    ['Rain'] = 'Ploaie', 
    ['Thunderstorm'] = 'Furtuna', 
    ['Fog'] = 'Ceata',
    ['Snow'] = 'Zapada'
}
Config.playerSpawnedEvent = 'vRP:playerSpawned' -- you can change it to esx/qbus

 