Config = {}

Config.EnableVersionCheck = true
Config.VersionCheckInterval = 60

--POLICE NOTIFY
Config.EnablePoliceNotify = true -- When Player is Processing Drugs (configured with linden_outlawalert)
Config.PoliceNotifyBlipSpirit = 161
Config.PoliceNotifyBlipScale = 1.0
Config.PoliceNotifyBlipColor = 1
Config.MinAmountToWash = 1000

--MONEYWASH
Config.NeedIDCardToWashMoney = false
Config.EnableTax = true 
Config.TaxRate = 10 --In percents %

-- BLIP --

Config.EnableMoneyWashBlip = true
Config.WashMoneyBlipName = "Laundry"

--Coordinates for Money Wash
Config.MoneyWash = {
    Loc = {
        WashMoney = {
            vector3(1137.46, -991.97, 46.11)
        }
    }
}
