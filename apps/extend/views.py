from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render, redirect, HttpResponseRedirect, reverse, HttpResponse
from django.core.paginator import Paginator
from django.conf import settings
from pyperclip import copy

from extend.models import Attachment


@csrf_exempt
def AttachmentView(request):
    fun = request.GET.get('fun', None)
    current_page_num = int(request.GET.get('page', 1))  # 通过a标签的GET方式请求，默认显示第一页
    if fun == "delete":
        pk = request.GET.get('pk', None)
        attachment = Attachment.objects.get(pk=int(pk))
        attachment.delete()
        return HttpResponse({"ok": "1"})
    if fun == "copy":
        pk = request.GET.get('pk', None)
        attachment = Attachment.objects.get(pk=int(pk))
        url = settings.PIC_HOST + "/media/" + attachment.file.name
        copy(url)
        return HttpResponse("ok")
    if fun is None:
        attachments = Attachment.objects.filter(is_public=True).order_by('-created_on')
        paginator = Paginator(attachments, 10)
        page = paginator.page(current_page_num)
        if len(page) == 0:
            page = ""
            paginator = ""
        return render(request, 'attachment/index.html', context={'fun': fun, "page": page, 'paginator': paginator})

