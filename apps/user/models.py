from django.db import models
from django.contrib.auth.models import AbstractUser
from imagekit.models import ProcessedImageField
from imagekit.processors import ResizeToFill


# 继承 AbstractUser ，django 自带用户类，扩展用户个人网站字段，用户头像字段
class Ouser(AbstractUser):
    # 扩展用户个人网站字段
    link = models.URLField('个人网址', blank=True, help_text='提示：网址必须填写以http开头的完整形式')
    # 扩展用户头像字段
    avatar = ProcessedImageField(
        upload_to='avatar/%Y/%m/%d',
        default='avatar/default.png',
        verbose_name='头像',
        processors=[ResizeToFill(80, 80)]
    )

    class Meta:
        verbose_name = '用户'  # 定义网站管理后台表名
        verbose_name_plural = verbose_name
        ordering = ['-id']

    def __str__(self):
        return self.username


class VerifyRecord(models.Model):
    VERIFY_TYPE = [
        ('1', 'register'),
        ('2', 'forget'),
        ('3', 'chat')
    ]
    code = models.CharField(max_length=20, verbose_name=u"验证码")
    key = models.EmailField(max_length=50, verbose_name=u"邮箱")
    # 包含注册验证和找回验证
    v_type = models.CharField(verbose_name=u"验证码类型", max_length=10, choices=VERIFY_TYPE)
    v_time = models.DateTimeField(verbose_name=u"发送时间", auto_now_add=True)

    class Meta:
        verbose_name = u"用户验证"
        verbose_name_plural = verbose_name

    def __unicode__(self):
        return '{0}({1})'.format(self.code, self.key)

