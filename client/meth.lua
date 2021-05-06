ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

IsSellingMeth = false
IsWaitingMeth = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DrawMarker(27, Config.Locations.MethVerkoop.x, Config.Locations.MethVerkoop.y, Config.Locations.MethVerkoop.z, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 1.0, 0, 255, 0, 100, 0, 0, 0, 0, 0, 0, 0)
    end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
        if GetDistanceBetweenCoords(Config.Locations.MethVerkoop.x, Config.Locations.MethVerkoop.y, Config.Locations.MethVerkoop.z, GetEntityCoords(GetPlayerPed(-1),true)) < 2.5 then
            if IsSellingMeth == false then
                HelpText("Druk op ~INPUT_CONTEXT~ om je zakjes meth te verkopen",0,1,0.5,0.8,0.6,255,255,255,255)
            end
  
            if IsControlJustPressed(1,38) and IsSellingMeth == false then
                IsSellingMeth = true
            end
        else
            if IsSellingMeth == true then
                IsSellingMeth = false
                notify("~r~Verkoop gestaakt, je hebt de cirkel verlaten.")
            end
        end

        if IsSellingMeth == true and IsWaitingMeth == false then
            IsWaitingMeth = true
            Citizen.Wait(500)
            ESX.TriggerServerCallback('macerz:MethCount', function(xMeth)
                if xMeth > 0 then
                    RandomZakjes = math.random(1, 3)
                    CalcMethPrice = math.random(Config.Pricing.Meth.Min, Config.Pricing.Meth.Max)

                    if RandomZakjes > xMeth then
                        RandomZakjes = xMeth
                    end

                    MethPrice = RandomZakjes * CalcMethPrice
                    TriggerServerEvent('macerz:SellMeth', RandomZakjes, MethPrice)
                    notify("Je hebt ~g~"..RandomZakjes.."x ~s~zakjes meth verkocht voor ~g~$"..MethPrice)
                else
                    notify("~r~Je hebt niet genoeg zakjes meth om te verkopen")
                    IsSellingMeth = false
                end
            end)
            Citizen.Wait(5000)
            IsWaitingMeth = false

        end
    end
  end)

function HelpText(text, state)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

function notify(str)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(str)
    EndTextCommandThefeedPostTicker(true, false)
end