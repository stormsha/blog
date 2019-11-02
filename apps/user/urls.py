from django.conf.urls import url
from .views import logout_view, change_profile_view, login, register, ActiveUserView

urlpatterns = [
    url(r'^login/$', login, name='login'),
    url(r'^logout', logout_view, name='logout'),
    url(r'^register/$', register, name='register'),
    url(r'^active/(?P<code>.*)/$', ActiveUserView.as_view(), name='active'),
    # url(r'^profile/$', profile, name='profile'),
    url(r'^profile/change/$', change_profile_view, name='change_profile'),
]