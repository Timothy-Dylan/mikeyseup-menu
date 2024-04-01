-- Config Variable
local Config = require('config.config')

--- Appplies the Clothing to the player
---@param data table - The data of the clothing
local function ApplyClothing(data, label)
    local ped = cache.ped

    -- Requests the model
    RequestModel(data.ped)

    -- if not model loaded then try again
    while not HasModelLoaded(data.ped) do Wait(0) end
    if GetEntityModel(ped) ~= joaat(data.ped) then SetPlayerModel(PlayerId(), data.ped) end

    -- Set the ped component variation
    for _, comp in ipairs(data.components) do SetPedComponentVariation(ped, comp[1], comp[2] - 1, comp[3] - 1, 0) end

    -- Set the props
    if data.props ~= nil then 
        for _, comp in ipairs(data.props) do
            if comp[2] == 0 then ClearPedProp(ped, comp[1]) else SetPedPropIndex(ped, comp[1], comp[2] - 1, comp[3] - 1, true) end
        end
    end

    lib.notify({ title = 'Mikey\'s EUP 1.3', description = 'Je hebt zojuist ' .. label .. ' aangedaan.', iconAnimation = 'beatFade', duration = 7500, type = 'success' })
end

--- Opens the detailed clothing menu of a specific job
---@param label string - The label of the clothing menu
---@param id string - The id of the type of clothing menu
---@param gender string - The gender of the player
local function OpenDetailedClothing(label, id, gender)
    -- Main Tabe
    local ClothingOptions = {}

    -- For every clothing option it adds it to the table
    for clothLabel, data in pairs(mEUP[id].Clothing[gender][label]) do
        ClothingOptions[#ClothingOptions+1] = {
            title = clothLabel,
            icon = 'fas fa-tshirt',
            onSelect = function() ApplyClothing(data, clothLabel) end
        }
    end

    -- Sorts the table and inserts the back button
    table.sort(ClothingOptions, function(a, b) return a.title < b.title end)
    table.insert(ClothingOptions, 1, {
        title = 'Terug naar vorige categorie',
        description = 'Via deze optie kan je terug naar de vorige opties die beschikbaar zijn.',
        icon = 'fas fa-arrow-left',
        onSelect = function () lib.showContext('mikeyseup_clothingmenu') end
    })

    -- Opens the menu
    lib.registerContext({ id = 'mikeyseup_specificmenu', title = mEUP[id].Label, options = ClothingOptions })
    lib.showContext('mikeyseup_specificmenu')
end


--- Opens the detailed clothing menu of a specific job
---@param id string - The id of the type of clothing menu
local function OpenAvailableClothingMenu(id, admin)
    -- Gender based stuff
    local gender
    if Config.Framework == 'qb' then
        local base = QBCore.Functions.GetPlayerData().charinfo.gender
        if base == 0 then gender = 'male' else gender = 'female' end
    elseif Config.Framework == 'esx' then
        base = ESX.PlayerData.sex
        if base == 'm' then gender = 'male' else gender = 'female' end
    elseif Config.Framework == 'standalone' then
        if IsPedMale(cache.ped) then gender = 'male' else gender = 'female'  end
    end

    -- Main Variables
    local Clothing = mEUP[id].Clothing[gender]
    local options = {}

    -- For every type of clothing it registers it
    for label in pairs(Clothing) do
        options[#options+1] = {
            title = label,
            icon = 'fa-solid fa-layer-group',
            onSelect = function () OpenDetailedClothing(label, id, gender) end
        }
    end

    -- Sorts the table and inserts the back button
    table.sort(options, function(a, b) return a.title < b.title end)
    table.insert(options, 1, {
        title = 'Terug naar vorige categorie',
        description = 'Via deze optie kan je terug naar de vorige opties die beschikbaar zijn.',
        icon = 'fas fa-arrow-left',
        onSelect = function () if admin then lib.showContext('mikeyseup_adminmenu') else lib.showContext('mikeyseup') end end
    })

    -- Shows the Menu
    lib.registerContext({ id = 'mikeyseup_clothingmenu', title = mEUP[id].Label, options = options })
    lib.showContext('mikeyseup_clothingmenu')
end


--- Opens the main menu for Mikeys EUP
RegisterNetEvent('mikeyseup:client:openMenu', function ()
    -- Gets the PlayerData
    local PlayerData
    if Config.Framework == 'qb' then
        PlayerData = QBCore.Functions.GetPlayerData().job
    elseif Config.Framework == 'esx' then
        PlayerData = ESX.PlayerData.job
    end

    -- Optiosn table
    local menuOptions = {}

    -- for every job type it adds it to the eup menu
    for TableName in pairs(mEUP) do
        if mEUP[TableName].Job == PlayerData.name then
            -- Adds the menu to the list of options
            menuOptions[#menuOptions+1] = {
                title = mEUP[TableName].Label,
                icon = 'fa-solid fa-briefcase',
                onSelect = function() OpenAvailableClothingMenu(mEUP[TableName].Id) end
            }
        end
    end

    -- Sorts the menu options and inserts the info
    table.sort(menuOptions, function(a, b) return a.title < b.title end)
    table.insert(menuOptions, 1, {
        title = "Beschikbare opties",
        description = "Hieronder zie je de voor jou beschikbare opties voor kleding die bij jouw baan horen. Klik op een optie om deze in te zien.",
        disabled = true,
    })

    -- Registers the context and shows it
    lib.registerContext({ id = 'mikeyseup', title = 'Mikeys EUP - Menu', options = menuOptions })
    lib.showContext('mikeyseup')
end)

--- Opens the admin menu version of the eup menu
RegisterNetEvent('mikeyseup:client:openAdminMenu', function ()
    local menuOptions = {}

    -- for every job type it adds it to the eup menu
    for TableName in pairs(mEUP) do
        menuOptions[#menuOptions+1] = {
            title = mEUP[TableName].Label,
            icon = 'fa-solid fa-briefcase',
            onSelect = function() OpenAvailableClothingMenu(mEUP[TableName].Id, true) end
        }
    end

    -- Sorts the menu options and inserts the info
    lib.registerContext({ id = 'mikeyseup_adminmenu', title = 'Mikeys EUP - Admin Menu', options = menuOptions })
    lib.showContext('mikeyseup_adminmenu')
end)
