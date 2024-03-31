local function applyClothing(clothingData, label)
    local ped = cache.ped

    RequestModel(clothingData.ped)

    while not HasModelLoaded(clothingData.ped) do Wait(0) end
    if GetEntityModel(ped) ~= joaat(clothingData.ped) then SetPlayerModel(PlayerId(), clothingData.ped) end

    ped = cache.ped

    for _, comp in ipairs(clothingData.components) do SetPedComponentVariation(ped, comp[1], comp[2] - 1, comp[3] - 1, 0) end

    if clothingData.props ~= nil then 
        for _, comp in ipairs(clothingData.props) do
            if comp[2] == 0 then ClearPedProp(ped, comp[1]) else SetPedPropIndex(ped, comp[1], comp[2] - 1, comp[3] - 1, true) end
        end
    end
     
    lib.notify({ title = 'Mikey\'s EUP 1.3', description = 'Je hebt zojuist ' .. label .. ' aangedaan.', iconAnimation = 'beatFade', duration = 7500, type = 'success' })
end

local function openDetailedMenu(job, gender, label)
    local clothingOptions = {}

   for label, clothingData in pairs(Shared.Clothing[job.name][gender][label]) do
        clothingOptions[#clothingOptions+1] = {
            title = label,
            onSelect = function ()
                applyClothing(clothingData, label)
            end
        }
    end

    table.sort(clothingOptions, function(a, b) return a.title < b.title end)

    table.insert(clothingOptions, 1, {
        title = 'Terug naar vorige categorie',
        description = 'Via deze optie kan je terug naar de vorige opties die beschikbaar zijn.',
        icon = 'fas fa-arrow-left',
        onSelect = function () lib.showContext('mikeyseup_clothingmenu') end
    })

    lib.registerContext({ id = 'mikeyseup_categorymenu', title = job.label, options = clothingOptions })
    lib.showContext('mikeyseup_categorymenu')
end

local function openMenu(job)
    if Shared.Framework == 'qb-core' then
        local base = QBCore.Functions.GetPlayerData().charinfo.gender
        if base == 0 then gender = 'male' else gender = 'female' end
    elseif Shared.Framework == 'esx' then
        gender = ESX.PlayerData.sex
    elseif Shared.Framework == 'standalone' then
        if IsPedMale(cache.ped) then gender = 'male' else gender = 'female' end
        job = { name = job, label = job }
    end

    local options = {}

    if Shared.Clothing[job.name] == nil then
        lib.notify({ title = 'Mikey\'s EUP 1.3', description = 'Er is voor deze baan momenteel geen kleding beschikbaar of deze is nog niet ingesteld.', iconAnimation = 'beatFade', duration = 7500, type = 'error' })
        return
    end

    for label in pairs(Shared.Clothing[job.name][gender]) do
        options[#options+1] = {
            title = label,
            onSelect = function () openDetailedMenu(job, gender, label) end
        }
    end

    table.sort(options, function(a, b) return a.title < b.title end)

    table.insert(options, 1, {
        title = 'Terug naar vorige categorie',
        description = 'Via deze optie kan je terug naar de vorige opties die beschikbaar zijn.',
        icon = 'fas fa-arrow-left',
        onSelect = function () lib.showContext('mikeyseup') end
    })

    lib.registerContext({ id = 'mikeyseup_clothingmenu', title = job.label, options = options })
    lib.showContext('mikeyseup_clothingmenu')
end

RegisterNetEvent("mtc-mikeyseup:client:openMenu", function()
    if Shared.Framework == 'qb-core' then PlayerData = QBCore.Functions.GetPlayerData().job elseif Shared.Framework == 'esx' then PlayerData = ESX.PlayerData.job end
    local options = {}

    options = {
        {
            title = "Beschikbare opties",
            description = "Hieronder zie je de voor jou beschikbare opties voor kleding die bij jouw baan horen. Klik op een optie om deze in te zien.",
            disabled = true,
        },
        {
            title = PlayerData.label,
            description = 'Klik hier om alle kleding voor ' .. PlayerData.label .. ' te zien.',
            icon = 'fas fa-shirt',
            onSelect = function() openMenu(PlayerData) end
        },
    }    

    lib.registerContext({ id = 'mikeyseup', title = 'Mikey\'s EUP 1.3', options = options })
    lib.showContext('mikeyseup')
end)

RegisterNetEvent('mtc-mikeyseup:client:openAdminMenu', function ()
    lib.registerContext({
        id = 'mikeyseupA',
        title = 'Mikey\'s EUP 1.3',
        options = {
            {
                title = "Beschikbare opties",
                description = "Hieronder zie je de voor jou beschikbare opties voor kleding die bij de beschikbare banen horen. Klik op een optie om deze in te zien.",
                disabled = true,
            }, {
                title = 'Politie',
                description = 'Klik hier om alle beschikbare kleding te zien voor deze baan.',
                icon = 'fas fa-shirt',
                onSelect = function() openMenu('police') end
            }, {
                title = 'Ambulance',
                description = 'Klik hier om alle beschikbare kleding te zien voor deze baan.',
                icon = 'fas fa-shirt',
                onSelect = function() openMenu('ambulance') end
            }, {
                title = 'Brandweer',
                description = 'Klik hier om alle beschikbare kleding te zien voor deze baan.',
                icon = 'fas fa-shirt',
                onSelect = function() openMenu('firedepartment') end
            }, {
                title = 'Koninklijke Marechaussee',
                description = 'Klik hier om alle beschikbare kleding te zien voor deze baan.',
                icon = 'fas fa-shirt',
                onSelect = function() openMenu('borderpatrol') end
            }, {
                title = 'Defensie',
                description = 'Klik hier om alle beschikbare kleding te zien voor deze baan.',
                icon = 'fas fa-shirt',
                onSelect = function() openMenu('army') end
            }, {
                title = 'Justitie',
                description = 'Klik hier om alle beschikbare kleding te zien voor deze baan.',
                icon = 'fas fa-shirt',
                onSelect = function() openMenu('justice') end
            }, {
                title = 'ANWB',
                description = 'Klik hier om alle beschikbare kleding te zien voor deze baan.',
                icon = 'fas fa-shirt',
                onSelect = function() openMenu('mechanic') end
            }, {
                title = 'Special Forces',
                description = 'Klik hier om alle beschikbare kleding te zien voor deze baan,',
                icon = 'fas fa-shirt',
                onSelect = function() openMenu('specialforces') end
            }
        }
    })

    lib.showContext('mikeyseupA')
end)
