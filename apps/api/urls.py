# -*- coding: utf-8 -*-
from django.conf.urls import url
from api import article, chat

urlpatterns = [
    url(r'^articles/(?P<pk>[0-9]+)/$', article.ArticleView.as_view()),
    url(r'^articles/$', article.ArticleView.as_view()),
    url(r'^chat/$', chat.WeChatView.as_view()),
    url(r'^token/$', chat.TokenView.as_view())
]

