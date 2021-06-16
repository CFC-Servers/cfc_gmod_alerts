RankManager = include "alerter/rank_manager.lua"

export class CFCAlerter
    new: (addon_name) =>
        @addon_name = addon_name
        @ranks = RankManager!

    formatMessage: (message) =>
        "[#{@addon_name}] #{message}}"

    alertPlayers: (plys, message) =>
        for ply in *plys
            ply\ChatPrint @formatMessage message

    alertRanks: (ranks, message) =>
        rank_lookup = {v, true for v in *ranks}

        is_correct_rank = (ply) -> rank_lookup[ply\Team!] ~= nil
        plys = [ply for ply in *player.GetAll! when is_correct_rank ply]

        @alertPlayers plys, message

    alertStaff: (message) =>
        ranks = @ranks\at_least "moderator"
        @alertRanks ranks, message

    alertAdmins: (message) =>
        ranks = @ranks\at_least "admin"
        @alertRanks ranks, message

    alertRank: (message, rank) =>
        @alertRanks {rank}, message

    alertAll: (message) =>
        @alertRanks @ranks\all!, message
