-- this file defines a table '_M' which has a function 'is_number()'


local _M = {}

function _M.is_number(...)  -- variable args
    local args = {...}

    local sum
    for i,v in ipairs(args) do
         num = tonumber(v)
         if nil == num then
            return false
         end
    end
    return true
end

return _M
