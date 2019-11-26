local RankManager = include("alerter/rank_manager.lua")
local CFCAlerter
do
  local _class_0
  local _base_0 = {
    format_message = function(self, message)
      return "[" .. tostring(self.addon_name) .. "] " .. tostring(message) .. "}"
    end,
    alert_players = function(self, message, plys)
      for _index_0 = 1, #plys do
        local ply = plys[_index_0]
        ply:ChatPrint(self:format_message(message))
      end
    end,
    alert_ranks = function(self, message, ranks)
      local rank_lookup
      do
        local _tbl_0 = { }
        for _, v in pairs(ranks) do
          _tbl_0[v] = true
        end
        rank_lookup = _tbl_0
      end
      local is_correct_rank
      is_correct_rank = function(ply)
        return rank_lookup[ply:Team()] ~= nil
      end
      local plys
      do
        local _accum_0 = { }
        local _len_0 = 1
        local _list_0 = player.GetAll()
        for _index_0 = 1, #_list_0 do
          local ply = _list_0[_index_0]
          if is_correct_rank(ply) then
            _accum_0[_len_0] = ply
            _len_0 = _len_0 + 1
          end
        end
        plys = _accum_0
      end
      return self:alert_players(message, plys)
    end,
    alert_staff = function(self, message)
      local ranks = self.ranks:at_least("sentinel")
      return self:alert_ranks(message, ranks)
    end,
    alert_admins = function(self, message)
      local ranks = self.ranks:at_least("admin")
      return self:alert_ranks(message, ranks)
    end,
    alert_rank = function(self, message, rank)
      return self:alert_ranks(message, {
        rank
      })
    end,
    alert_all = function(self, message)
      return self:alert_ranks(message, (function()
        local _base_1 = self.ranks
        local _fn_0 = _base_1.all
        return function(...)
          return _fn_0(_base_1, ...)
        end
      end)())
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, addon_name)
      self.addon_name = addon_name
      self.ranks = RankManager()
    end,
    __base = _base_0,
    __name = "CFCAlerter"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  CFCAlerter = _class_0
  return _class_0
end
