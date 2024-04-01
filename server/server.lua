--- The command to open the EUP menu
lib.addCommand('mikeys', {
    help = 'Mikey\'s EUP UI 1.3 gebasseerd op de speler zijn of haar baan.',
}, function (source, _, raw)
    TriggerClientEvent('mikeyseup:client:openMenu', source)
end)

--- The command to open the EUP admin menu where you can see all the available clothign types
lib.addCommand('mikeysa', {
    help = 'Mikey\'s EUP UI 1.3 gebasseerd op de speler zijn of haar ace permissies.',
    restricted = 'group.admin'
}, function (source, _, raw) 
    TriggerClientEvent('mikeyseup:client:openAdminMenu', source)
end)