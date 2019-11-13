export CFCAlertLib

-- Generate ordered ulx groups
flatten = (list, flattened) ->
    flattened = flattened or {}
    for k, v in pairs list
        table.insert flattened, k
        flatten v, flattened

    return flattened

gScoreboard.OrderedGroups = {}
ulxGroups = ULib.ucl.getInheritanceTree!

for _, group in pairs flatten(ulxGroups)
    table.insert gScoreboard.OrderedGroups, group

-- AlertingLibrary
class CFCAlertLib

    AlertRanks: (message, rank, op="=")

    AlertStaff: (message) =>
        for key, player in pairs player.GetAll!
            player\ChatPrint message
