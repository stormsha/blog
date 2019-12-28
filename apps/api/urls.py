# -*- coding: utf-8 -*-
from django.conf.urls import url
from werobot.contrib.django import make_view
from utils.robot import robot
from api import article, chat

urlpatterns = [
    url(r'^articles/(?P<pk>[0-9]+)/$', article.ArticleView.as_view()),
    url(r'^articles/$', article.ArticleView.as_view()),
    url(r'^chat/$', chat.WeChatView.as_view()),
    url(r'^robot/$', make_view(robot))
]

