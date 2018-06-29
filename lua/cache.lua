-- basic local cache manipulation
-- ref: http://www.cnblogs.com/digdeep/p/4859575.html

function get_from_cache(key)
	ngx.say('key = '..key)
        local ngx_cache = ngx.shared.user_cache
	local val = ngx_cache:get(key)
	if not val then
	    val = 'dummy'
	end
	return val
end

local id = tostring(ngx.var.arg_id)
local val = get_from_cache(id)
ngx.say('val = '..val)
