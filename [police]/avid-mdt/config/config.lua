Config = {}

--// if you are using other / custom framework, set both framework to false and edit framework functions in server/framework.lua and client/framework.lua

Config.Language = 'de' --// Supported languages ['en' - English/US | 'fr' - French | 'pl' - Poland | 'de' - German | 'es' - Spain]

Config.UsingQFBanking = false --// If you are using QF-BANKING enable this to get addon bank history

Config.Society = { --// Society name, percents configs to receive after sending to jail or giving a fines
    name = "society_police",
    percentToPoliceJob = 0.80,
    percentToPoliceMan = 0.20,
}

Config.SocietyScripts = { --// Society scripts are you use, if you use another then make it all false, and go to EDITABLE files
    esx_society = true,
    qb_management = false,
}

Config.Phones = {
    hype_phone = false,
    qs_smartphone = false,
    lb_phone = false,
}

Config.MaxDistanceToJailFine = 150 --// Maximum distance for send player to jail or give fine

Config.OneFile = false --// If you want Citizen List / Car list in One or Seperate categories in MDT

Config.Jobs = {
    OnDuty = {
        ['police'] = true, --// Job name to access to MDT
        ['fib'] = true, --// Job name to access to MDT

    },
    KickDuty = {
        name = 'unemployed', --// Job name to set after kick from duty
        Grade = {
            grade = 0, --// Grade number to set after kick from duty if you are using option "set_grade = true"
            set_grade = true, --// Set new grade to player
            same_grade = false, --// Set same grade to player what have
        }
    },
    AccessCode = {
        command = 'code',
        fromGrade = 23
    },
    AccessToManagementFunctions = {
        fromGrade = 23
    }
}

Config.MessageColors = { --// Colors in RGB for /code command 
    BlackCode = {20, 20, 20},
    RedCode = {255, 0, 0},
    OrangeCode = {255, 123, 0},
    GreenCode = {120, 255, 120},
}

Config.ToggleMDT = {
    key = 'DELETE', --// Command default bind key
    commandName = 'mdt', --// Command name
    keymappingLabel = 'Open tablet [LSPD]' --// Command Label in Keymapping
}

Config.Frameworks = {
    ESX = {
        enabled = true, --// if you are using esx, set it to true
        frameworkScript = 'es_extended',
        frameworkExport = 'getSharedObject'
    },
    QB = {
        enabled = false, --// if you are using qb-core, set it to true
        frameworkScript = 'qb-core',
        frameworkExport = 'GetCoreObject'
    }
}

Config.Properties = {
    qb_apartments = false, --// if you are using qb-apartments, set it to true
    esx_property_old = false, --// if you are using esx_property [not newest using SQL], set it to true
    esx_property_legacy = true, --// if you are using esx_property [newest using JSON], set it to true
    qs_housing = false, --// if you are using qs_housing, set it to true
}

Config.BlockSettings = {
    blockSettings = false,
    blockSettingsGrade = 0,
}

Config.Dispatch = {
    qf_dispatch = true,
    cd_dispatch = false,
    notif_dispatch = false, -- // TriggerClientEvent('avid-mdt:addDispatchAlert', -1, coords, 'title', 'subtitle', 'code f.e. 10-90', 'rgb(255, 0, 255)', '10 - max number of people that can response if you dont want it, set it to 0')
}

Config.NotifDispatchAlerts = true -- // If you have turn on notif_dispatch (if you don't it wouldnt work), and you add alert to mdt, player would be notifited abt it on top right corner