Shared = {}

-- Jobs
Shared.PoliceJob = 'police' -- done
Shared.AmbulanceJob = 'ambulance' -- done
Shared.FireDepartmentJob = 'firedepartment' -- done
Shared.BorderPatrol = 'kmar' -- done
Shared.Justice = 'justice' -- done
Shared.MechanicJob = 'mechanic' -- done
Shared.Army = 'defensie' -- done
Shared.SpecialForces = 'dsi' -- done

-- Frameworks
Shared.Framework = 'esx' -- 'qb-core' or 'esx'  or 'standalone'

Shared.Clothing = {}

if Shared.Framework == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
end

if Shared.Framework == 'esx' then
    -- Uncomment if using old version of esx
    --ESX = nil
    --TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end