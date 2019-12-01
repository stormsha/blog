from django.conf import settings
from django.views.decorators.http import require_POST
from django.shortcuts import render
from django.shortcuts import get_object_or_404
from django.core.paginator import Paginator
from django.db.models import Q
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from storm.models import Article, Activate
from .models import ArticleComment
from utils.send_email import common_send_email

# 获取用户模型
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
        fun = request.GET.get('fun', None)
        user = request.user
        current_page_num = int(request.GET.get('page', 1))  # 通过a标签的GET方式请求，默认显示第一页
        if fun == "comment":
            comments = ArticleComment.objects.filter(author=user).order_by('-create_date')
            paginator = Paginator(comments, 5)
            page = paginator.page(current_page_num)
            if len(page) == 0:
                page = ""
                paginator = ""
            return render(request, 'comment/block/comment.html', context={'fun': fun, "page": page, 'paginator': paginator})
        if fun == "note":
            comments = ArticleComment.objects.filter(Q(author=user) | Q(belong__author=user) | Q(rep_to__author=user)).order_by('-create_date')
            paginator = Paginator(comments, 5)
            page = paginator.page(current_page_num)
            if len(page) == 0:
                page = ""
                paginator = ""
            return render(request, 'comment/block/note.html', context={'fun': fun, "page": page, 'paginator': paginator})
        if fun == "article":
            articles = Article.objects.filter(author=user).order_by('-create_date')
            paginator = Paginator(articles, 5)
            page = paginator.page(current_page_num)
            if len(page) == 0:
                page = ""
                paginator = ""
            return render(request, 'comment/block/article.html', context={'fun': fun, "page": page, 'paginator': paginator})
        if fun == "notice":
            notices = Activate.objects.filter(is_active=True)
            return render(request, 'comment/block/notice.html', {"fun": fun, 'notices': notices})
        if fun == "to_webmaster":
            return render(request, 'comment/block/to_webmaster.html', {"fun": fun})
        if fun == "webmaster":
            content = request.GET.get('content', None)
            try:
                common_send_email(email=user.email, username=user.username, s_type='4', content=content)
                msg = "邮件已经发出"
            except Exception as e:
                msg = repr(e)
            data = {
                'fun': 'webmaster',
                "msg": msg
            }
            return render(request, 'comment/block/to_webmaster.html', data)
        if fun == "read":
            ArticleComment.objects.filter(Q(belong__author=user) |
                                          Q(parent__author=user) | Q(author=user)).update(is_read=True)
            return JsonResponse({"msg": "全部标记已读"})
        if fun == "unread":
            comments = ArticleComment.objects.filter(Q(author=user) | Q(belong__author=user), is_read=False).order_by('-create_date')
            paginator = Paginator(comments, 5)
            page = paginator.page(current_page_num)
            if len(page) == 0:
                page = ""
                paginator = ""
            return render(request, 'comment/block/note.html', context={'fun': fun, "page": page, 'paginator': paginator})
        if fun == "one-unread":
            number = request.GET.get("id")
            get_object_or_404(ArticleComment, id=number).mark_to_read()
        if fun == "profile":
            return render(request, 'comment/block/profile.html', context={'fun': fun})
        if not fun:
            comments = ArticleComment.objects.filter(Q(author=user) | Q(belong__author=user)).order_by('-create_date')
            paginator = Paginator(comments, 5)
            page = paginator.page(current_page_num)
            return render(request, 'comment/note.html', context={'fun': "", "page": page, 'paginator': paginator})




