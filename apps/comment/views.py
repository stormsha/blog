from storm.models import Article
from .models import ArticleComment, CommentUser, AboutComment, MessageComment
from user.models import Ouser
from django.conf import settings
from django.http import HttpResponse
from django.views.decorators.http import require_POST
from django.views.decorators.csrf import csrf_exempt
from django.db.models import Q
import re

from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from datetime import datetime


# 获取用户模型
user_model = settings.AUTH_USER_MODEL


# 确定重复是否重复
def confirm(new_content, comment_post_ID, auser):
    if comment_post_ID == 'about':
        res = AboutComment.objects.filter(content=new_content, author=auser)
    elif comment_post_ID == 'message':
        res = MessageComment.objects.filter(content=new_content, author=auser)
    else:
        res = ArticleComment.objects.filter(content=new_content, author=auser, belong_id=comment_post_ID)
    if res:
        return False
    else:
        return True


# @login_required
@csrf_exempt
@require_POST
def AddcommentView(request):
    if request.is_ajax():
        data = request.POST
        # 评论内容哦你
        new_content = data.get('w')
        # 评论对象，指的是页面留言、文章、等
        comment_post_ID = data.get('comment_post_ID')
        # 评论者
        author = data.get('author', '')
        # 评论者邮箱
        email = data.get('email', '')
        # 评论者网址
        url = data.get('url', '')
        # 评论对象，父级对象，就是评论的是谁
        comment_parent = data.get('comment_parent', '')
        """
        验证信息格式
        """
        if not re.match('^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$', email):
            return HttpResponse('请输入有效的邮箱格式！', content_type='text/html;charset="utf-8"', status=405)

        if not new_content:
            return HttpResponse('请写点什么吧！', content_type='text/html;charset="utf-8"', status=405)
        if not author or not email:
            return HttpResponse('请填写邮箱和昵称', content_type='text/html;charset="utf-8"', status=405)

        # 存储评论者信息
        CommentUser.objects.get_or_create(nickname=author, email=email, address=url)

        # 获取用户信息
        auser = CommentUser.objects.get(nickname=author, email=email, address=url)

        if not confirm(new_content, comment_post_ID, auser):
            return HttpResponse('请勿发表重复内容！', content_type='text/html;charset="utf-8"', status=405)

        """
        存储评论信息
        """
        # 关于自己页面评论
        if comment_post_ID == 'about':
            # 父级评论
            if comment_parent == '0':
                new_comment = AboutComment(author=auser, content=new_content, parent=None, rep_to=None)
            # 评论他人评论
            else:
                parent = AboutComment.objects.get(id=comment_parent)
                new_comment = AboutComment(author=auser, content=new_content, parent=parent, rep_to=None)
            new_comment.save()
        # 给我留言页面评论
        elif comment_post_ID == 'message':
            if comment_parent == '0':
                new_comment = MessageComment(author=auser, content=new_content, parent=None, rep_to=None)
            else:
                parent = MessageComment.objects.get(id=comment_parent)
                new_comment = MessageComment(author=auser, content=new_content, parent=parent, rep_to=None)
            new_comment.save()
        # 文章评论
        else:
            the_article = Article.objects.get(id=comment_post_ID)
            if comment_parent == '0':
                new_comment = ArticleComment(author=auser, content=new_content, belong=the_article, parent=None, rep_to=None)
            else:
                parent = ArticleComment.objects.get(id=comment_parent)
                new_comment = ArticleComment(author=auser, content=new_content, belong=the_article, parent=parent, rep_to=None)
            new_comment.save()

        # 获取用什么，分登陆身份和游民身份
        request.session['nick'] = new_comment.author.nickname
        request.session['tid'] = new_comment.author.id

        # 返回当前评论，直接返回HTML内容刚给前端，使用JS在指定位置进行数据展示
        # 处理表情
        smile_list = re.findall(r'(:[a-z_!]+?:)', new_content)
        comment_content = new_content
        for i in smile_list:
            name = i.replace(':', '', 2)
            try:
                smile_img = '<img src="/static/comment/img/' + 'icon_' + settings.SMILES[name] + '.gif">'
                comment_content = comment_content.replace(i, smile_img)
            except KeyError:
                continue
        users = Ouser.objects.filter(username=auser.nickname)
        if users:
            user = users.first()
            img = user.avatar
        else:
            img = ""

        return HttpResponse('''<li class="" id="comment-">
        <div class="c-avatar">
        <img alt='用户头像' src='/media/{2}' class='avatar avatar-54 photo avatar-default' height='54' width='54' style="border-radius: 50%;" />
        <div class="c-main" id="div-comment-">{0}
        <div class="c-meta">
        <span class="c-author">{1}</span></div></div></div>'''.format(comment_content, author, img), content_type='text/html;charset="utf-8"')

    return HttpResponse('参数错误', content_type='text/html;charset="utf-8"')


@login_required
def note_view(request):
    if request.method == "GET":
        fun = request.GET.get('fun', '')
        username = request.session['username']
        uid = request.session['uid']
        email = Ouser.objects.get(id=uid).email
        user = Ouser.objects.get(username=username, id=uid)
        if fun == "me-comment":
            my_comment = ArticleComment.objects.filter(author__nickname=username, author__email=email).order_by('-create_date')
            return render(request, 'comment/block/my_comment.html', {"my_comment": my_comment, "fun": fun})
        if fun == "me-article":
            author = Ouser.objects.get(username=username, id=uid)
            my_article = Article.objects.filter(author=author)
            comments = ArticleComment.objects.filter(belong__author=author).order_by()
            return render(request, 'comment/block/my_article.html', {"my_article": my_article, "comments": comments, "fun": fun})
        if fun == "notice":
            return render(request, 'comment/block/notice.html', {"fun": fun})
        if fun == "to_webmaster":
            return render(request, 'comment/block/to_webmaster.html', {"fun": fun})
        if fun == "read":
            comment_user = CommentUser.objects.get(nickname=username, email=email)
            ArticleComment.objects.filter(Q(belong__author=user, parent=None) | Q(parent__author=comment_user) | Q(author=comment_user)).update(is_read=True)
            return JsonResponse({"msg": "全部标记已读"})
        if fun == "unread":
            return render(request, 'comment/block/unread.html', {"fun": fun})
        if fun == "one-unread":
            number = request.GET.get("id")
            get_object_or_404(ArticleComment, id=number).mark_to_read()
        if not fun:
            return render(request, 'comment/note.html', context={'fun': ""})

