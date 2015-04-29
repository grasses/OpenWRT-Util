#!/usr/bin/lua
--[[
Copyright 2015 http://homeway.me

@author homeway
@version 15.04.29
@link http://homeway.me
@function OpenWRT gpio module

]]--
 
local M = {}

M.id = ""
M.path = "/sys/class/gpio/gpio"
M.router = "/sys/class/gpio"

M.check = function(where)
	print("check path => "..where)
	local f=io.open(where, "r")
  	if f~=nil then io.close(f) return true else return false end
end

-- set mode && check type
M.mode = function(id, mtype)
	M.id = id
	where = M.path..M.id
	-- if id not use
	if false==M.check(M.path..id..'/direction') then
    	--M.writeFile(M.router.."/unexport",id)
		M.writeFile(M.router.."/export", id)
  	end
  	-- if type different 
  	if mtype ~= M.readFile(M.path..id..'/direction') then
  		print("type =>"..mtype.." direction=>"..M.readFile(M.path..id..'/direction').." different")
  		M.writeFile(M.path..id..'/direction', mtype)
  	end
end

-- file write
M.writeFile = function(where, what)
	print("write path => "..where.." data =>"..what)
	local fp=io.open(where, 'w')
  	fp:write(what)
  	fp:close()	
end

-- file read
M.readFile = function(where)
	print("read path => "..where)
  	local fp=io.open(where, 'r')
  	if fp~=nil then
    	data = fp:read("*all")
    	fp:close()
    	return data
  	end
  	return nil
end

M.set = function(id)
	M.id = id
end

M.read = function()
  	res = M.readFile(M.path..M.id..'/value')
  	return res
end

M.write = function(value)
  	res = M.writeFile(M.path..M.id..'/value', value)
end

M.close = function()
	print("sleep io => "..M.id)
	os.execute("sleep " .. tonumber(M.id))
end

return M