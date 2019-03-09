# 创建了新的tags标签文件后必须重启服务器

from django import template
from ..models import Article, Category, Tag, Carousel, FriendLink,BigCategory, Activate,Keyword
from django.db.models.aggregates import Count
from django.utils.html import mark_safe
import re

register = template.Library()


# 文章相关标签函数
@register.simple_tag
def get_article_list(sort=None, num=None):
    '''获取指定排序方式和指定数量的文章'''
    if sort:
        if num:
            return Article.objects.order_by(sort)[:num]
        return Article.objects.order_by(sort)
    if num:
        return Article.objects.all()[:num]
    return Article.objects.all()

@register.simple_tag
def get_data_date():
    '''获取文章发表的不同月份'''
    article_dates = Article.objects.datetimes('create_date', 'month', order='DESC')

    return article_dates


@register.simple_tag
def keywords_to_str(art):
    '''将文章关键词变成字符串'''
    keys = art.keywords.all()
    return ','.join([key.name for key in keys])


@register.simple_tag
def get_tag_list():
    '''返回标签列表'''
    return Tag.objects.annotate(total_num=Count('article')).filter(total_num__gt=0)


@register.simple_tag
def get_category_list(id):
    '''返回小分类列表'''
    return Category.objects.filter(bigcategory_id=id)

@register.simple_tag
def get_bigcategory_list():
    '''返回大分类列表'''
    return BigCategory.objects.all()


@register.inclusion_tag('blog/tags/article_list.html')
def load_article_summary(articles):
    '''返回文章列表模板'''
    return {'articles': articles}


@register.inclusion_tag('blog/tags/pagecut.html', takes_context=True)
def load_pages(context):
    '''分页标签模板，不需要传递参数，直接继承参数'''
    return context


# 其他函数
@register.simple_tag
def get_carousel_list():
    '''获取轮播图片列表'''
    return Carousel.objects.all()


@register.simple_tag
def get_star(num):
    '''得到一排星星'''
    tag_i = '<i class="fa fa-star"></i>'
    return mark_safe(tag_i * num)


@register.simple_tag
def get_star_title(num):
    '''得到星星个数的说明'''
    the_dict = {
        1: '【1颗星】：微更新，涉及轻微调整或者后期规划了内容',
        2: '【2颗星】：小更新，小幅度调整，一般不会迁移表格',
        3: '【3颗星】：中等更新，一般会增加或减少模块，有表格的迁移',
        4: '【4颗星】：大更新，涉及到应用的增减',
        5: '【5颗星】：最大程度更新，一般涉及多个应用和表格的变动',
    }
    return the_dict[num]


@register.simple_tag
def my_highlight(text, q):
    '''自定义标题搜索词高亮函数，忽略大小写'''
    if len(q) > 1:
        try:
            text = re.sub(q, lambda a: '<span class="highlighted">{}</span>'.format(a.group()),
                          text, flags=re.IGNORECASE)
            text = mark_safe(text)
        except:
            pass
    return text


@register.simple_tag
def get_request_param(request, param, default=None):
    '''获取请求的参数'''
    return request.POST.get(param) or request.GET.get(param, default)


@register.simple_tag
def get_friends():
    '''获取活跃的友情链接'''
    return FriendLink.objects.filter(is_show=True, is_active=True)

# @register.simple_tag
# def get_comment():
#     '''获取活跃的友情链接'''
#     return FriendLink.objects.filter(is_show=True, is_active=True)


@register.simple_tag
def get_active():
    '''获取活跃的友情链接'''
    text = Activate.objects.filter(is_active=True)
    if text:
        text = text[0].text
    else:
        text = ''
    return mark_safe(text)


@register.simple_tag
def get_carousel_right():
    return Carousel.objects.filter(number__gt=5, number__lte=10)


@register.simple_tag
def get_carousel_index():
    return Carousel.objects.filter(number__lte=5)


@register.simple_tag
def get_carousel_left():
    return Carousel.objects.filter(number__gt=10)


@register.simple_tag
def get_article_tag(article_id):
    return Tag.objects.filter(article=article_id)


@register.simple_tag
def get_article_previous(article_id):
    article = Article.objects.filter(id=article_id - 1)
    if article:
        return article[0]
    else:
        return


@register.simple_tag
def get_article_next(article_id):
    article = Article.objects.filter(id=article_id + 1)
    if article:
        return article[0]
    else:
        return


@register.simple_tag
def get_category_article():
    article_4 = get_article_list('views', 4)
    article_8 = get_article_list('views', 8)
    return {'article_4': article_4, 'article_8': article_8}


@register.simple_tag
def get_title(category):
    a=BigCategory.objects.filter(slug=category)
    if a:
        return a[0]

@register.simple_tag
def get_article_keywords(article):
    keywords=[]
    a=Keyword.objects.filter(article=article)
    for key in a:
        keywords.append(key.name)
    return ','.join(keywords)