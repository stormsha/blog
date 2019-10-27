import markdown
import emoji
import re
from django.db import models
from django.conf import settings
from storm.models import Article
from user.models import Ouser


# 游民评论者信息表
class CommentUser(models.Model):
    nickname = models.CharField(max_length=20, verbose_name='昵称')
    email = models.CharField(max_length=30, verbose_name='邮箱')
    address = models.CharField(max_length=200, verbose_name='地址')


def emo(content):
    smile_list = re.findall(r'(:[a-z_!]+?:)', content)
    comment_content = content
    for i in smile_list:
        name = i.replace(':', '', 2)
        try:
            smile_img = '<img src="/static/comment/img/' + 'icon_' + settings.SMILES[name] + '.gif">'
            comment_content = comment_content.replace(i, smile_img)
        except KeyError:
            continue
    return comment_content


# 评论信息表
class Comment(models.Model):
    author = models.ForeignKey(Ouser, related_name='%(class)s_related', verbose_name='评论人', null=True, blank=True)
    create_date = models.DateTimeField('创建时间', auto_now_add=True)
    content = models.TextField('评论内容')
    is_read = models.BigIntegerField(default=False)
    parent = models.ForeignKey('self', verbose_name='父评论', related_name='%(class)s_child_comments', blank=True, null=True)
    rep_to = models.ForeignKey('self', verbose_name='回复', related_name='%(class)s_rep_comments', blank=True, null=True)

    class Meta:
        """这是一个元类，用来继承的"""
        abstract = True

    def __str__(self):
        return self.content[:20]

    def content_to_markdown(self):
        # 先转换成emoji然后转换成markdown,'escape':所有原始HTML将被转义并包含在文档中
        content = emo(self.content)
        to_md = markdown.markdown(content,
                                  extensions=[
                                      'markdown.extensions.extra',
                                      'markdown.extensions.codehilite',
                                  ])
        return to_md

    def mark_to_read(self):
        self.is_read = True
        self.save(update_fields=['is_read'])


# 文章评论区，据继承评论信息表
class ArticleComment(Comment):
    # 记录评论属于哪篇文章
    belong = models.ForeignKey(Article, related_name='article_comments', verbose_name='所属文章', null=True, blank=True)

    class Meta:
        verbose_name = '文章评论'
        verbose_name_plural = verbose_name
        ordering = ['create_date']


# 关于自己页面评论信息
class AboutComment(Comment):
    class Meta:
        verbose_name = '关于自己评论'
        verbose_name_plural = verbose_name
        ordering = ['create_date']


# 给我留言页面评论信息
class MessageComment(Comment):
    class Meta:
        verbose_name = '给我留言'
        verbose_name_plural = verbose_name
        ordering = ['create_date']

