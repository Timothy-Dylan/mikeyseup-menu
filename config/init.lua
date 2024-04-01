mEUP = {}
local Config = require('config.config')

-- For the sake of being chill to receive frameworks
if Config.Framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'esx' then
    -- Enable if version is lower than 9.0.0
    -- ESX = nil
    -- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end