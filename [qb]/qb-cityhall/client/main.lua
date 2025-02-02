local inCityhallPage = false
local qbCityhall = {}

--[[qbCityhall.Open = function()
    SendNUIMessage({
        action = "open"
    })
    SetNuiFocus(true, true)
    inCityhallPage = true
end

qbCityhall.Close = function()
    SendNUIMessage({
        action = "close"
    })
    SetNuiFocus(false, false)
    inCityhallPage = false
end

qbCityhall.DrawText3Ds = function(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    inCityhallPage = false
end)

local inRange = false]]

Citizen.CreateThread(function()
    CityhallBlip = AddBlipForCoord(Config.Cityhall.coords)

    SetBlipSprite (CityhallBlip, 487)
    SetBlipDisplay(CityhallBlip, 4)
    SetBlipScale  (CityhallBlip, 0.65)
    SetBlipAsShortRange(CityhallBlip, true)
    SetBlipColour(CityhallBlip, 0)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("City Services")
    EndTextCommandSetBlipName(CityhallBlip)
end)

--[[local creatingCompany = false
local currentName = nil
Citizen.CreateThread(function()
    while true do

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        inRange = false

        local dist = #(pos - Config.Cityhall.coords)
        local dist2 = #(pos - Config.DrivingSchool.coords)

        if dist < 20 then
            inRange = true
            DrawMarker(2, Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
            if #(pos - vector3(Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z)) < 1.5 then
                qbCityhall.DrawText3Ds(Config.Cityhall.coords, '~g~E~w~ - City Services Menu')
                if IsControlJustPressed(0, 38) then
                    qbCityhall.Open()
                end
            end
        end

        if not inRange then
            Citizen.Wait(1000)
        end

        Citizen.Wait(2)
    end
end)

RegisterNetEvent('qb-cityhall:client:OpenCD')
AddEventHandler('qb-cityhall:client:OpenCD', function()
    SendNUIMessage({
        action = "open"
    })
    SetNuiFocus(true, true)
    inCityhallPage = true
end)]]--

----------------------------------
---------BT-NH-CITYHALL-----------
----------------------------------

RegisterNetEvent('qb-cityhall:client:requestdl')
AddEventHandler('qb-cityhall:client:requestdl', function()
 if not dmvrequest then
                        dmvrequest = true
                        TriggerServerEvent('qb-cityhall:server:sendDriverTest')                       
                    else
                        QBCore.Functions.Notify("You have already requested lessons!", 'error', 5000)
                    --end
                --end
            end
end)

RegisterNetEvent('cityhall')
AddEventHandler('cityhall', function()
  TriggerEvent('nh-context:sendMenu', {
        {
        id = 1,
        header = "City Hall",
        txt = ""
        },
        {
            id = 2,
            header = "Take ID Cards",
            txt = "ID & DL Cards",
            params = {
                event = "idlist"
            }
        },
        {
            id = 3,
            header = "Take a Job",
            txt = "Access the job sector",
            params = {
                event = "joblist"
            }
        }, 
})
end)

RegisterNetEvent('joblist')
AddEventHandler('joblist', function()
  TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Avaliable Jobs",
            txt = ""
        },
        {
            id = 2,
            header = "Taxi Driver",
            txt = "Starting Salary - £150",
            params = {
                event = "qb-cityhall:client:Taxijob"
            }
        },
        {
            id = 3,
            header = "Truck Driver",
            txt = "Starting Salary - £300",
            params = {
                event = "qb-cityhall:client:Truckerjob"
            }
        },
        {
            id = 4,
            header = "Tow Truck Driver",
            txt = "Starting Salary - 325",
            params = {
                event = "qb-cityhall:client:Towjob"
            }
        },
        {
            id = 5,
            header = "Garbage Collector",
            txt = "Starting Salary - £275",
            params = {
                event = "qb-cityhall:client:Garbagejob"
            }
        },
        {
          id = 6,
          header = "Close (ESC)",
          txt = "",
          params = {
              event = "nh-context:closeMenu",
          }
        }, 
    })
end)

RegisterNetEvent('idlist')
AddEventHandler('idlist', function()
  TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Identity Menu",
            txt = ""
        },
        {
            id = 2,
            header = "Replace ID Card",
            txt = "Price - $50",
            params = {
                event = "qb-cityhall:client:GiveIDCard"
            }
        },
        {
            id = 3,
            header = "Replace Drivers Lisence",
            txt = "Price - $50",
            params = {
                event = "qb-cityhall:client:GiveDL"
            }
        },
        --[[{
            id = 4,
            header = "• Replace Weapons Lisence",
            txt = "(Currently Not Working!!)",
            params = {
                event = "qb-cityhall:server:GiveWL"
            }
        },]]--
        {
          id = 4,
          header = "Close (ESC)",
          txt = "",
          params = {
              event = "nh-context:closeMenu",
          }
        }, 
    })
end)

-----------------------------------------
---------BT-NH-CITYHALL-EVENTS-----------
-----------------------------------------

RegisterNetEvent('qb-cityhall:client:Garbagejob')
AddEventHandler('qb-cityhall:client:Garbagejob', function()
    TriggerServerEvent('qb-cityhall:server:Garbagejob')
end)

RegisterNetEvent('qb-cityhall:client:Towjob')
AddEventHandler('qb-cityhall:client:Towjob', function()
    TriggerServerEvent('qb-cityhall:server:Towjob')
end)

RegisterNetEvent('qb-cityhall:client:Truckerjob')
AddEventHandler('qb-cityhall:client:Truckerjob', function()
    TriggerServerEvent('qb-cityhall:server:Truckerjob')
end)

RegisterNetEvent('qb-cityhall:client:Taxijob')
AddEventHandler('qb-cityhall:client:Taxijob', function()
    TriggerServerEvent('qb-cityhall:server:Taxijob')
end)

RegisterNetEvent('qb-cityhall:client:GiveIDCard')
AddEventHandler('qb-cityhall:client:GiveIDCard', function()
    TriggerServerEvent('qb-cityhall:server:GiveIDCard')
end)

RegisterNetEvent('qb-cityhall:client:GiveDL')
AddEventHandler('qb-cityhall:client:GiveDL', function()
    TriggerServerEvent('qb-cityhall:server:GiveDL')
end)

-----------------------------------------
-----------------------------------------
-----------------------------------------

RegisterNetEvent('qb-cityhall:client:getIds')
AddEventHandler('qb-cityhall:client:getIds', function()
    TriggerServerEvent('qb-cityhall:server:getIDs')
end)

RegisterNetEvent('qb-cityhall:client:sendDriverEmail')
AddEventHandler('qb-cityhall:client:sendDriverEmail', function(charinfo)
    SetTimeout(math.random(2500, 4000), function()
        local gender = "Mr"
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = "Mrs"
        end
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "Township",
            subject = "Driving lessons request",
            message = "Hello " .. gender .. " " .. charinfo.lastname .. ",<br /><br />We have just received a message that someone wants to take driving lessons<br />If you are willing to teach, please contact us:<br />Naam: <strong>".. charinfo.firstname .. " " .. charinfo.lastname .. "</strong><br />Phone Number: <strong>"..charinfo.phone.."</strong><br/><br/>Kind regards,<br />Township Los Santos",
            button = {}
        })
    end)
end)

local idTypes = {
    ["id_card"] = {
        label = "Birth Certificate",
        item = "id_card"
    },
    ["driver_license"] = {
        label = "Drivers License",
        item = "driver_license"
    },
    ["weaponlicense"] = {
        label = "Firearms License",
        item = "weaponlicense"
    }
}

RegisterNUICallback('requestId', function(data)
    if inRange then
        local idType = data.idType

        TriggerServerEvent('qb-cityhall:server:requestId', idTypes[idType])
        QBCore.Functions.Notify('You have recived your '..idTypes[idType].label..' for $50', 'success', 3500)
    else
        QBCore.Functions.Notify('This will not work', 'error')
    end
end)

RegisterNUICallback('requestLicenses', function(data, cb)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local licensesMeta = PlayerData.metadata["licences"]
    local availableLicenses = {}

    for type,_ in pairs(licensesMeta) do
        if licensesMeta[type] then
            local licenseType = nil
            local label = nil

            if type == "driver" then 
                licenseType = "driver_license" 
                label = "Drivers Licence" 
            elseif type == "weapon" then
                licenseType = "weaponlicense"
                label = "Firearms License"
            end

            table.insert(availableLicenses, {
                idType = licenseType,
                label = label
            })
        end
    end
    cb(availableLicenses)
end)

local AvailableJobs = {
    "trucker",
    "taxi",
    "tow",
    "reporter",
    "garbage",
}

function IsAvailableJob(job)
    local retval = false
    for k, v in pairs(AvailableJobs) do
        if v == job then
            retval = true
        end
    end
    return retval
end

RegisterNUICallback('applyJob', function(data)
    if inRange then
        if IsAvailableJob(data.job) then
            TriggerServerEvent('qb-cityhall:server:ApplyJob', data.job)
        else
            TriggerServerEvent('qb-cityhall:server:banPlayer')
            TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "POST Request (Abuse)", "red", "** @everyone " ..GetPlayerName(player).. "** has been banned for abusing localhost:13172, sending POST request\'s")         
        end
    else
        QBCore.Functions.Notify('Unfortunately will not work ...', 'error')
    end
end)
