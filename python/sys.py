#!/usr/bin/python
'''

@author homeway
@version 15.04.29
@link http://homeway.me
@function python get OpenWRT system info

'''


import os
# Return CPU temperature as a character string                                     
def getCPUtemperature():
    res = os.popen('vcgencmd measure_temp').readline()
    return(res.replace("temp=","").replace("'C\n",""))

# Return RAM information (unit=kb) in a list                                      
# Index 0: total RAM                                                              
# Index 1: used RAM                                                                
# Index 2: free RAM                                                                
def getRAMinfo():
    p = os.popen('free')
    i = 0
    while 1:
        i = i + 1
        line = p.readline()
        if i==2:
            return(line.split()[1:4])

# Return % of CPU used by user as a character string                               
def getCPUuse():
    return(str(os.popen("top -n1 | awk '/Cpu\(s\):/ {print $2}'").readline().strip()))

# Return information about disk space as a list (unit included)                    
# Index 0: total disk space                                                        
# Index 1: used disk space                                                        
# Index 2: remaining disk space                                                    
# Index 3: percentage of disk used                                                 
def getDiskSpace():
    p = os.popen("df -h /")
    i = 0
    while 1:
        i = i +1
        line = p.readline()
        if i==2:
            return(line.split()[1:5])

def getSystem():
    p = os.popen("uname -amnrspv")
    while 1:
        line = p.readline()
        return(line)

def getExtranetIp():
    p = os.popen('wget "http://www.ip138.com/ips1388.asp" -q -O - | sed -nr \'s/.*\[(([0-9]+\.){3}[0-9]+)\].*/\1/p\'')
    while 1:
        line = p.readline()
        print line
        return(line)

def getIntranetIp():
    p = os.popen('ifconfig apcli0 | grep inet\ addr')
    while 1:
        line = p.readline()
        return(line)

def getSsid():
    p = os.popen('uci get wireless.@wifi-iface[0].ApCliSsid')
    while 1:
        line = p.readline()
        return(line)

# CPU informatiom
CPU_temp = getCPUtemperature()
CPU_usage = getCPUuse()

# RAM information
# Output is in kb, here I convert it in Mb for readability
RAM_stats = getRAMinfo()
RAM_total = round(int(RAM_stats[0]) / 1000,1)
RAM_used = round(int(RAM_stats[1]) / 1000,1)
RAM_free = round(int(RAM_stats[2]) / 1000,1)

# Disk information
DISK_stats = getDiskSpace()
DISK_total = DISK_stats[0]
DISK_used = DISK_stats[1]
DISK_perc = DISK_stats[3]

# system info
SYSTEM_info = getSystem()

# NET infomation
NET_extranet_ip = getExtranetIp()
NET_internet_ip = getIntranetIp().lstrip('')
NET_connect_ssid = getSsid()

if __name__ == '__main__':
    print('-------------------------------------------')
    print("System info ="+str(SYSTEM_info))
    print('-------------------------------------------')
    print('RAM Total = '+str(RAM_total)+' MB')
    print('RAM Used = '+str(RAM_used)+' MB')
    print('RAM Free = '+str(RAM_free)+' MB')
    print('-------------------------------------------')
    print('DISK Total Space = '+str(DISK_total)+'B')
    print('DISK Used Space = '+str(DISK_used)+'B')
    print('DISK Used Percentage = '+str(DISK_perc))
    print('-------------------------------------------')
    print('NET Extranet Ip ='+str(NET_extranet_ip))
    print('NET Connect Ssid ='+str(NET_connect_ssid))
    print('NET Internet Wan Ip ='+str(NET_internet_ip))
    
