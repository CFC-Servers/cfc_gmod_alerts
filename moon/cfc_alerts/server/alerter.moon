util.AddNetworkString "CFC_Alerts_Fancy"


class CFCBaseAlerter
    new: (addon_name) =>
        @addon_name = addon_name
        @ranks = RankManager

    _alertRanks: (ranks, ...) =>
        rankLookup = {v, true for v in *ranks}

        isCorrectRank = (ply) -> rankLookup[ply\Team!] ~= nil
        plys = [ply for ply in *player.GetAll! when isCorrectRank ply]

        @_alertPlayers plys, ...

    AlertAll: (...) =>
        @_alertRanks @ranks\all!, ...

    AlertRank: (rank, message) =>
        @_alertRanks {rank}, ...

    AlertStaff: (...) =>
        ranks = @ranks\atLeast "moderator"
        @_alertRanks ranks, ...


export class CFCBasicAlerter extends CFCBaseAlerter
    _formatMessage: (...) =>
        "[#{@addon_name}] #{...}}"

    _alertPlayers: (plys, ...) =>
        for ply in *plys
            ply\ChatPrint @_formatMessage ...


export class CFCFancyAlerter extends CFCBaseAlerter
    _alertPlayers: (plys, ...) =>
        net.Start "CFC_Alerts_Fancy"
        net.WriteTable {...}
        net.Send plys
