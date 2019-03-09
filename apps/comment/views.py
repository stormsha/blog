from django.shortcuts import render
from storm.models import Article
from .models import ArticleComment,CommentUser,AboutComment,MessageComment
from django.conf import settings
from django.http import JsonResponse,HttpResponse
from django.views.decorators.http import require_POST
from django.contrib.auth.decorators import login_required
from datetime import datetime
from django.shortcuts import get_object_or_404
from django.views.decorators.csrf import csrf_exempt
import json,re


user_model = settings.AUTH_USER_MODEL


def confirm(new_content,comment_post_ID,auser):
    if comment_post_ID == 'about':
        re = AboutComment.objects.filter(content=new_content, author=auser)
    elif comment_post_ID == 'message':
        re = MessageComment.objects.filter(content=new_content,author=auser)
    else:
        re = ArticleComment.objects.filter(content=new_content, author=auser,belong_id=comment_post_ID)
    if re:
        return False
    else:
        return True


# @login_required
@csrf_exempt
@require_POST
def AddcommentView(request):
    if request.is_ajax():
        data = request.POST
        new_content = data.get('w')
        comment_post_ID=data.get('comment_post_ID')
        author = data.get('author', '')
        email = data.get('email', '')
        url = data.get('url', '')
        CommentUser.objects.get_or_create(nickname=author, email=email, address=url)
        comment_parent = data.get('comment_parent')
        auser = CommentUser.objects.get(nickname=author, email=email, address=url)
        if not re.match('^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$',email):
            return HttpResponse('请输入有效的邮箱格式！', content_type='text/html;charset="utf-8"', status=405)
        if not confirm(new_content,comment_post_ID,auser):
            return HttpResponse('请勿发表重复内容！', content_type='text/html;charset="utf-8"', status=405)
        # rep_id = data.get('rep_id')
        if not new_content:
            return HttpResponse('请写点什么吧！', content_type='text/html;charset="utf-8"', status=405)
        if not author or not email:
            data={'error':'请填写邮箱和昵称'}
            return HttpResponse('请填写邮箱和昵称',content_type='text/html;charset="utf-8"',status=405)
        if comment_post_ID=='about' :
            # the_article = Article.objects.get(id=comment_post_ID)

            if comment_parent=='0':
                new_comment = AboutComment(author=auser, content=new_content, parent=None,rep_to=None)
            else:
                # new_rep_to = ArticleComment.objects.get(id=rep_id)
                # new_parent = new_rep_to.parent if new_rep_to.parent else new_rep_to
                parent = AboutComment.objects.get(id=comment_parent)
                new_comment = AboutComment(author=auser, content=new_content, parent=parent,rep_to=None)
            new_comment.save()
        elif comment_post_ID=='message' :
            # the_article = Article.objects.get(id=comment_post_ID)
            if comment_parent=='0':
                new_comment = MessageComment(MessageComment,auser,new_content)
            else:
                # new_rep_to = ArticleComment.objects.get(id=rep_id)
                # new_parent = new_rep_to.parent if new_rep_to.parent else new_rep_to
                parent=MessageComment.objects.get(id=comment_parent)
                new_comment = MessageComment(author=auser, content=new_content, parent=parent,
                                             rep_to=None)
            new_comment.save()
        else:
            the_article = Article.objects.get(id=comment_post_ID)
            if comment_parent=='0':
                new_comment = ArticleComment(author=auser, content=new_content, belong=the_article, parent=None,
                                             rep_to=None)
            else:
                # new_rep_to = ArticleComment.objects.get(id=rep_id)
                # new_parent = new_rep_to.parent if new_rep_to.parent else new_rep_to
                parent = ArticleComment.objects.get(id=comment_parent)
                new_comment = ArticleComment(author=auser, content=new_content, belong=the_article, parent=parent,
                                             rep_to=None)
            new_comment.save()
        request.session['nick'] = new_comment.author.nickname
        request.session['tid'] = new_comment.author.id
        return  HttpResponse('''<li class="" id="comment-"><div class="c-avatar"><img alt='' src='https://cuiqingcai.com/avatar/.png' class='avatar avatar-54 photo avatar-default' height='54' width='54' /><div class="c-main" id="div-comment-">{0}<div class="c-meta"><span class="c-author">{1}</span></div></div></div>'''.format(new_content,author),content_type='text/html;charset="utf-8"')

    return  HttpResponse('参数错误',content_type='text/html;charset="utf-8"')
