icons = {
	{"discordIcon", "discordIcon", "discordIcon"},
	{"ipIcon", "ipIcon", "ipIcon"},
	{"hideHud", "hideHud", "hideHud"},
	{"hideHudG", "hideHudG", "hideHudG"},
	{"heart", "heart", "heart"},
	{"recoil", "recoil", "recoil"}

}



function loadAllIcons()
	for i, v in pairs(icons) do
		local txd = CreateRuntimeTxd(v[1])
		CreateRuntimeTextureFromImage(txd, v[2], "icons/"..v[3]..".png")
	end
end


Citizen.CreateThread(function()
	loadAllIcons()
end)

function DrawImage3D(name1, name2, x, y, z, width, height, rot, r, g, b, alpha) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, true)
	
    if onScreen then
		local width = (1/dist)*width
		local height = (1/dist)*height
		local fov = (1/GetGameplayCamFov())*100
		local width = width*fov
		local height = height*fov
	
		local CoordFrom = GetEntityCoords(PlayerPedId(), true)
        local RayHandle = StartShapeTestRay(CoordFrom.x, CoordFrom.y, CoordFrom.z, x, y, z, -1, PlayerPedId(), 0)
        local _, _, _, _, object = GetShapeTestResult(RayHandle)
		if(object == 0) or (object == nil)then
			DrawSprite(name1, name2, _x, _y, width, height, rot, r, g, b, alpha)
		end
	end
end
