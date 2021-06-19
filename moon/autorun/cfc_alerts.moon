if SERVER
    include "cfc_alerts/server/rank_manager.lua"
    include "cfc_alerts/server/alerter.lua"
    AddCSLuaFile "cfc_alerts/client/alert_displayer.lua"

if CLIENT
    include "cfc_alerts/client/alert_displayer.lua"
