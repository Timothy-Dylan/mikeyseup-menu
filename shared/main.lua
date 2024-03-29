Shared = {}

-- Jobs
Shared.PoliceJob = 'police'
Shared.AmbulanceJob = 'ambulance'
Shared.FireDepartmentJob = 'firedepartment'
Shared.BorderPatrol = 'douane'
Shared.Justice = 'justice'
Shared.RoyalMarshal = 'kmar'
Shared.MechanicJob = 'mechanic'

-- Frameworks
Shared.Framework = 'qb-core' -- 'qb-core' or 'esx' or 'standalone'

Shared.Clothing = {}

if Shared.Framework == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
end

if Shared.Framework == 'esx' then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end