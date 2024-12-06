# ---------------------------
__author__ = 'stormsha'
__date__ = '2019/3/10 21:03'

from django.urls import re_path

# ---------------------------


from .views import (IndexView, DetailView, MessageView, AboutView, DonateView, ExchangeView, ProjectView, QuestionView,
                    MySearchView, LoveView, LinkView)

app_name = 'blog'

urlpatterns = [
    # 首页
    re_path(r'^$', IndexView.as_view(template_name='index.html'), name='index'),  # 主页，自然排序
    re_path(r'^link/$', LinkView, name='link'),  # 申请友情链接
    re_path(r'^category/message/$', MessageView, name='message'),
    re_path(r'^category/about/$', AboutView, name='about'),
    re_path(r'^category/donate/$', DonateView, name='donate'),
    re_path(r'^category/exchange/$', ExchangeView, name='exchange'),
    re_path(r'^category/project/$', ProjectView, name='project'),
    re_path(r'^category/question/$', QuestionView, name='question'),
    # 分类页面
    re_path(r'^category/(?P<bigslug>.*?)/(?P<slug>.*?)', IndexView.as_view(template_name='content.html'), name='category'),
    # 归档页面
    re_path(r'^date/(?P<year>\d+)/(?P<month>\d+)/$', IndexView.as_view(template_name='archive.html'), name='date'),
    # 标签页面
    re_path(r'^tag/(?P<tag>.*?)/$', IndexView.as_view(template_name='content.html'), name='tag'),
    # 文章详情页面
    re_path(r'^article/(?P<slug>.*?)/$', DetailView.as_view(), name='article'),
    # 全文搜索
    re_path(r'^search/$', MySearchView.as_view(), name='search'),
    # 喜欢
    re_path(r'^love/$', LoveView, name='love')
]
