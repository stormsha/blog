# -*- coding: utf-8 -*-
from django.conf.urls import url
from .views import AddcommentView, note_view

urlpatterns = [
    url(r'^add/$', AddcommentView, name='add_comment'),
    url(r'^note/$', note_view, name='note'),
]
