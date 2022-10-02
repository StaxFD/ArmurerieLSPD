ESX = nil 
TriggerEvent(_ArmurerieLSPD.ESX, function(obj) ESX = obj end)

RegisterNetEvent(("%s:addWeapon"):format(_ArmurerieLSPD.Event.Prefix))
AddEventHandler(("%s:addWeapon"):format(_ArmurerieLSPD.Event.Prefix), function(name, label)
    local src = source 
    if (not (src)) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(src)  
    if (not (xPlayer)) then
        return
    end
    MySQL.Async.fetchAll("SELECT * FROM armurerie_lspd WHERE name = @name", {
        ["@name"] = name,
    }, function(result)
        if (result[1]) then
            if (tonumber(result[1].stock) <= 0) then
                TriggerClientEvent("esx:showNotification", src, "~r~Stock de [~s~"..label.."~r~] vide!")
                return 
            end
            result[1].stock = result[1].stock - 1
            MySQL.Async.execute("UPDATE armurerie_lspd SET stock = @stock WHERE name = @name", {
                ["@name"] = name,
                ["@stock"] = result[1].stock,
            }, function(result)
                if (result) then
                    xPlayer.addInventoryItem(name, 1)
                    TriggerClientEvent("esx:showNotification", src, "Vous avez pris [x1 ~g~"..label.."~s~] dans le stock!")
                end
            end)
            TriggerClientEvent(("%s:addWeapon"):format(_ArmurerieLSPD.Event.Prefix), src, result[1])
        end
    end)
end) 

RegisterNetEvent(("%s:InsertSQLArmurerie_"):format(_ArmurerieLSPD.Event.Prefix))
AddEventHandler(("%s:InsertSQLArmurerie_"):format(_ArmurerieLSPD.Event.Prefix), function(data)
    local src = source 
    if (not (src)) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(src)  
    if (not (xPlayer)) then
        return
    end
    local config = _ArmurerieLSPD.Armes[data]
    local xMoney = xPlayer.getMoney()
    MySQL.Async.fetchAll("SELECT * FROM armurerie_lspd WHERE name = @name", {
        ["@name"] = config.name,
    }, function(result)
        if (result[1]) then
            if (config.Maxstock <= tonumber(result[1].stock)) then
                TriggerClientEvent("esx:showNotification", src, "~r~Stock plein !")
                return 
            end
            result[1].stock = result[1].stock + 1
            MySQL.Async.execute("UPDATE armurerie_lspd SET stock = @stock WHERE name = @name", {
                ["@name"] = config.name,
                ["@stock"] = result[1].stock,
            }, function(result)
                if (result) then
                    if xMoney >= config.price then
                        xPlayer.removeAccountMoney('bank', config.price)
                        TriggerClientEvent("esx:showNotification", src, "- Vous avez acheté ~g~"..config.label.."~s~\n- Prix : ~g~"..config.price.."~s~$\n- ~g~+1~s~ dans le stock")
                    else
                        TriggerClientEvent(_ArmurerieLSPD.Translations.Menu.TypeNotif, src, _ArmurerieLSPD.Translations.Menu.No_Money)
                    end
                end
            end) 
        else
            MySQL.Async.execute("INSERT INTO armurerie_lspd (name, label, stock, grade) VALUES (@name, @label, @stock, @grade)", {
                ["@name"] = config.name,
                ["@label"] = config.label,
                ["@stock"] = 1,
                ["@grade"] = config.grade,
            }, function(result)
                if (result) then
                    if xMoney >= config.price then
                        xPlayer.removeAccountMoney('bank', config.price)
                        TriggerClientEvent("esx:showNotification", src, "- Vous avez acheté ~g~"..config.label.."~s~\n- Prix : ~g~"..config.price.."~s~$\n- ~g~+1~s~ dans le stock")
                    else
                        TriggerClientEvent(_ArmurerieLSPD.Translations.Menu.TypeNotif, src, _ArmurerieLSPD.Translations.Menu.No_Money)
                    end
                end
            end)
        end
        if (result) then
            TriggerClientEvent(("%s:InsertSQLArmurerie_"):format(_ArmurerieLSPD.Event.Prefix), src, result)
        end
    end)
end)

--https://discord.gg/g9dXrcAcwn
RegisterNetEvent(("%s:SQLArmurerie"):format(_ArmurerieLSPD.Event.Prefix))
AddEventHandler(("%s:SQLArmurerie"):format(_ArmurerieLSPD.Event.Prefix), function()
    local src = source 
    if (not (src)) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(src)  
    if (not (xPlayer)) then
        return
    end
    MySQL.Async.fetchAll("SELECT * FROM armurerie_lspd", {}, function(result)
        if (result) then
            TriggerClientEvent(("%s:SQLArmurerie"):format(_ArmurerieLSPD.Event.Prefix), src, result)
        end
    end)
end)

RegisterNetEvent(("%s:InsertSQLArmurerie_2"):format(_ArmurerieLSPD.Event.Prefix))
AddEventHandler(("%s:InsertSQLArmurerie_2"):format(_ArmurerieLSPD.Event.Prefix), function(data, number)
    local src = source 
    if (not (src)) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(src)  
    if (not (xPlayer)) then
        return
    end
    local config = _ArmurerieLSPD.Armes[data]
    local xMoney = xPlayer.getMoney()
    MySQL.Async.fetchAll("SELECT * FROM armurerie_lspd WHERE name = @name", {
        ["@name"] = config.name,
    }, function(result)
        if (result[1]) then
            result[1].stock = result[1].stock + number
            MySQL.Async.execute("UPDATE armurerie_lspd SET stock = @stock WHERE name = @name", {
                ["@name"] = config.name,
                ["@stock"] = result[1].stock,
            }, function(result)
                if (result) then
                    TriggerClientEvent("esx:showNotification", src, "- Vous avez déposé ~r~x"..number.." "..config.label.."~s~ dans le stock")
                end
            end)
        else
            MySQL.Async.execute("INSERT INTO armurerie_lspd (name, label, stock) VALUES (@name, @label, @stock)", {
                ["@name"] = config.name,
                ["@label"] = config.label,
                ["@stock"] = 1,
            }, function(result)
                if (result) then
                    print("ok")
                end
            end)
        end
        if (result) then
            TriggerClientEvent(("%s:InsertSQLArmurerie_2"):format(_ArmurerieLSPD.Event.Prefix), src, result)
        end
    end)
end)
-- Déposer Armes dans le stock
    RegisterNetEvent(("%s:RemoveItems_"):format(_ArmurerieLSPD.Event.Prefix))
    AddEventHandler(("%s:RemoveItems_"):format(_ArmurerieLSPD.Event.Prefix), function(type, objects, number)
        local src = source 
        if (not (src)) then
            return
        end
        local xPlayer = ESX.GetPlayerFromId(src)  
        if (not (xPlayer)) then
            return
        end
        if type == "weapon" then
            xPlayer.removeWeapon(objects) 
        elseif type == "item" then
            xPlayer.removeInventoryItem(objects, number)
        end
    end)
--
----- Historique ----- 
    local function getDate()
        return os.date("*t", os.time()).day.."/"..os.date("*t", os.time()).month.."/"..os.date("*t", os.time()).year.." à "..os.date("*t", os.time()).hour.."h"..os.date("*t", os.time()).min
    end

    RegisterNetEvent(("%s:InsertSQLHistorique_"):format(_ArmurerieLSPD.Event.Prefix))
    AddEventHandler(("%s:InsertSQLHistorique_"):format(_ArmurerieLSPD.Event.Prefix), function(type, weapon)
        local src = source 
        if (not (src)) then
            return
        end
        local xPlayer = ESX.GetPlayerFromId(src)  
        if (not (xPlayer)) then
            return
        end
        MySQL.Async.execute('INSERT INTO armurerieLSPD_historique (type, weapon, nom, date) VALUES (@type, @weapon, @nom, @date)', {
            ['@type'] = type,
            ['@weapon'] = weapon,
            ['@nom'] = xPlayer.getName(),		
            ['@date'] = getDate(),
        })
    end)

    RegisterNetEvent(("%s:SQLHistorique"):format(_ArmurerieLSPD.Event.Prefix))
    AddEventHandler(("%s:SQLHistorique"):format(_ArmurerieLSPD.Event.Prefix), function()
        local src = source 
        if (not (src)) then
            return
        end
        local xPlayer = ESX.GetPlayerFromId(src)  
        if (not (xPlayer)) then
            return
        end
        MySQL.Async.fetchAll("SELECT * FROM armurerieLSPD_historique", {}, function(result)
            if (result) then
                TriggerClientEvent(("%s:SQLHistorique"):format(_ArmurerieLSPD.Event.Prefix), src, result)
            end
        end)
    end)

    RegisterNetEvent(("%s:SupprimerTableHistoriqueLSPD_"):format(_ArmurerieLSPD.Event.Prefix))
    AddEventHandler(("%s:SupprimerTableHistoriqueLSPD_"):format(_ArmurerieLSPD.Event.Prefix), function()
        local src = source 
        if (not (src)) then
            return
        end
        MySQL.Async.execute("DELETE FROM armurerieLSPD_historique")
    end)

    RegisterNetEvent(("%s:SupprimerHistoriqueLSPD_"):format(_ArmurerieLSPD.Event.Prefix))
    AddEventHandler(("%s:SupprimerHistoriqueLSPD_"):format(_ArmurerieLSPD.Event.Prefix), function(value, id)
        local src = source 
        if (not (src)) then
            return
        end
        if value == 1 then
            MySQL.Async.execute("DELETE FROM armurerieLSPD_historique WHERE id ='"..id.."'")
        elseif value == 2 then
            MySQL.Async.execute("DELETE FROM armurerieLSPD_historique")
        end
    end)
--------