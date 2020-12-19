RankManager = include "alerter/rank_manager.lua"

export class CFCAlerter
    new: (addon_name) =>
        @addon_name = addon_name
        @ranks = RankManager!

    format_message: (message) =>
        "[#{@addon_name}] #{message}}"

    alert_players: (message, plys) =>
        for ply in *plys
            ply\ChatPrint @format_message message

    alert_ranks: (message, ranks) =>
        rank_lookup = {v, true for v in *ranks}

        is_correct_rank = (ply) -> rank_lookup[ply\Team!] ~= nil

        plys = [ply for ply in *player.GetAll! when is_correct_rank ply]

        @alert_players message, plys

    alert_staff: (message) =>
        ranks = @ranks\at_least "sentinel"
        @alert_ranks message, ranks

    alert_admins: (message) =>
        ranks = @ranks\at_least "admin"
        @alert_ranks message, ranks

    alert_rank: (message, rank) =>
        @alert_ranks message, {rank}

    alert_all: (message) =>
        @alert_ranks message, @ranks\all!
