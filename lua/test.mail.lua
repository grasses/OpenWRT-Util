#!/usr/bin/lua

--[[
Copyright 2015 http://homeway.me

@author homeway
@version 15.04.29
@link http://homeway.me
@function email send test

]]--

local mail = require("email")

local data = {}
data.user = {["from"]="sender@gmail.com", ["to"]="receiver@gmail.com", ["password"]="password"}
data.mail = {["subject"]="测试邮件模块", ["body"]="这是主体内容..."}
data.sys = {["server"]="smtp.gmail.com", ["port"]=587}

mail.set(data)
mail.send()