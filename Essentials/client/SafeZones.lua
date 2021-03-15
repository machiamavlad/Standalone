inSafeZone = false
safeZone = nil
local maxspeed = 50
local kmh = 3.6 -- RO: 1.6 daca vreti mile pe ora :c || EN: 1.6 if you want to use miles per hour 
local CreateThread = Citizen.CreateThread
local safeZones = { 
    ['Showroom'] = {pos = vector3(-43.726108551026,-1101.1746826172,35.20348739624),radius = 40.0},
    ['Spawn'] = {pos = vector3(-536.8734741211,-219.0591430664,37.64977645874),radius = 35.0},
    ['Spital'] = {pos = vector3(-474.73635864258,-327.21185302734,34.370166778564),radius = 35.0}
}

local drawText = function(x,y,scale,text,font,outline)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale,scale)
    SetTextColour(255,255,255,255)
    SetTextDropShadow(50,5,5,5,255)
    if outline then
        SetTextOutline()
    end
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

CreateThread(function()
	CreateThread(function()
		local ticks = 500
		while true do
			local ped = PlayerPedId()

			if (inSafeZone) then
				ticks = 1
				-- print(cacat)
				drawText(0.5,0.005,0.5,'Te aflii in ~g~SafeZone',7,false)
	
				DisableControlAction(0,24,true)
				DisableControlAction(0,25,true)
				DisableControlAction(0,47,true)
				DisableControlAction(0,58,true)
				DisableControlAction(0,263,true)
				DisableControlAction(0,264,true)
				DisableControlAction(0,257,true)
				DisableControlAction(0,140,true)
				DisableControlAction(0,141,true)
				DisableControlAction(0,142,true)
				DisableControlAction(0,143,true)

				SetVehicleMaxSpeed(GetVehiclePedIsIn(ped, false),maxspeed / kmh)
				-- SetVehicleMaxSpeed(GetVehiclePedIsIn(ped, false), maxspeed / kmheed)
	
				SetEntityInvincible(ped, true)
				SetEntityInvincible(PlayerId(), true)
				ResetPedVisibleDamage(ped)
				ClearPedBloodDamage(ped)
				SetEntityCanBeDamaged(ped, false)
				NetworkSetFriendlyFireOption(false)
	
			else
				ticks = 500
				SetVehicleMaxSpeed(GetVehiclePedIsIn(ped, false),11001.5)
				SetEntityInvincible(ped, false)
				SetEntityInvincible(PlayerId(), false)
				SetEntityCanBeDamaged(ped, true)
				NetworkSetFriendlyFireOption(true)
			end
			Wait(ticks)
			ticks = 500
		end
	end)
    while true do
        Wait(500)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for key,value in pairs(safeZones) do
            pos = value.pos
            radius = value.radius
            if #(coords - pos) < radius then
                inSafeZone = true
                safeZone = key
            end
        end
        if safeZone ~= nil then
            pos = safeZones[safeZone].pos
			radius = safeZones[safeZone].radius
			--print(#(pos - coords) > radius)
            if #(pos - coords) > radius then
                inSafeZone = false
                safeZone = nil
            end
        end
    end
end)
