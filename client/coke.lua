ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

IsSellingCoke = false
IsWaitingCoke = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DrawMarker(27, Config.Locations.CokeVerkoop.x, Config.Locations.CokeVerkoop.y, Config.Locations.CokeVerkoop.z, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 1.0, 0, 255, 0, 100, 0, 0, 0, 0, 0, 0, 0)
    end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
        if GetDistanceBetweenCoords(Config.Locations.CokeVerkoop.x, Config.Locations.CokeVerkoop.y, Config.Locations.CokeVerkoop.z, GetEntityCoords(GetPlayerPed(-1),true)) < 2.5 then
            if IsSellingCoke == false then
                HelpText("Press ~INPUT_CONTEXT~ to sell your coke",0,1,0.5,0.8,0.6,255,255,255,255)
            end
  
            if IsControlJustPressed(1,38) and IsSellingCoke == false then
                IsSellingCoke = true
            end
        else
            if IsSellingCoke == true then
                IsSellingCoke = false
                notify("~r~Action cancelled, you moved too far away.")
            end
        end

        if IsSellingCoke == true and IsWaitingCoke == false then
            IsWaitingCoke = true
            Citizen.Wait(500)
            ESX.TriggerServerCallback('macerz:CokeCount', function(xCoke)
                if xCoke > 0 then
                    RandomZakjes = math.random(1, 3)
                    CalcCokePrice = math.random(Config.Pricing.Coke.Min, Config.Pricing.Coke.Max)

                    if RandomZakjes > xCoke then
                        RandomZakjes = xCoke
                    end

                    CokePrice = RandomZakjes * CalcCokePrice
                    TriggerServerEvent('macerz:SellCoke', RandomZakjes, CokePrice)
                    notify("You sold ~g~"..RandomZakjes.."x ~s~ coke, receiving ~g~$"..CokePrice)
                else
                    notify("~r~You dont have enough weed to sell.")
                    IsSellingCoke = false
                end
            end)
            Citizen.Wait(5000)
            IsWaitingCoke = false

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
