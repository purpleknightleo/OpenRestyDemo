-- basic mysql manipulation with lua-resty-mysql library
-- ref: http://www.cnblogs.com/digdeep/p/4859575.html
--      http://wiki.jikexueyuan.com/project/openresty/lua/class.html

-- table struture: 
-- CREATE TABLE `user` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `name` varchar(20) NOT NULL,
--   `age` int(11) NOT NULL,
--   PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8

function close_db(db) 
	if not db then
		return
	end
	db:close()
end

local mysql = require('resty.mysql')
local db = mysql:new()
local table_name = 'user'

db:set_timeout(1000)

local ok,err,errno,sqlstate = db:connect{
	host = "127.0.0.1",
    port = 3306,
    user = 'sys',
    password = 'sys',
    database = 'openresty',
    max_packet_size = 1024 * 1024
}
if not ok then
	ngx.say('fail to connect to mysql, ', err)
	return
end

-- delete all
local res,err,errno,sqlstate = db:query('delete from '..table_name)
if not res then
	ngx.say('fail to delete, ', err, ": ", errno, " ", sqlstate)
	return 
end

-- insert one, take notice of single quotes on string type
res,err,errno,sqlstate = db:query(string.format("insert into %s values(null, '%s', %d)", table_name, 'kb', 38))
if not res then
	ngx.say('fail to insert, ', err, ": ", errno, " ", sqlstate)
	return 
end

-- select one
res,err,errno,sqlstate = db:query(string.format("select * from %s where name = '%s'", table_name, 'kb'))
if not res then
	ngx.say('fail to select, ', err, ": ", errno, " ", sqlstate)
	return 
end

-- close db
close_db()

-- parse resultset to json string
local cjson = require "cjson"
ngx.say("result: ", cjson.encode(res))
