-- Compiled with roblox-ts v2.0.4-dev-74842e0
local Signal
do
	Signal = setmetatable({}, {
		__tostring = function()
			return "Signal"
		end,
	})
	Signal.__index = Signal
	function Signal.new(...)
		local self = setmetatable({}, Signal)
		return self:constructor(...) or self
	end
	function Signal:constructor()
		self._callbacks = {}
	end
	function Signal:Connect(handler)
		local __callbacks = self._callbacks
		local _handler = handler
		__callbacks[_handler] = true
		return handler
	end
	function Signal:Fire(...)
		local args = { ... }
		local __callbacks = self._callbacks
		local _arg0 = function(callback)
			return task.spawn(callback, unpack(args))
		end
		for _v in __callbacks do
			_arg0(_v, _v, __callbacks)
		end
	end
	function Signal:Once(handler)
		local f
		f = self:Connect(function(...)
			local args = { ... }
			self:Unbind(f)
			handler(unpack(args))
		end)
		return f
	end
	function Signal:Unbind(callback)
		local __callbacks = self._callbacks
		local _callback = callback
		if __callbacks[_callback] ~= nil then
			local __callbacks_1 = self._callbacks
			local _callback_1 = callback
			__callbacks_1[_callback_1] = nil
		end
	end
	function Signal:Wait()
		local running = coroutine.running()
		self:Once(function(...)
			local args = { ... }
			task.spawn(running, unpack(args))
		end)
		return coroutine.yield()
	end
	function Signal:UnbindAll()
		table.clear(self._callbacks)
	end
	function Signal:Destroy()
		table.clear(self)
	end
end
return Signal
