# -*- coding: utf-8 -*-
from django.conf.urls import url
from .views import AttachmentView

urlpatterns = [
    url(r'^attachments/$', AttachmentView, name='attachment')
]
