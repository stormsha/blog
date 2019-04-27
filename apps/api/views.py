# -*- coding: utf-8 -*-
from user.models import Ouser
from storm.models import Article, Tag, Category
from .serializers import (UserSerializer, ArticleSerializer, TagSerializer, CategorySerializer)
from rest_framework import viewsets
from rest_framework.permissions import DjangoModelPermissionsOrAnonReadOnly


# RESEful API VIEWS
class UserListSet(viewsets.ModelViewSet):
    queryset = Ouser.objects.all()
    serializer_class = UserSerializer
    permission_classes = (DjangoModelPermissionsOrAnonReadOnly,)


class ArticleListSet(viewsets.ModelViewSet):
    queryset = Article.objects.all()
    serializer_class = ArticleSerializer
    permission_classes = (DjangoModelPermissionsOrAnonReadOnly,)

    def perform_create(self,serializer):
        serializer.save(author=self.request.user)


class TagListSet(viewsets.ModelViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer
    permission_classes = (DjangoModelPermissionsOrAnonReadOnly,)


class CategoryListSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = (DjangoModelPermissionsOrAnonReadOnly,)


