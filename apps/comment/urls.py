# -*- coding: utf-8 -*-
from django.conf.urls import url
from .views import AddcommentView, CommentView

urlpatterns = [
    url(r'^add/$', CommentView, name='add_comment'),
]
