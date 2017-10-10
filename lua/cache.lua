-- basic local cache manipulation
-- ref: http://www.cnblogs.com/digdeep/p/4859575.html

function set_to_cache(key, val, exp)
	local ngx_cache = ngx.shared.ngx_cache
	local succ, err, forcible ngx_cache:set(key, val, exp)
	return succ
end

function get_from_cache(key)
	local ngx_cache = ngx.shared.ngx_cache
	local val = ngx_cache:get(key)
	if not val then
		val = 'dummy'
		set_to_cache(key, val, 10)
	end
	return val
end

local key = tostring(ngx.var.arg_key)
local val = get_from_cache(key)
ngx.say(val)
