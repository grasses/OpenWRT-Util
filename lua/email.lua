#!/usr/bin/lua
--[[
Copyright 2015 http://homeway.me

@author homeway
@version 15.04.29
@link http://homeway.me
@function lua email module

]]--

local smtp = require("socket.smtp")
local M ={}

M.user = {["from"]="", ["to"]="", ["password"]=""}
M.mail = {["subject"]="", ["body"]=""}
M.sys = {["server"]=""}

M.set = function(data)
	M.user = data.user
	M.mail = data.mail
	M.sys = data.sys	
end

M.send = function()
	rcpt = {
		M.user["to"]
	}
	mesgt = {
		headers = {
			from = M.user["from"],
			to = M.user["to"], --收件人
			cc = "", --抄送 
			subject = M.mail["subject"] --主题
		},
		body = M.mail["body"]
	}

	r, e = smtp.send{
		from = M.user["from"],
		rcpt = rcpt,
		source = smtp.message(mesgt),
		server = M.sys["server"],
		port = M.sys["port"],
		user = M.user["from"],
		password = M.user["password"],
	}
	if not r then
        print(e)
	else
        print("send ok!")
	end
end
return M