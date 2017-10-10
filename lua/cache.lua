-- basic local cache manipulation
-- ref: http://www.cnblogs.com/digdeep/p/4859575.html

function set_to_cache(key, val, exp)
	local ngx_cache = ngx.shared.user_cache   -- this cache is defined in nginx.conf
	local succ, err, forcible ngx_cache:set(key, val, exp)
	return succ
end

function get_from_cache(key)
	local ngx_cache = ngx.shared.user_cache
	local val = ngx_cache:get(key)
	if not val then
		val = 'dummy'
		set_to_cache(key, val, 10)
	end
	return val
end

local id = tostring(ngx.var.arg_id)
local val = get_from_cache(id)
ngx.say(val)
