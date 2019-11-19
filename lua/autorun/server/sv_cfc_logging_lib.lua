local RankManager
do
  local _class_0
  local _base_0 = {
    at_least = function(self, rank)
      local min_index = self.group_lookup[rank]
      local _accum_0 = { }
      local _len_0 = 1
      for x = min_index, #self.ordered_groups do
        _accum_0[_len_0] = x
        _len_0 = _len_0 + 1
      end
      return _accum_0
    end,
    at_most = function(self, rank)
      local max_index = self.group_lookup[rank]
      local _accum_0 = { }
      local _len_0 = 1
      for x = 0, max_index do
        _accum_0[_len_0] = self.group_lookup[x]
        _len_0 = _len_0 + 1
      end
      return _accum_0
    end,
    all = function(self)
      return self.ordered_groups
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      local flatten
      flatten = function(list, flattened)
        flattened = flattened or { }
        for k, v in pairs(list) do
          table.insert(flattened, k)
          flatten(v, flattened)
        end
        return flattened
      end
      local ulx_groups = ULib.ucl.getInheritanceTree()
      do
        local _accum_0 = { }
        local _len_0 = 1
        for _, rank in ulx_groups do
          _accum_0[_len_0] = rank
          _len_0 = _len_0 + 1
        end
        self.ordered_groups = _accum_0
      end
      self.group_lookup = table.Reverse(self.ordered_groups)
    end,
    __base = _base_0,
    __name = "RankManager"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  RankManager = _class_0
end
do
  local _class_0
  local _base_0 = {
    get_message = function(self, message)
      return "[" .. tostring(self.addon_name) .. "] " .. tostring(message) .. "}"
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
      for _, ply in pairs(player.GetAll()) do
        local rank = ply:Team()
        if rank_lookup[rank] then
          ply:ChatPrint(self:get_message(message))
        end
      end
    end,
    alert_staff = function(self, message)
      local ranks = self.ranks:at_least("moderator")
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
    __name = "CFCAlertLib"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  CFCAlertLib = _class_0
  return _class_0
end
