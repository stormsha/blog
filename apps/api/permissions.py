# -*- coding: utf-8 -*-
from rest_framework import permissions
from user.models import Ouser
from django.contrib.auth.models import Permission


class IsAdminUserOrReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        if request.method in permissions.SAFE_METHODS:
            return True
        return request.user and request.user.is_staff


def check_action_permission(user, model='', action=''):
    """
    判断User对Model是否有action权限
    # action可选值:add,change,view,delete
    # action可选值:add,change,public,delete
    """
    if not user:
        return False
    condition = {
        'codename': action + '_' + model
    }
    user_list = list(user.get_leader()) + [user.id]
    user_list = [Ouser.objects.get(id=user_id) for user_id in user_list]
    model_permission = Permission.objects.filter(roles__group__user__in=user_list, **condition)
    if model_permission:
        return True
    return False

