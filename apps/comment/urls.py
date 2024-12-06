# -*- coding: utf-8 -*-
from django.urls import path, re_path

from .views import AddcommentView

app_name = 'comment'

urlpatterns = [
    re_path(r'^add/$', AddcommentView, name='add_comment'),
]
