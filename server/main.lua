lib.addCommand('mikeys', {
    help = 'Mikey\'s EUP UI 1.3 gebasseerd op de speler zijn of haar baan.',
}, function (source, _, raw)
    TriggerClientEvent('mtc-mikeyseup:client:openMenu', source)
end)

lib.addCommand('mikeysa', {
    help = 'Mikey\'s EUP UI 1.3 gebasseerd op de speler zijn of haar ace permissies.',
    restricted = 'group.admin'
}, function (source, _, raw)
    if not Shared.Framework == 'standalone' then
        if not restricted then lib.notify({ title = 'Mikey\'s EUP 1.3', description = 'Je hebt geen toestemming om dit menu te openen', iconAnimation = 'beatFade', duration = 7500, type = 'error' }) return end
    end
    
    TriggerClientEvent('mtc-mikeyseup:client:openAdminMenu', source)
end)
