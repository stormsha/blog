from __future__ import unicode_literals
import hashlib
import random
import time
import logging
# django
from django.core.cache import cache
from django.http import HttpResponse
from rest_framework.views import APIView, Response
from xml.etree import ElementTree as ET
from utils.chat import TextMsg
from api.permissions import check_action_permission
from storm.models import Article
from api.serializers import ArticleSerializer
logger = logging.getLogger(__name__)


class WeChatView(APIView):

    def get(self, request):
        signature = request.GET.get("signature")  # 先获取加密签名
        timestamp = request.GET.get("timestamp")  # 获取时间戳
        nonce = request.GET.get("nonce")  # 获取随机数
        echostr = request.GET.get("echostr")  # 获取随机字符串
        logger.info("signature:" + signature)
        logger.info("timestamp:" + timestamp)
        logger.info("nonce:" + nonce)
        logger.info("echostr:" + echostr)
        token = "stormsha"  # 自己设置的token
        # 使用字典序排序（按照字母或数字的大小顺序进行排序）
        _list = [token, timestamp, nonce]
        logger.debug(_list)
        _list.sort()

        # 进行sha1加密
        temp = ''.join(_list)
        sect = hashlib.sha1(temp.encode('utf-8'))
        hashcode = sect.hexdigest()
        logger.info("hashcode:" + hashcode)
        # 将加密后的字符串和signatrue对比，如果相同返回echostr,表示验证成功
        if hashcode == signature:
            logger.info("验证成功")
            return HttpResponse(echostr)
        else:
            return HttpResponse("error")

    def post(self, request):
        content = self.auto_reply(request)
        return HttpResponse(content, content_type="text/xml")

    @staticmethod
    def auto_reply(request):
        try:
            data = request.body
            xml_data = ET.fromstring(data)
            logger.info(xml_data)
            msg_type = xml_data.find('MsgType').text
            to_user_name = xml_data.find('ToUserName').text
            from_user_name = xml_data.find('FromUserName').text
            create_time = xml_data.find('CreateTime').text
            msg_id = xml_data.find('MsgId').text
            r_content = xml_data.find('Content').text
            logger.info("数据：%s", [msg_type, to_user_name, from_user_name, create_time, msg_id, r_content])
            if msg_type == 'text':
                if r_content == "注册":
                    content = random.randint(1000, 2000)
                    cache.set(str(content), str(content), 60*10)
                    res = TextMsg(to_user_name, from_user_name, content)
                    return res.send()
            elif msg_type == 'image':
                content = "图片已收到,谢谢"
                res = TextMsg(to_user_name, from_user_name, content)
                return res.send()
            elif msg_type == 'voice':
                content = "语音已收到,谢谢"
                res = TextMsg(to_user_name, from_user_name, content)
                return res.send()
            elif msg_type == 'video':
                content = "视频已收到,谢谢"
                res = TextMsg(to_user_name, from_user_name, content)
                return res.send()
            elif msg_type == 'shortvideo':
                content = "小视频已收到,谢谢"
                res = TextMsg(to_user_name, from_user_name, content)
                return res.send()
            elif msg_type == 'location':
                content = "位置已收到,谢谢"
                res = TextMsg(to_user_name, from_user_name, content)
                return res.send()
            else:
                content = "链接已收到,谢谢"
                res = TextMsg(to_user_name, from_user_name, content)
                return res.send()
        except Exception as msg:
            return repr(msg)

