-- basic redis manipulation with lua-resty-redis library
-- ref: http://haoyun.blog.51cto.com/2038762/1136994

-- parse url parameters
cmd = tostring(ngx.var.arg_cmd)
key = tostring(ngx.var.arg_key)
val = tostring(ngx.var.arg_val)

local redis = require('resty.redis')
local red = redis:new()

red:set_timeout(1000)

local ok,err = red:connect('127.0.0.1',6379)
if not ok then
	ngx.say('fail to connect to redis, ', err)
	return
end

if cmd == 'get' then
	local res,err = red:get(key)
	if not res then
		ngx.say('fail to get, ', err)
		return 
	end
	if ngx.null == res then
		ngx.say('not found value for key ', key)
		return
	end
	ngx.say(res)
else
	local res,err = red:set(key, val)
	if not res then
		ngx.say('fail to set, ', err)
		return
	end
	ngx.say(res)
end
	