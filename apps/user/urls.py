from django.urls import path, re_path

from .views import login_view, logout_view, register_view, profile_view, change_profile_view

app_name = 'accounts'  # 设置应用的命名空间
urlpatterns = [
    re_path(r'^login/$', login_view, name='login'),
    re_path(r'^logout', logout_view, name='logout'),
    re_path(r'^register/$', register_view, name='register'),
    re_path(r'^profile/$', profile_view, name='profile'),
    re_path(r'^profile/change/$', change_profile_view, name='change_profile'),
]
