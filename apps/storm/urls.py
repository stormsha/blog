# -*- coding: utf-8 -*-
# ---------------------------
__author__ = 'stormsha'
__date__ = '2019/2/20 23:27'
# ---------------------------

from django.conf.urls import url
from .views import (IndexView, MessageView, AboutView, DonateView, ExchangeView, ProjectView, QuestionView, DetailView, LinkView, LoveView,page_not_found)

urlpatterns = [

    url(r'^$', IndexView.as_view(template_name='index.html'), name='index'),  # 主页，自然排序
    url(r'^link/$', LinkView, name='link'),
    url(r'^category/message/$', MessageView, name='message'),
    url(r'^category/about/$', AboutView, name='about'),
    url(r'^category/donate/$', DonateView, name='donate'),
    url(r'^category/exchange/$', ExchangeView, name='exchange'),
    url(r'^category/project/$', ProjectView, name='project'),
    url(r'^category/question/$', QuestionView, name='question'),
    # url(r'^resources/$', ResourcesView, name='resources'),
    # url(r'^category/(?P<bigslug>.*?)/$', IndexView.as_view(template_name = 'resources.html'), name='bigcategory'),
    url(r'^category/(?P<bigslug>.*?)/(?P<slug>.*?)', IndexView.as_view(template_name='content.html'), name='category'),
    url(r'^article/(?P<slug>.*?)/$', DetailView.as_view(), name='article'),
    url(r'^date/(?P<year>\d+)/(?P<month>\d+)/$', IndexView.as_view(template_name='archive.html'), name='date'),
    url(r'^tag/(?P<tag>.*?)/$', IndexView.as_view(template_name='content.html'), name='tag'),
    url(r'^love/$', LoveView, name='love'),

]
handler404 = page_not_found
handler500 = page_not_found

