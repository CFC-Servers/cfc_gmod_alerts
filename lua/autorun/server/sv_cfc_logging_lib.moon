class RankManager
    new: =>
        -- Generate ordered ulx groups
        flatten = (list, flattened) ->
            flattened or= {}

            for k, v in pairs list
                table.insert flattened, k
                return flatten v, flattened

            flattened

        ulx_groups = ULib.ucl.getInheritanceTree!

        @ordered_groups = [rank for _,rank in ulx_groups]
        @group_lookup = table.Reverse @ordered_groups

    at_least: (rank) =>
        min_index = @group_lookup[rank]

        [@group_lookup[x] for x=min_index, #@ordered_groups]

    at_most: (rank) =>
        max_index = @group_lookup[rank]

        [@group_lookup[x] for x=0, max_index]

    all: =>
        @ordered_groups

-- AlertingLibrary
export CFCAlertLib
class CFCAlertLib
    new: (addon_name) =>
        @addon_name = addon_name
        @ranks = RankManager!

    get_message: (message) =>
        "[#{@addon_name}] #{message}}"

    alert_ranks: (message, ranks) =>
        rank_lookup = {v,true for _,v in pairs ranks}

        for _, ply in pairs player.GetAll!
            rank = ply\Team!
            if rank_lookup[rank]
                ply\ChatPrint @get_message(message)

    alert_staff: (message) =>
        ranks = @ranks\at_least("moderator")
        @alert_ranks message, ranks

    alert_rank: (message, rank) =>
        @alert_ranks message, {rank}

    alert_all: (message) =>
        @alert_ranks message, @ranks\all
