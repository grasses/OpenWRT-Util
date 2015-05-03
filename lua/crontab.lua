#!/usr/bin/lua

--[[
Copyright 2015 http://homeway.me

@author homeway
@version 15.04.29
@link http://homeway.me
@function: crontab schedule, send email to you about system information

how to use:
step1: configure you email information in this script
step2: mkdir /root/log && mkdir /root/script
step3: mv /path/to/crontab.lua /root/script/send
step4: chmod +x /root/script/send
step5: echo "0,10,20,30,40,50 * * * * /root/script/send" > /root/script/schedule
step6: crontab /root/script/schedule

must install uci、luasocket(http://see.sl088.com/wiki/Luasocket)、python

]]--


local smtp = require("socket.smtp")
local M ={}

M.user = {["from"]="", ["to"]="", ["password"]=""}
M.mail = {["subject"]="", ["body"]=""}
M.sys = {["server"]=""}
M.data = ""
M.sysPath = "/root/log/sys.log"

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
		user = M.user["from"],
		password = M.user["password"],
	}
	if not r then
        print(e)
	else
        print("send ok!")
	end
end

M.readFile = function(where)
	local fp=io.open(where, 'r')
  	if fp~=nil then
    	data = fp:read("*all")
    	fp:close()
    	return data
  	end
  	return nil
end

os.execute("/root/script/sysinfo.py > "..M.sysPath)
M.msg = M.readFile(M.sysPath)

local data = {}
data.user = {["from"]="", ["to"]="", ["password"]=""}
data.mail = {["subject"]="系统当前信息", ["body"]=M.data}
data.sys = {["server"]="smtp.qq.com"}

M.set(data)
M.send()