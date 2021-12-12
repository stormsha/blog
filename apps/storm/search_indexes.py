# -*- coding: utf-8 -*-

from haystack import indexes
from .models import Article


class BlogArticleIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.CharField(document=True, use_template=True)
    id = indexes.IntegerField(model_attr='id')
    views = indexes.IntegerField(model_attr='views')

    def get_model(self):
        return Article

    def index_queryset(self, using=None):
        return self.get_model().objects.all().distinct()
