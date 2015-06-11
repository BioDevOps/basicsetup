#!/usr/bin/env python
from bioblend import galaxy
import time
import sys

gi = galaxy.GalaxyInstance(url='http://127.0.0.1:8080', key='changeit')

username='workflowuser'
email = 'test@example.com'
password = 'galaxy'

retrycount=0

while retrycount <= 6:
    try:
        galaxy.users.UserClient(gi).create_local_user(username,email,password)
        break
    except:
        retrycount=retrycount+1
        if retrycount <= 6:
            time.sleep(30)
        else:
            sys.exit()


ul= galaxy.users.UserClient(gi).get_users()
uid=''
key=''
for user in ul:
    if email == user['email']:
        uid = user['id']
        key = galaxy.users.UserClient(gi).create_user_apikey(uid)

print key
