_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Evidence Unit", "Police Evidence System")
_menuPool:Add(mainMenu)

-- location of a police station
local policeStationCoords = {
    vector3(451.67, -980.11, 30.69),
    vector3(1846.79, 3692.92, 34.26),
    -- Add more vector3 entries for additional locations
}
local markerSize = 0.75
local maxDistance = 5.0 -- Maximum distance at which 3D text will be visible
local isMenuOpen = false 
local isInMarkerArea = false
local evidenceSubMenu

 -- storage
local weapons = {
    { name = "weapon_knife", label = "Knife" },
    { name = "weapon_knuckle", label = "Knuckle Dusters" },
    { name = "weapon_nightstick", label = "Nightstick" },
    { name = "weapon_hammer", label = "Hammer" },
    { name = "weapon_bat", label = "Baseball Bat" },
    { name = "weapon_golfclub", label = "Golf Club" },
    { name = "weapon_crowbar", label = "Crowbar" },
    { name = "weapon_bottle", label = "Bottle" },
    { name = "weapon_dagger", label = "Antique Cavalry Dagger" },
    { name = "weapon_hatchet", label = "Hatchet" },
    { name = "weapon_machete", label = "Machete" },
    { name = "weapon_flashlight", label = "Flashlight" },
    { name = "weapon_switchblade", label = "Switchblade" },
    { name = "weapon_proxmine", label = "Proximity Mines" },
    { name = "weapon_bzgas", label = "BZ Gas" },
    { name = "weapon_smokegrenade", label = "Tear Gas" },
    { name = "weapon_molotov", label = "Molotov Cocktails" },
    { name = "weapon_fireextinguisher", label = "Fire Extinguisher" },
    { name = "weapon_petrolcan", label = "Jerry Can" },
    { name = "weapon_hazardcan", label = "Hazardous Jerry Can" },
    { name = "weapon_snowball", label = "Snowballs" },
    { name = "weapon_flare", label = "Flare" },
    { name = "weapon_ball", label = "Ball" },
    { name = "weapon_revolver", label = "Heavy Revolver" },
    { name = "weapon_poolcue", label = "Pool Cue" },
    { name = "weapon_pipewrench", label = "Pipe Wrench" },
    { name = "weapon_pistol", label = "Pistol" },
    { name = "weapon_pistol_mk2", label = "Pistol Mk II" },
    { name = "weapon_combatpistol", label = "Combat Pistol" },
    { name = "weapon_appistol", label = "AP Pistol" },
    { name = "weapon_pistol50", label = "Pistol .50" },
    { name = "weapon_snspistol", label = "SNS Pistol" },
    { name = "weapon_heavypistol", label = "Heavy Pistol" },
    { name = "weapon_vintagepistol", label = "Vintage Pistol" },
    { name = "weapon_stungun", label = "Stun Gun" },
    { name = "weapon_flaregun", label = "Flare Gun" },
    { name = "weapon_marksmanpistol", label = "Marksman Pistol" },
    { name = "weapon_microsmg", label = "Micro SMG" },
    { name = "weapon_minismg", label = "Mini SMG" },
    { name = "weapon_smg", label = "SMG" },
    { name = "weapon_smg_mk2", label = "SMG Mk II" },
    { name = "weapon_assaultsmg", label = "Assault SMG" },
    { name = "weapon_mg", label = "MG" },
    { name = "weapon_combatmg", label = "Combat MG" },
    { name = "weapon_combatmg_mk2", label = "Combat MG Mk II" },
    { name = "weapon_combatpdw", label = "Combat PDW" },
    { name = "weapon_gusenberg", label = "Gusenberg Sweeper" },
    { name = "weapon_machinepistol", label = "Machine Pistol" },
    { name = "weapon_assaultrifle", label = "Assault Rifle" },
    { name = "weapon_assaultrifle_mk2", label = "Assault Rifle Mk II" },
    { name = "weapon_carbinerifle", label = "Carbine Rifle" },
    { name = "weapon_carbinerifle_mk2", label = "Carbine Rifle Mk II" },
    { name = "weapon_advancedrifle", label = "Advanced Rifle" },
    { name = "weapon_specialcarbine", label = "Special Carbine" },
    { name = "weapon_bullpuprifle", label = "Bullpup Rifle" },
    { name = "weapon_compactrifle", label = "Compact Rifle" },
    { name = "weapon_pumpshotgun", label = "Pump Shotgun" },
    { name = "weapon_sweepershotgun", label = "Sweeper Shotgun" },
    { name = "weapon_sawnoffshotgun", label = "Sawed-Off Shotgun" },
    { name = "weapon_bullpupshotgun", label = "Bullpup Shotgun" },
    { name = "weapon_assaultshotgun", label = "Assault Shotgun" },
    { name = "weapon_musket", label = "Musket" },
    { name = "weapon_heavyshotgun", label = "Heavy Shotgun" },
    { name = "weapon_dbshotgun", label = "Double-Barrel Shotgun" },
    { name = "weapon_sniperrifle", label = "Sniper Rifle" },
    { name = "weapon_heavysniper", label = "Heavy Sniper" },
    { name = "weapon_heavysniper_mk2", label = "Heavy Sniper Mk II" },
    { name = "weapon_marksmanrifle", label = "Marksman Rifle" },
    { name = "weapon_grenadelauncher", label = "Grenade Launcher" },
    { name = "weapon_grenadelauncher_smoke", label = "Grenade Launcher Smoke" },
    { name = "weapon_rpg", label = "RPG" },
    { name = "weapon_minigun", label = "Minigun" },
    { name = "weapon_firework", label = "Firework Launcher" },
    { name = "weapon_railgun", label = "Railgun" },
    { name = "weapon_hominglauncher", label = "Homing Launcher" },
    { name = "weapon_grenade", label = "Grenade" },
    { name = "weapon_stickybomb", label = "Sticky Bomb" },
    { name = "weapon_compactlauncher", label = "Compact Grenade Launcher" },
    { name = "weapon_snspistol_mk2", label = "SNS Pistol Mk II" },
    { name = "weapon_revolver_mk2", label = "Heavy Revolver Mk II" },
    { name = "weapon_doubleaction", label = "Double-Action Revolver" },
    { name = "weapon_specialcarbine_mk2", label = "Special Carbine Mk II" },
    { name = "weapon_bullpuprifle_mk2", label = "Bullpup Rifle Mk II" },
    { name = "weapon_pumpshotgun_mk2", label = "Pump Shotgun Mk II" },
    { name = "weapon_marksmanrifle_mk2", label = "Marksman Rifle Mk II" },
    { name = "weapon_raypistol", label = "Up-n-Atomizer" },
    { name = "weapon_raycarbine", label = "Unholy Hellbringer" },
    { name = "weapon_rayminigun", label = "Widowmaker" },
    { name = "weapon_digiscanner", label = "The Up-n-Atomizer Scanner" },
    { name = "weapon_navyrevolver", label = "Navy Revolver" },
    { name = "weapon_ceramicpistol", label = "Ceramic Pistol" },
    { name = "weapon_stone_hatchet", label = "Stone Hatchet" },
    { name = "weapon_pipebomb", label = "Pipe Bomb" },
    { name = "gadget_parachute", label = "Parachute" },
    { name = "weapon_gadgetpistol", label = "Homing Launcher" },
    { name = "weapon_militaryrifle", label = "Military Rifle" },
    { name = "weapon_combatshotgun", label = "Combat Shotgun" },
    { name = "weapon_autoshotgun", label = "Auto Shotgun" },
}


-- Function to check if the player has a specific weapon
function HasPedGotWeapon(ped, weaponHash)
    return Citizen.InvokeNative(0x8DECB02F88F428BC, ped, weaponHash, false)
end

local playerWeapons = {}
-- Function to populate the playerWeapons table with the initial weapons in the player's inventory
function InitializePlayerWeapons()
    playerWeapons = {}
    for _, weapon in ipairs(weapons) do
        local weaponHash = GetHashKey(weapon.name)
        if HasPedGotWeapon(PlayerPedId(), weaponHash) then
            table.insert(playerWeapons, weapon)
        end
    end
end

InitializePlayerWeapons()

function GetAvailableWeapons()
    local ped = PlayerPedId()
    local weaponsList = {}

    for _, weapon in ipairs(playerWeapons) do
        local weaponHash = GetHashKey(weapon.name)
        if HasPedGotWeapon(ped, weaponHash) then
            table.insert(weaponsList, weapon)
        end
    end

    return weaponsList
end

-- Function to draw a blue marker and attach 3D text at the police station
function DrawPoliceStationMarker(coords)
    local playerCoords = GetEntityCoords(PlayerPedId(), false)
    local distance = #(coords - playerCoords)

    if distance <= maxDistance then
        DrawMarker(1,
            coords.x, coords.y, coords.z - 1.0,
            0, 0, 0, 0, 0, 0,
            markerSize, markerSize, 1.0,
            0, 0, 255, 150,
            false, true, 2, nil, nil, false
        )

        local textCoords = vector3(coords.x, coords.y, coords.z + 1.0)
        DrawText3D(textCoords, "Press ~g~E~w~ to open Evidence Storage")
    end
end

function UpdateEvidenceStorageMenu(submenu)
    -- Clear the submenu before adding new options
    submenu:Clear()

    local availableWeapons = GetAvailableWeapons()

    for _, weapon in ipairs(availableWeapons) do
        local weaponOption = NativeUI.CreateItem(weapon.label, "") -- Use the weapon label for display
        submenu:AddItem(weaponOption)

        weaponOption.Activated = function(ParentMenu, SelectedItem)
            -- Remove the selected weapon from the player's inventory
            local ped = PlayerPedId()
            local weaponHash = GetHashKey(weapon.name)
            if HasPedGotWeapon(ped, weaponHash) then
                RemoveWeaponFromPed(ped, weaponHash)
                notify("Weapon removed from your inventory.")
                -- Refresh the submenu to reflect the updated inventory
                UpdateEvidenceStorageMenu(submenu)
            else
                notify("You don't have this weapon in your inventory.")
            end
        end
    end
end

function EvidenceStorageMenu(submenu)
    -- Update the menu without recursion
    UpdateEvidenceStorageMenu(submenu)
end

local evidenceSubMenu = _menuPool:AddSubMenu(mainMenu, "Evidence Storage", "Select weapons to secure")
EvidenceStorageMenu(evidenceSubMenu)

local isMenuOpen = false

function OpenMainMenu()
    mainMenu:Visible(true)
    _menuPool:RefreshIndex()
    isMenuOpen = true -- Set isMenuOpen to true when opening the menu
end

function CloseMainMenu()
    mainMenu:Visible(false)
    isMenuOpen = false -- Set isMenuOpen to false when closing the menu
end

function OpenEvidenceStorageMenu()
    if not isMenuOpen then
        _menuPool:CloseAllMenus()
        CloseMainMenu() -- Close the main menu before opening the submenu
        evidenceSubMenu:Visible(true)

        -- Refresh the list of available weapons in the evidence storage menu
        InitializePlayerWeapons()
        UpdateEvidenceStorageMenu(evidenceSubMenu)
    end
end

_menuPool:MouseControlsEnabled(false)
_menuPool:ControlDisablingEnabled(false)

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function DrawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0125, 0.02 + factor, 0.03, 41, 11, 41, 150)
    end
end

function IsMenuOpen()
    return mainMenu:Visible()
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- 1000 milliseconds = 1 second
        InitializePlayerWeapons()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()

        local playerCoords = GetEntityCoords(PlayerPedId(), false)
        local isInAnyMarkerArea = false

        for _, coords in ipairs(policeStationCoords) do
            local distance = #(coords - playerCoords)

            if distance <= maxDistance then
                isInAnyMarkerArea = true
                DrawPoliceStationMarker(coords)

                if IsControlJustReleased(0, 38) and not IsMenuOpen() then
                    OpenEvidenceStorageMenu()
                end
            end
        end

        if not isInAnyMarkerArea then
            isInMarkerArea = false
        end
    end
end)
