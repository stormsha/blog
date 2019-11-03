# ---------------------------
__author__ = 'stormsha'
__date__ = '2019/3/15 20:31'
# ---------------------------

# 创建了新的tags标签文件后必须重启服务器

from django import template
from ..models import Attachment


# 注册自定义标签函数
register = template.Library()


@register.simple_tag
def get_attachments():
    attachments = Attachment.objects.all().order_by('-created_on')
    return attachments

