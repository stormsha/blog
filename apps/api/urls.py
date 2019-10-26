# -*- coding: utf-8 -*-
from django.conf.urls import url
from api.article import ArticleView

urlpatterns = [
    url(r'^articles/(?P<pk>[0-9]+)/$', ArticleView.as_view()),
    url(r'^articles/$', ArticleView.as_view())
]

