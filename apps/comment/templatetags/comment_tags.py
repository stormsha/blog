# 创建了新的tags标签文件后必须重启服务器
from django.utils.safestring import mark_safe
from django.db.models import Q
from django import template
from django.conf import settings
from ..models import ArticleComment, AboutComment, MessageComment, CommentUser
from user.models import Ouser

import re


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
def get_parent_comments(category, entry=0):
    """获取一个文章的父评论列表"""
    if category == 'about':
        lis = AboutComment.objects.filter(parent=None)
    elif category == 'message':
        lis = MessageComment.objects.filter(parent=None)
    else:
        lis = ArticleComment.objects.filter(belong_id=entry, parent=None)
    return lis


@register.simple_tag
def get_child_comments(category, com):
    """获取一个父评论的子评论列表"""
    if category == 'about':
        lis = AboutComment.objects.filter(parent=com)
    elif category == 'message':
        lis = MessageComment.objects.filter(parent=com)
    else:
        lis = ArticleComment.objects.filter(parent=com)
    return lis


@register.simple_tag
def get_comment_user_count(category, entry=0):
    """获取评论人总数"""
    p = []
    if category == 'about':
        lis = AboutComment.objects.all()
    elif category == 'message':
        lis = MessageComment.objects.all()
    else:
        lis = ArticleComment.objects.filter(belong_id=entry)
    for each in lis:
        if each.author not in p:
            p.append(each.author)
    return len(p)


# 递归查找父评论
def find_father(dic, comment_obj):
    # 对字典中的每一组元素进行循环操作
    for k, v_dic in dic.items():
        # 如果k等于comment_obj的父节点，那么表示找到了父亲。
        if k == comment_obj.parent:
            # 找到了父亲，认祖归宗，把自己归位到父亲下面，并给将来的儿子留个位置
            dic[k][comment_obj] = {}
            # 找到了父亲，处理完毕，返回
        else:
            # 刚才没找到，剥一层，接着往下找。
            find_father(dic[k], comment_obj)


# 递归生成HTML字符串，展示评论区内容
def generate_comment_html(sub_comment_dic, category, path, s=2):
    html = "<ul class='children'>"
    # 对传入的字典进行循环操作
    for k, v_dic in sub_comment_dic.items():
        users = Ouser.objects.filter(username=k.author.nickname)
        if users:
            user = users.first()
            img = user.avatar
            address = user.link
            to_user = k.parent.author.nickname
        else:
            img = "avatar/default.png"
            address = ""
        if users.first() == k.belong.author:
            nickname = "<strong>{}</strong><font color=red>「博主」</font>".format(k.author.nickname)
        else:
            nickname = k.author.nickname

        smile_list = re.findall(r'(:[a-z_!]+?:)', k.content)
        comment_content = k.content
        for i in smile_list:
            name = i.replace(':', '', 2)
            try:
                smile_img = '<img src="/static/comment/img/' + 'icon_' + settings.SMILES[name] + '.gif">'
                comment_content = comment_content.replace(i, smile_img)
            except KeyError:
                continue

        if address:
            if re.search('github.com', address):
                social = '<i class="fa fa-github" title="Github 绑定用户"></i>'
            elif re.search('weibo.com', address):
                social = '<i class="fa fa-weibo" title="Weibo 绑定用户"></i>'
            else:
                social = '<i class="fa fa-home" title="个人主页"></i>'
        else:
            social = ''

        html += '''<li class="comment odd alt depth-{0}" id="comment-{1}">
        <div class="c-avatar">
            <img alt='注册用户头像' src='/media/{7}' class='avatar avatar-54 photo' height='54' width='54' style="border-radius: 50%;" />
            <div class="c-main" id="div-comment-{1}">{2}
                <div class="c-meta">
                    <span class="c-author">
                        <a href='{8}' rel='external nofollow' class='url'>{3}</a>{10}
                        <i class="fa fa-share"></i>{9}
                    </span>{4}
                    <a rel='nofollow' class='comment-reply-link' href='{6}?replytocom={1}#respond' onclick='return addComment.moveForm( "div-comment-{1}", "{1}", "respond", "{5}" )' aria-label='回复给{3}'>回复
                    </a>
                </div>
            </div>
        </div>'''.format(s, k.id, comment_content, nickname, k.create_date.strftime('%Y-%m-%d %H:%M:%S'), category, path, img, address, to_user, social)

        # 有可能v_dic中依然有元素, 递归继续加
        if v_dic:
            s += 1
            html += generate_comment_html(v_dic, category, path, s)
        html += "</li>"
    # 循环完成最后返回html
    html += "</ul>"
    return html


# 生成层级评论
@register.simple_tag
def build_comment_tree(category, path, entry=0):
    if category == 'about':
        comment_list = AboutComment.objects.all()
    elif category == 'message':
        comment_list = MessageComment.objects.all()
    else:
        comment_list = ArticleComment.objects.filter(belong_id=entry)
    # 定义一个空字典用来保存转换之后的结果
    comment_dic = {}
    # 对comment_list中的每个元素进行循环
    for comment_obj in comment_list:
        # 判断comment_obj是否存在父节点。如果没有，这把该评论作为第一个节点
        if comment_obj.parent is None:
            comment_dic[comment_obj] = {}
        else:
            # 否则去找该对象的父节点。
            find_father(comment_dic, comment_obj)

    # 上面执行完毕，comment_dic中会有转换好的结果
    # 开始拼接html字符串
    html = "<ol class='commentlist'>"
    # 规定一个margin left，每次有递归的时候就往右缩进一点。

    # 对comment_dic中的每一组元素进行操作
    for k, v in comment_dic.items():
        users = Ouser.objects.filter(username=k.author.nickname)
        if users:
            user = users.first()
            img = user.avatar
            address = user.link
        else:
            img = "avatar/default.png"
            address = ""
        if users.first() == k.belong.author:
            nickname = "<strong>{}</strong><font color=red>「博主」</font>".format(k.author.nickname)
        else:
            nickname = k.author.nickname

        smile_list = re.findall(r'(:[a-z_!]+?:)', k.content)
        comment_content = k.content
        for i in smile_list:
            name = i.replace(':', '', 2)
            try:
                smile_img = '<img src="/static/comment/img/' + 'icon_' + settings.SMILES[name] + '.gif">'
                comment_content = comment_content.replace(i, smile_img)
            except KeyError:
                continue

        if address:
            if re.search('github.com', address):
                social = '<i class="fa fa-github" title="Github 绑定用户"></i>'
            elif re.search('weibo.com', address):
                social = '<i class="fa fa-weibo" title="Weibo 绑定用户"></i>'
            else:
                social = '<i class="fa fa-home" title="个人主页"></i>'
        else:
            social = ''

        # 第一层html
        html += '''<li class="comment even thread-even depth-1" id="comment-{0}">
        <div class="c-avatar">
        <img alt='注册用户头像' src='/media/{6}' class='avatar avatar-54 photo' height='54' width='54' style="border-radius: 50%;" />
        <div class="c-main" id="div-comment-{0}">{1}
        <div class="c-meta">
        <span class="c-author"><a href='{7}' rel='external nofollow' class='url'>{2}</a>{8}</span>{3}
        <a rel='nofollow' class='comment-reply-link' href='{5}?replytocom={0}#respond' 
        onclick='return addComment.moveForm( "div-comment-{0}", "{0}", "respond", "{4}" )' aria-label='回复给{2}'>回复</a>
        </div></div></div>'''.format(k.id, comment_content, nickname, k.create_date.strftime('%Y-%m-%d %H:%M:%S'), category, path, img, address, social)
        # 通过递归把他的儿子加上
        html += generate_comment_html(v, category, path)
    # 最后把ul关上
    html += " </ol>"
    # 关掉转义
    return mark_safe(html)


@register.simple_tag
def get_child_comments_second(com):
    """获取一个父评论的子平路列表"""
    lis = com.articlecomment_child_comments.all()
    return lis


@register.simple_tag
def get_all_comments(user, f=None):
    if f == 'false':
        comment_user = CommentUser.objects.get(nickname=user.username, email=user.email)
        comments = ArticleComment.objects.filter(Q(belong__author=user, parent=None, is_read=False) | Q(parent__author=comment_user, is_read=False) | Q(author=comment_user, is_read=False)).order_by('-create_date')
    else:
        comment_user = CommentUser.objects.get(nickname=user.username, email=user.email)
        comments = ArticleComment.objects.filter(
            Q(belong__author=user, parent=None) | Q(parent__author=comment_user) | Q(author=comment_user)).order_by('-create_date')
    return comments


@register.simple_tag
def get_unread_count(user, f=None):
    try:
        comment_user = CommentUser.objects.get(nickname=user.username, email=user.email)
        comments = ArticleComment.objects.filter(
            Q(belong__author=user, parent=None, is_read=False) | Q(parent__author=comment_user, is_read=False) | Q(author=comment_user, is_read=False))
        if comments:
            count = len(comments)
        else:
            count = ""
    except:
        count = ""
    return count


@register.simple_tag
def get_comment_user(user):
    comment_user = CommentUser.objects.get(nickname=user.username, email=user.email)
    return comment_user


@register.simple_tag
def get_article_comment_count(article):
    count = ArticleComment.objects.filter(belong=article).count()
    return count




