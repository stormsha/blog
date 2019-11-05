import json
from django.contrib import auth
from .models import Ouser
from django.contrib.auth import authenticate
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.views.generic import View
from django.contrib.auth.hashers import make_password
# 第四个是 auth中用户权限有关的类。auth可以设置每个用户的权限。
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render, redirect, HttpResponse
from django.views.decorators.http import require_POST
from django.http import JsonResponse
from .forms import UserForm, loginForm, ProfileForm
from utils.send_email import common_send_email
from user.models import VerifyRecord


# 登出
def logout_view(req):
    # 清理cookie里保存username
    next_to = req.GET.get('next', '/')
    if next_to == '':
        next_to = '/'
    auth.logout(req)
    return redirect(next_to)


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
                common_send_email(email=email, s_type="1", username=username)
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


