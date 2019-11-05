from django.contrib import admin
from .models import Comment, ArticleComment

admin.site.register(Comment)
admin.site.register(ArticleComment)

