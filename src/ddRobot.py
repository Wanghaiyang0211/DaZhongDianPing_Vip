# -*- coding: UTF-8 -*-

import urllib.request
import json

class ddRobot():

    def __init__(self):
        self.url = "https://oapi.dingtalk.com/robot/send?access_token=cec3f18a736f4d6395548efe109dfbecdd1fec505c25c8eb7577cfe1c07b58b6"

    def request(self, url, method, data=None, head={}):
        request = urllib.request.Request(url=url, headers=head)
        request.get_method = lambda: method
        httpRes = urllib.request.urlopen(request, data)
        content = httpRes.read()
        httpRes.close()
        return content

    def postStart(self, infoContent):
        data = {}
        data['msgtype'] = 'markdown'
        data['markdown'] = {}
        data['markdown']['title'] = '大众点评'
        data['markdown']['text'] = infoContent
        data = json.dumps(data).encode("utf-8")
        head = {"Content-Type": "application/json"}
        content = self.request(self.url, "POST", data, head)
        return content
