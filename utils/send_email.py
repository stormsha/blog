from random import Random  # 用于生成随机码
from django.core.mail import send_mail  # 发送邮件模块
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


def send_register_email(email, v_type=None):
    users = Ouser.objects.count()
    email_record = VerifyRecord()
    # 将给用户发的信息保存在数据库中
    code = random_str(8)
    email_record.code = code
    email_record.key = email
    email_record.v_type = v_type
    email_record.save()
    # 如果为注册类型
    if v_type == "1":
        email_title = "欢迎注册StormSha的个人主页。你好，很高兴能成为你你学习路上的小伙伴".format(users)
        email_body = "请点击下面的链接激活你的账号:{0}/account/active/{1}/".format(settings.WEB_SITE, code)
        # 发送邮件
        print(email_title, email_body, settings.EMAIL_FROM, [email])
        send_status = send_mail(email_title, email_body, settings.EMAIL_FROM, [email])
        print(send_status)
        if send_status:
            return True
        else:
            return False

