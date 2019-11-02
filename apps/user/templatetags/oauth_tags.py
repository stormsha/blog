# 创建了新的tags标签文件后必须重启服务器

from django import template
from ..models import Ouser
from comment.models import CommentUser

register = template.Library()


@register.simple_tag()
def get_user_data(uid):
    """返回用户的信息"""
    user = Ouser.objects.filter(id=uid)
    if user:
        return user[0]
    else:
        return ''


@register.simple_tag()
def get_tourist_data(uid):
    """返回评论者的信息"""
    user = CommentUser.objects.filter(id=uid)
    if user:
        return user[0]
    else:
        return ''


# @register.inclusion_tag('oauth/tags/user_avatar.html')
# def get_user_avatar_tag(user):
#     '''返回用户的头像，是一个img标签'''
#     return { 'user': user }


@register.simple_tag()
def get_user_avatar_tag(name, email):
    """返回用户的头像，是一个img标签"""
    re_user = Ouser.objects.filter(username=name, email=email)
    if re_user:
        re_user = re_user.first()
        if re_user.avatar:
            return {"me_avatar": re_user.avatar, "me_link": re_user.link}
        else:
            return {"me_avatar": 'avatar/default.png', "me_link": re_user.link}
    else:
        return None
