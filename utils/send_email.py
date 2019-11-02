import markdown
from random import Random  # 用于生成随机码
from django.core.mail import send_mail, EmailMessage  # 发送邮件模块
from django.conf import settings
from user.models import VerifyRecord, Ouser  # 邮箱验证model


# 生成随机字符串
def random_str(code_len=8):
    str_code = ''
    chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789'
    length = len(chars) - 1
    random = Random()
    for i in range(code_len):
        str_code += chars[random.randint(0, length)]
    return str_code


def common_send_email(email, s_type=None, username=None, content=None):
    # 如果为注册类型
    if s_type == "1":
        email_record = VerifyRecord()
        # # 将给用户发的信息保存在数据库中
        code = random_str(8)
        email_record.code = code
        email_record.key = email
        email_record.v_type = s_type
        email_record.save()
        email_title = "欢迎注册StormSha的个人主页"
        html = open('../common/html/email.html', 'r', encoding="utf-8")
        content = html.read()
        url = '{0}/account/active/{1}/'.format(settings.WEB_SITE, code)
        content = content.replace('(title)', email_title)
        content = content.replace('(username)', username)
        content = content.replace('(url)', url)
        # 发送邮件
        msg = EmailMessage(email_title, content, settings.EMAIL_FROM, [email])
        msg.content_subtype = "html"
        msg.send()
    if s_type == "4":
        email_record = VerifyRecord()
        email_record.key = email
        email_title = "{}-个人主页私信".format(username)
        body = content
        msg = EmailMessage(email_title, body, settings.EMAIL_FROM, [settings.EMAIL_FROM])
        msg.content_subtype = "html"
        msg.send()




