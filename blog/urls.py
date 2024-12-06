from django.conf.urls import include  # 导入 include 函数以包含其他 URL 模式
from django.contrib import admin  # 导入 admin 模块用于 Django 管理后台
from django.conf.urls.static import static  # 导入静态文件处理
from django.conf import settings  # 导入项目设置
from django.contrib.sitemaps.views import sitemap  # 导入用于处理站点地图的视图
from django.urls import path, re_path  # 导入 path 函数用于定义 URL 模式

from rest_framework.routers import DefaultRouter  # 导入 Django REST Framework 的默认路由器
from api import views as api_views  # 导入 API 视图
from storm.feeds import AllArticleRssFeed  # 导入 RSS 订阅
from storm.sitemaps import ArticleSitemap, TagSitemap, CategorySitemap  # 导入站点地图类

# 初始化 REST Framework 的路由器
router = DefaultRouter()

# 根据设置中的 API_FLAG 决定是否注册 API 路由
if settings.API_FLAG:
    router.register(r'users', api_views.UserListSet)  # 注册用户 API
    router.register(r'articles', api_views.ArticleListSet)  # 注册文章 API
    router.register(r'tags', api_views.TagListSet)  # 注册标签 API
    router.register(r'categorys', api_views.CategoryListSet)  # 注册分类 API

# 定义站点地图
sitemaps = {
    'articles': ArticleSitemap,  # 文章站点地图
    'tags': TagSitemap,  # 标签站点地图
    'categories': CategorySitemap  # 分类站点地图
}

# 定义 URL 模式
urlpatterns = [
    re_path('admin/', admin.site.urls),  # Django 管理后台 URL
    re_path('accounts/', include('user.urls', namespace='accounts')),  # 用户相关 URL，命名空间为 'accounts'
    re_path('', include('storm.urls', namespace='blog')),  # 主博客应用 URL，命名空间为 'blog'
    re_path('comment/', include('comment.urls', namespace='comment')),  # 评论系统 URL，命名空间为 'comment'
    re_path('sitemap.xml', sitemap, {'sitemaps': sitemaps}, name='django.contrib.sitemaps.views.sitemap'),  # 网站地图 URL
    re_path('feed/', AllArticleRssFeed(), name='rss'),  # RSS 订阅 URL
]

# 如果项目使用了 MEDIA_URL，添加静态文件的 URL 模式以支持媒体文件
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

# 如果启用了 API_FLAG，添加 API 路由
if settings.API_FLAG:
    urlpatterns.append(
        re_path('api/v1/', include((router.urls, 'api'), namespace='api')))  # REST Framework API URL，命名空间为 'api'
