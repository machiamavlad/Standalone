RegisterCommand("suitcase", function(source, args)
    local player = PlayerPedId()
    if tonumber(args[1]) ~= 1 and tonumber(args[1]) ~= 2 then
        TriggerEvent('chatMessage', '^1Syntax^7: /suitcase ^11 ^7/ ^12')
    else
        if DoesEntityExist(player) and not IsEntityDead(player) then
            local nr = tonumber(args[1])
            if nr == 1 then
                GiveWeaponToPed(player, 0x88C78EB7, 1, false, true);
            else
                GiveWeaponToPed(player, 0x01B79F17, 1, false, true);
            end
        end
    end
end)