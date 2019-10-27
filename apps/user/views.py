from django.contrib import auth
from .models import Ouser
from django.contrib.auth import authenticate
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.views.generic import View
from django.utils.decorators import method_decorator
from django.contrib.auth.hashers import make_password, check_password
# 第四个是 auth中用户权限有关的类。auth可以设置每个用户的权限。
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render, redirect, HttpResponseRedirect, reverse, HttpResponse
from django.views.decorators.http import require_POST
from django.http import JsonResponse
from .forms import UserForm, loginForm, ProfileForm
from utils.send_email import send_register_email
from user.models import VerifyRecord
import re
import json


# 注册
@csrf_exempt
def register_view(request):
    context = {}
    if request.method == 'POST':
        form = UserForm(request.POST)
        next_to = request.POST.get('next', 0)
        if form.is_valid():
            # 获得表单数据
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            password2 = form.cleaned_data['password2']
            email = form.cleaned_data['email']
            context = {'username': username, 'pwd': password, 'email': email}
            if password.isdigit():
                context['pwd_error'] = 'nums'
                return render(request, 'account/signup.html', context)
            if password != password2:
                context['pwd_error'] = 'unequal'
                return render(request, 'account/signup.html', context)

            # 判断用户是否存在
            user = Ouser.objects.filter(username=username)
            Email = Ouser.objects.filter(email=email)
            pwd_length = len(password)
            if pwd_length < 8 or pwd_length > 20:
                context['pwd_error'] = 'length'
                return render(request, 'account/signup.html', context)

            user_length = len(username)

            if user_length < 5 or user_length > 20:
                context['user_error'] = 'length'
                return render(request, 'account/signup.html', context)
            if user:
                context['user_error'] = 'exit'
                return render(request, 'account/signup.html', context)
            if not re.match('^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$', email):
                context['email_error'] = 'format'
                return render(request, 'account/signup.html', context)
            if Email:
                context['email_error'] = 'exit'
                return render(request, 'account/signup.html', context)
            # 添加到数据库（还可以加一些字段的处理）
            user = Ouser.objects.create_user(username=username, password=password, email=email)
            user.save()
            user = auth.authenticate(username=username, password=password)

            # 添加到session
            request.session['username'] = username
            request.session['uid'] = user.id
            request.session['nick'] = ''

            # 调用auth登录
            auth.login(request, user)
            # 重定向到首页
            if next_to == '':
                next_to = '/'
            return redirect(next_to)
    else:
        next_to = request.GET.get('next', '/')
        context = {'isLogin': False}
        context['next_to'] = next_to
    # 将req 、页面 、以及context{}（要传入html文件中的内容包含在字典里）返回
    return render(request, 'account/signup.html', context)


# 登陆
@csrf_exempt
@require_POST
def login_view(req):
    context = {}
    if req.method == 'POST' and req.is_ajax:
        form = loginForm(req.POST)
        next_to = req.POST.get('next', '/')
        remember = req.POST.get('remember', 0)
        if form.is_valid():
            # 获取表单用户密码
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            context = {'username': username, 'pwd': password}
            # 获取的表单数据与数据库进行比较
            user = authenticate(username=username, password=password)
            if next_to == '':
                next_to = '/'
            if user:
                if user.is_active:
                    # 比较成功，跳转index
                    auth.login(req, user)
                    req.session['username'] = username
                    req.session['uid'] = user.id
                    req.session['nick'] = None
                    req.session['tid'] = None
                    reqs = HttpResponseRedirect(next_to)
                    if remember != 0:
                        reqs.set_cookie('username', username)
                    else:
                        reqs.set_cookie('username', '', max_age=-1)
                    return reqs
                else:
                    context['inactive'] = True
                    return render(req, 'account/login.html', context)
            else:
                # 比较失败，还在login
                context['error'] = True
                return JsonResponse(context)
    else:
        # next_to = req.GET.get('next', '/')

        # context['next_to'] = next_to

        return render(req, 'index.html', context)


# 登出
def logout_view(req):
    # 清理cookie里保存username
    next_to = req.GET.get('next', '/')
    if next_to == '':
        next_to = '/'
    auth.logout(req)
    return redirect(next_to)


@login_required
def profile_view(request):
    return render(request, 'oauth/profile.html')


@login_required
@csrf_exempt
def change_profile_view(request):
    if request.method == 'POST':
        # 上传文件需要使用request.FILES
        form = ProfileForm(request.POST, request.FILES, instance=request.user)
        if form.is_valid():
            form.save()
            # 添加一条信息,表单验证成功就重定向到个人信息页面
            messages.add_message(request, messages.SUCCESS, '个人信息更新成功！')
            return redirect('accounts:profile')
    else:
        # 不是POST请求就返回空表单
        form = ProfileForm(instance=request.user)
    return render(request, 'oauth/change_profile.html', context={'form': form})


# 登陆
@csrf_exempt
@require_POST
def login(request):
    """处理POST请求业务逻辑"""
    context = {}
    form = loginForm(request.POST)
    fun = request.POST.get('fun', None)
    if fun == 'login':
        remember = request.POST.get('remember', 0)
        if form.is_valid():
            # 获取表单用户密码
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            context = {'username': username, 'pwd': password}
            # 获取的表单数据与数据库进行比较
            user = authenticate(username=username, password=password)
            if user:
                # 比较成功，跳转index
                auth.login(request, user)
                request.session['username'] = username
                request.session['uid'] = user.id
                response = JsonResponse({"ok": "1"})
                if remember != 0:
                    response.set_cookie('username', username)
                else:
                    response.set_cookie('username', '', max_age=-1)
                return response
            else:
                # 比较失败，还在login
                context['login_error'] = 'true'
                context['error'] = 'true'
                username = request.POST.get('username', None)
                pwd = request.POST.get('password', None)
                context['username'] = username
                context['pwd'] = pwd
                return render(request, 'oauth/user.html', context)
        else:
            context['login_error'] = 'true'
            context['error'] = 'true'
            return render(request, 'oauth/user.html', context)
    return HttpResponse('POST请求业务逻辑')


# 登陆
@csrf_exempt
@require_POST
def register(request):
    context = {}
    data = request.POST
    form = UserForm(data)
    error = False
    if form.is_valid():
        # 获得表单数据
        username = form.cleaned_data['username']
        password = form.cleaned_data['password']
        password2 = form.cleaned_data['password2']
        email = form.cleaned_data['email']
        # 判断用户是否存在
        user = Ouser.objects.filter(username=username)
        email_obj = Ouser.objects.filter(email=email)
        if user:
            context['n'] = '用户已经存在'
            error = True
        if email_obj:
            context['e'] = '邮箱已经被占用'
            error = True
        if not error:
            # 实例化用户，然后赋值
            user_profile = Ouser()
            user_profile.username = username
            user_profile.email = email
            # 新建用户为非活跃用户，可通过验证变为活跃用户
            user_profile.is_active = False
            # 将明文转换为密文赋给password
            user_profile.password = make_password(password)
            user_profile.save()  # 保存到数据库
            # 此处加入了邮箱验证的手段
            try:
                send_register_email(email, "1")
            except Exception as msg:
                print(repr(msg))
            # 添加到session
            request.session['username'] = username
            request.session['uid'] = user_profile.id
            # 调用auth登录
            auth.login(request, user_profile)
            context['active'] = False
        context['error'] = error
        return HttpResponse(json.dumps(context))
    else:
        context['register_error'] = '注册信息填写有误'
        context['error'] = True
        return HttpResponse(json.dumps(context))


@login_required
def profile1(request):
    return render(request, 'oauth/profile.html')


@login_required
def profile(request):
    if request.method == "GET":
        return render(request, 'oauth/profile.html', context={'fun': ""})
        # fun = request.GET.get('fun', '')
        # username = request.session['username']
        # uid = request.session['uid']
        # email = Ouser.objects.get(id=uid).email
        # user = Ouser.objects.get(username=username, id=uid)
        # from comment.models import ArticleComment
        # from storm.models import Article
        # from django.contrib.auth.decorators import login_required
        # from django.shortcuts import render
        # from django.shortcuts import get_object_or_404
        # from django.http import JsonResponse
        # from django.db.models import Q
        # if fun == "me-comment":
        #     my_comment = ArticleComment.objects.filter(author__nickname=username, author__email=email).order_by('-create_date')
        #     return render(request, 'comment/block/my_comment.html', {"my_comment": my_comment, "fun": fun})
        # if fun == "me-article":
        #     author = Ouser.objects.get(username=username, id=uid)
        #     my_article = Article.objects.filter(author=author)
        #     comments = ArticleComment.objects.filter(belong__author=author).order_by()
        #     return render(request, 'comment/block/my_article.html', {"my_article": my_article, "comments": comments, "fun": fun})
        # if fun == "notice":
        #     return render(request, 'comment/block/notice.html', {"fun": fun})
        # if fun == "to_webmaster":
        #     return render(request, 'comment/block/to_webmaster.html', {"fun": fun})
        # if fun == "read":
        #     ArticleComment.objects.filter(Q(belong__author=user, parent=None) |
        #                                   Q(parent__author=user) | Q(author=user)).update(is_read=True)
        #     return JsonResponse({"msg": "全部标记已读"})
        # if fun == "unread":
        #     return render(request, 'comment/block/unread.html', {"fun": fun})
        # if fun == "one-unread":
        #     number = request.GET.get("id")
        #     get_object_or_404(ArticleComment, id=number).mark_to_read()
        # if not fun:
        #     return render(request, 'comment/note.html', context={'fun': ""})


class ActiveUserView(View):
    def get(self, request, code):
        records = VerifyRecord.objects.filter(code=code, v_type='1')
        if records:
            record = records.first()
            email = record.key
            # 通过邮箱查找到对应的用户
            user = Ouser.objects.get(email=email)
            # 激活用户
            user.is_active = True
            user.save()
            # 添加到session
            request.session['username'] = user.username
            request.session['uid'] = user.id
            # 调用auth登录
            auth.login(request, user)
            return redirect('blog:index')
        return redirect('blog:index')

