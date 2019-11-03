import os
import datetime
from django.db import models


# Create your models here.
def upload_to(instance, filename):
    file_name_list = filename.split('.')
    file_extension = file_name_list.pop(-1)
    name = '%s.%s' % ('{0:%Y%m%d%H%M%S}'.format(datetime.datetime.now()), file_extension)
    return '/'.join(['upload', name])


# 附件资源
class Attachment(models.Model):
    """
    附件表
    """
    TYPE_OF = [
        ('1', 'Article'),
    ]
    name = models.CharField(max_length=500, blank=True, null=True)
    type_of = models.CharField(max_length=50, blank=True, null=True)
    mime_type = models.CharField(max_length=100, blank=True, null=True)
    size = models.CharField(max_length=100, blank=True, null=True)
    file = models.FileField(max_length=1000, upload_to=upload_to)
    url = models.CharField(max_length=255, null=True, blank=True)
    desc = models.CharField(max_length=1024, null=True, blank=True)
    is_public = models.BooleanField(default=True)
    created_on = models.DateTimeField(auto_now_add=True)
    updated_on = models.DateTimeField(auto_now=True)

    class Meta:
        default_permissions = ('add', 'change', 'delete', 'public')

    def delete(self, *args, **kwargs):
        if os.path.isfile(self.file.path):
            os.remove(self.file.path)
        super(Attachment, self).delete(*args, **kwargs)

    def get_url(self):
        return '/media/' + self.file.name


class TemplateValue(models.Model):
    TEMPLATE_TYPE = [
        ('1', 'Article'),
    ]
    model = models.CharField(choices=TEMPLATE_TYPE, max_length=1, default='1')
    object_id = models.IntegerField(db_index=True)
    order = models.IntegerField('资源编号', blank=True, auto_created=True)
    value = models.TextField()

    def __str__(self):
        return self.get_model_display() + "-" + str(self.object_id)

    class Meta:
        default_permissions = ('add', 'change', 'delete', 'public')