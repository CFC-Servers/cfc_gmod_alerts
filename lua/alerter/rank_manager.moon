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

        @ordered_groups = [rank for rank in *ulx_groups]
        @group_lookup = table.Reverse @ordered_groups

    at_least: (rank) =>
        min_index = @group_lookup[rank]

        [@group_lookup[x] for x=min_index, #@ordered_groups]

    at_most: (rank) =>
        max_index = @group_lookup[rank]

        [@group_lookup[x] for x=0, max_index]

    all: =>
        @ordered_groups
