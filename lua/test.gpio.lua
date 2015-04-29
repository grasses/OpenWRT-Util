#!/usr/bin/lua
--[[
Copyright 2015 http://homeway.me

@author homeway
@version 15.04.29
@link http://homeway.me
@function OpenWRT gpio module test

]]--

x=require("gpio")
print("Please input io id =>")
id = io.read("*num")
x.mode(id, "out")

function readGPIO(id)
	value = x.read()
	print("read data from => `"..id.."` =>"..value)
end

function writeGPIO(id, data)
	x.write(data)
	print("write data to => `"..id.."` =>"..data)
end

--readGPIO(id)

count=1
repeat
	count=count+1
	print("Please input value =>")
	data = io.read("*num")
	
	writeGPIO(id, data)
	readGPIO(id)
	--x.close(id)
until count>3