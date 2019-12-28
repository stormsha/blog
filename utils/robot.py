import logging
import re
from werobot import WeRoBot
from blog.settings import APP_ID, APP_SECRET, APP_TOKEN
logger = logging.getLogger(__name__)
robot = WeRoBot(enable_session=False,
                token=APP_TOKEN,
                APP_ID=APP_ID,
                APP_SECRET=APP_SECRET)


# 被关注
@robot.subscribe
def subscribe(message):
    return "欢迎关注我呀"


# 文本消息返回原文
@robot.text
def echo(message):
    return message.content