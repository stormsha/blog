from __future__ import unicode_literals
import hashlib
import time
import logging
# django
from django.http import HttpResponse
from rest_framework.views import APIView, Response
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
        logger.info('llll')
        print(request)
        data = request.data
        logger.info(data)
        return HttpResponse("1")


