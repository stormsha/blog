# 创建了新的tags标签文件后必须重启服务器
from django import template
from django.db.models import Q
from ..models import ArticleComment, AboutComment, MessageComment


register = template.Library()


@register.simple_tag
def get_comment_count(category, entry=0):
    """获取一个文章的评论总数"""
    if category == 'about':
        lis = AboutComment.objects.all()
    elif category == 'message':
        lis = MessageComment.objects.all()
    else:
        lis = ArticleComment.objects.filter(belong_id=entry)
    return lis.count()


@register.simple_tag
def get_comment_user_count(article):
    """获取评论人总数"""
    p = []
    lis = article.article_comments.all()
    for each in lis:
        if each.author not in p:
            p.append(each.author)
    return len(p)


@register.simple_tag
def get_comment_count(article):
    """获取一个文章的评论总数"""
    lis = article.article_comments.all()
    return lis.count()


@register.simple_tag
def get_parent_comments(article):
    """获取一个文章的父评论列表"""
    lis = article.article_comments.filter(parent=None).order_by('-create_date')
    return lis


@register.simple_tag
def get_child_comments(com):
    """获取一个父评论的子平路列表"""
    lis = com.articlecomment_child_comments.all()
    return lis


@register.simple_tag
def get_unread_count(user, f=None):
    try:
        comments = ArticleComment.objects.filter(
            Q(belong__author=user, parent=None, is_read=False) | Q(parent__author=user, is_read=False)
            | Q(author=user, is_read=False))
        if comments:
            count = len(comments)
        else:
            count = ""
    except:
        count = ""
    return count


@register.simple_tag
def get_comment_user(user):
    return user


@register.simple_tag
def get_article_comment_count(article):
    count = ArticleComment.objects.filter(belong=article).count()
    return count



