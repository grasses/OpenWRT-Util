#!/usr/bin/python

'''
@author homeway
@version 15.04.29
@link http://homeway.me
@function python send email
'''

import smtplib
smtpObj = smtplib.SMTP("mstp.qq.com", 25)

sender = 'sender@gmail.com'
receivers = ['receivers@gmail.com']

message = """From: From Person <homeway@jue.so>
To: To Person <receivers@gmail.com>
Subject: SMTP e-mail test

This is a test e-mail message.
"""

try:
	smtpObj.sendmail(sender, receivers, message)         
	print "Successfully sent email"
except SMTPException:
	print "Error: unable to send email"