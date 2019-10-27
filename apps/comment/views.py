import re
from django.conf import settings
from django.http import HttpResponse
from django.views.decorators.http import require_POST
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render
from django.shortcuts import get_object_or_404
from storm.models import Article
from user.models import Ouser
from .models import ArticleComment, CommentUser, AboutComment, MessageComment

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

    print('ssssss')
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
        # 评论对象，父级对象，就是评论的是谁
        comment_parent = data.get('comment_parent')
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
                new_comment = MessageComment(MessageComment, auser, new_content)
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
        return HttpResponse('''<li class="" id="comment-"><div class="c-avatar"><img alt='' src='https://cuiqingcai.com/avatar/.png' class='avatar avatar-54 photo avatar-default' height='54' width='54' /><div class="c-main" id="div-comment-">{0}<div class="c-meta"><span class="c-author">{1}</span></div></div></div>'''.format(new_content, author), content_type='text/html;charset="utf-8"')

    return HttpResponse('参数错误', content_type='text/html;charset="utf-8"')


# from django.shortcuts import render
# from blog.models import Article
# from .models import ArticleComment, Notification
# from django.conf import settings
from django.http import JsonResponse
# from django.views.decorators.http import require_POST
from django.contrib.auth.decorators import login_required
# from datetime import datetime
# from django.shortcuts import get_object_or_404
# from . import handlers

user_model = settings.AUTH_USER_MODEL


@login_required
@require_POST
def CommentView(request):
    if request.is_ajax():
        data = request.POST
        new_user = request.user
        new_content = data.get('content', None)
        article_id = data.get('article_id', None)
        rep_to = data.get('rep_id', None)
        article = Article.objects.get(id=int(article_id))
        if "script" in new_content:
            new_content = new_content.replace("script", '')
        if not rep_to:
            new_comment = ArticleComment(author=new_user, content=new_content, belong=article, parent=None,
                                         rep_to=None)
        else:
            new_rep_to = ArticleComment.objects.get(id=rep_to)
            new_parent = new_rep_to.parent if new_rep_to.parent else new_rep_to
            new_comment = ArticleComment(author=new_user, content=new_content, belong=article, parent=new_parent,
                                         rep_to=new_rep_to)
        new_comment.save()
        new_point = '#com-' + str(new_comment.id)
        return JsonResponse({'msg': '评论提交成功！', 'new_point': new_point})
    return JsonResponse({'msg': '评论失败！'})


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


@login_required
def NotificationView(request, is_read=None):
    '''展示提示消息列表'''
    now_date = datetime.now()
    return render(request, 'comment/notification.html', context={'is_read': is_read, 'now_date': now_date})


@login_required
@require_POST
def mark_to_read(request):
    '''将一个消息标记为已读'''
    if request.is_ajax():
        data = request.POST
        user = request.user
        id = data.get('id')
        info = get_object_or_404(Notification, get_p=user, id=id)
        info.mark_to_read()
        return JsonResponse({'msg': 'mark success'})
    return JsonResponse({'msg': 'miss'})


@login_required
@require_POST
def mark_to_delete(request):
    '''将一个消息删除'''
    if request.is_ajax():
        data = request.POST
        user = request.user
        id = data.get('id')
        info = get_object_or_404(Notification, get_p=user, id=id)
        info.delete()
        return JsonResponse({'msg': 'delete success'})
    return JsonResponse({'msg': 'miss'})


