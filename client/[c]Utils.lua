ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent(_ArmurerieLSPD.ESX, function(obj) ESX = obj end)
        Citizen.Wait(80)
    end
    -- https://discord.gg/g9dXrcAcwn
    TriggerEvent("ArmurerieLSPD:blips")
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
    ESX.PlayerData.job = job  
end)

local tablepositionsandblips = _ArmurerieLSPD.PositionsArmurerieLSPD
function _ArmurerieLSPD.Menu:Main()
    _ArmurerieLSPD.Menu.Create()
    RageUI.Visible(_ArmurerieLSPD.Menu.main, not RageUI.Visible(_ArmurerieLSPD.Menu.main))
    TriggerServerEvent(("%s:SQLArmurerie"):format(_ArmurerieLSPD.Event.Prefix))
	FreezeEntityPosition(PlayerPedId(),true)
    while _ArmurerieLSPD.Menu.main do
        Citizen.Wait(0)
        RageUI.IsVisible(_ArmurerieLSPD.Menu.main, function()
            _ArmurerieLSPD.ArmurerieLSPDButton()
        end)
        RageUI.IsVisible(_ArmurerieLSPD.Menu.submain, function()
            _ArmurerieLSPD.SubButton()
        end)
        RageUI.IsVisible(_ArmurerieLSPD.Menu.submain2, function()
            _ArmurerieLSPD.SubButton2()
        end)
        RageUI.IsVisible(_ArmurerieLSPD.Menu.subhistoriquemain, function()
            _ArmurerieLSPD.Historique()
        end)
        if not RageUI.Visible(_ArmurerieLSPD.Menu.main) 
        and not RageUI.Visible(_ArmurerieLSPD.Menu.submain) 
        and not RageUI.Visible(_ArmurerieLSPD.Menu.submain2) 
        and not RageUI.Visible(_ArmurerieLSPD.Menu.subhistoriquemain)
        then 
            _ArmurerieLSPD.Menu.main = RMenu:DeleteType("_ArmurerieLSPD.Menu.main", true, FreezeEntityPosition(PlayerPedId(),false))
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local wait = 700
        local playerPos = GetEntityCoords(PlayerPedId())
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == _ArmurerieLSPD.JobAcces then
            for k,v in pairs(tablepositionsandblips) do
                local PositionArmurerie = vec3(v.pos)
                local dst1 = #(playerPos - PositionArmurerie)
                if dst1 < 5.0 then
                    wait = 0
                    DrawMarker(_ArmurerieLSPD.Markers.Type, PositionArmurerie.x, PositionArmurerie.y, PositionArmurerie.z, 0, 0, 0, 0, 0, 0, _ArmurerieLSPD.Markers.TailleX, _ArmurerieLSPD.Markers.TailleY, _ArmurerieLSPD.Markers.TailleZ, _ArmurerieLSPD.Markers.CouleurR, _ArmurerieLSPD.Markers.CouleurG, _ArmurerieLSPD.Markers.CouleurB, _ArmurerieLSPD.Markers.Opacite, 0, 0, 0, 1, 0, 0, 0)
                    if dst1 < 1.5 then
                        ESX.ShowHelpNotification(_ArmurerieLSPD.Translations.Menu.HelpNotif)
                        if IsControlJustReleased(1, 38) then
                            _ArmurerieLSPD.Menu:Main()
                        end
                    end
                end
            end
        end
        Wait(wait)
    end
end)


function _ArmurerieLSPD.KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

function animped()
	RequestAnimDict('mp_cop_armoury')
	while not HasAnimDictLoaded('mp_cop_armoury') do
	   Wait(1000)
	end
	TaskPlayAnim(peds, 'mp_cop_armoury', 'pistol_on_counter_cop',8.0, -8.0, -1, 0, 0, false, false, false )
end

function animplayer()
	RequestAnimDict('mp_common')
	while not HasAnimDictLoaded('mp_common') do
	   Wait(1000)
	end
	TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_b',8.0, -8.0, -1, 0, 0, false, false, false )
end

RegisterNetEvent("ArmurerieLSPD:blips")
AddEventHandler("ArmurerieLSPD:blips", function()
    for k,v in pairs(tablepositionsandblips) do
        blip = AddBlipForCoord(v.pos.x,v.pos.y,v.pos.z)
        SetBlipSprite(blip, _ArmurerieLSPD.Blips.Sprite)
        SetBlipScale(blip, _ArmurerieLSPD.Blips.Scale)
        SetBlipColour(blip, _ArmurerieLSPD.Blips.Color)
        SetBlipDisplay(blip, _ArmurerieLSPD.Blips.Display)
        SetBlipAsShortRange(blip, _ArmurerieLSPD.Blips.ShortRange)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_ArmurerieLSPD.Blips.Name)
        EndTextCommandSetBlipName(blip)
    end
    for k,v in pairs(_ArmurerieLSPD.PositionsPed) do 
        RequestModel(GetHashKey(v.name))
        while not HasModelLoaded(GetHashKey(v.name)) do Wait(1) end
        peds = CreatePed(4, v.name, v.pos[1], v.pos[2], v.pos[3], 3374176, false, true)
        SetEntityHeading(peds, v.pos[4])
        FreezeEntityPosition(peds, true)
        SetEntityInvincible(peds, true)
        TaskStartScenarioInPlace(peds, v.animation, 0, true)
        SetBlockingOfNonTemporaryEvents(peds, true)
    end
end)
