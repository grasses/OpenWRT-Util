# About

WRTnode开发中写的几个脚本，主要实现了openwrt下面GPIO控制、系统信息获取、wifi扫描器、定时发送邮件系统报警等功能。


---------------------------------------------


# How to use

### 0x01.GPIO.lua

* GPIO.mode(id, “out/in”)

* GPIO.write(value)

* GPIO.read()


先设置设置模式，GPIO.mode(id, “out/in”)两种模式之一

如果为’out’即可调用GPIO.write(value)函数，写入当然id端口，如果为’in’模式，只能调用GPIO.read()读取数值。

这里数值只能是0或1，非0即为1.

调用方式如下，这个存在一个可忽略的问题，一旦调用mode，数值将被置为默认数值，即0：


```
#!/usr/bin/lua
x=require("gpio")
print("Please input io id =>")
id = io.read("*num")
x.mode(id, "out")-- 设置io的模式为输入还是输出 [in/out]
function readGPIO(id)
	value = x.read()
	print("read data from => `"..id.."` =>"..value)
end
function writeGPIO(id, data)
	x.write(data)
	print("write data to => `"..id.."` =>"..data)
end

count=1
repeat
	count=count+1
	print("Please input value =>")
	data = io.read("*num")
	writeGPIO(id, data)
	readGPIO(id)
until count>3

```

### 0x02.Email.lua

填写账号信息，即可发送：

```
#!/usr/bin/lua
local mail = require("email")
local data = {}
data.user = {["from"]="sender@gmail.com", ["to"]="receiver@gmail.com", ["password"]="password"}
data.mail = {["subject"]="测试邮件模块", ["body"]="这是主体内容..."}
data.sys = {["server"]="smtp.gmail.com", ["port"]=587}

mail.set(data)
mail.send()

```

---------------------------------------------


# Version

15.04.30

* first version


---------------------------------------------


# License

GPL
=======
# OpenWRT-Util

写了几个脚本，主要实现了openwrt下面GPIO控制、系统信息获取、wifi扫描器、定时发送邮件系统报警等功能。

详细请看下面介绍，近期会更新：

[http://homeway.me/2015/04/29/openwrt-develop-base-util/](http://homeway.me/2015/04/29/openwrt-develop-base-util/)

