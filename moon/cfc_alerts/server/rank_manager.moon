import insert from table

export class RankManager
    generateGroups: =>
        -- Generate ordered ulx groups
        flatten = (list, flattened) ->
            flattened or= {}

            for k, v in pairs list
                insert flattened, k
                return flatten v, flattened

            flattened

        ulxGroups = ULib.ucl.getInheritanceTree!
        @orderedGroups = [rank for rank in *ulxGroups]
        @groupLookup = table.Reverse @orderedGroups

    atLeast: (rank) =>
        minIndex = @groupLookup[rank]
        [@groupLookup[x] for x=minIndex, #@orderedGroups]

    atMost: (rank) =>
        maxIndex = @groupLookup[rank]
        [@groupLookup[x] for x=0, maxIndex]

    all: =>
        @orderedGroups

RankManager = RankManager!
hook.Add "InitPostEntity", "CFC_Alerter", RankManager\generateGroups
