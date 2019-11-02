# -*- coding: utf-8 -*-
from django.conf.urls import url
from .views import CommentView, note_view

urlpatterns = [
    url(r'^add/$', CommentView, name='add_comment'),
    url(r'^note/$', note_view, name='note'),
]
