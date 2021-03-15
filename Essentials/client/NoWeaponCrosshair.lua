local crosshairEnabled = false
local WeaponTable = {
    [GetHashKey('weapon_sniperrifle')] = true,
    [GetHashKey('weapon_heavysniper')] = true,
    [GetHashKey('weapon_heavysniper_mk2')] = true,
    [GetHashKey('weapon_marksmanrifle')] = true,
    [GetHashKey('weapon_marksmanrifle_mk2')] = true
}
ToggleWeaponCrosshair = function()
    if (not crosshairEnabled) then
      TriggerEvent("chatMessage","^1Tinta: ^0Ti-ai activat tinta pe arme!")
      crosshairEnabled = true
    else
      TriggerEvent("chatMessage","^1Tinta: ^0Ti-ai dezactivat tinta pe arme!")
      crosshairEnabled = false
    end
end
isWeaponScoped = function(weaponHash)
  for hash,_ in pairs(WeaponTable) do
    if (weaponHash == hash) then return true end
  end
  return false
end
CreateThread(function()
    while true do
      while (not crosshairEnabled) do
        local ped = PlayerPedId()
        local _,weaponHash = GetCurrentPedWeapon(ped,true)
        if (not isWeaponScoped(weaponHash)) then 
            HideHudComponentThisFrame( 14 )
          end
        Wait(1)
      end
      Wait(500)
    end
end)
RegisterNetEvent('ToggleWeaponCrosshair')
AddEventHandler('ToggleWeaponCrosshair',ToggleWeaponCrosshair)

if Config.ToggleCrosshair then
  RegisterCommand("toggleCrosshair",function(...)
    ToggleWeaponCrosshair()
  end)
end