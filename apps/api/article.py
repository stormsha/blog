# -*- coding: utf-8 -*-
from __future__ import unicode_literals

# django
from rest_framework.views import APIView, Response
from api.permissions import check_action_permission
from storm.models import Article
from api.serializers import ArticleSerializer


class ArticleView(APIView):

    def get(self, request):
        items = Article.objects.all()
        ser_data_items = ArticleSerializer(instance=items, many=True)
        return Response({"status": "1", "data": ser_data_items.data})

    def patch(self, request, pk):
        client_data = request.data  # 获取客户端提交数据
        obj = Article.objects.get(pk=int(pk))
        print(client_data)
        ser_data = ArticleSerializer(data=client_data, instance=obj, partial=True)  # 序列化客户端提交数据
        if ser_data.is_valid():  # 检验数据合法行
            ser_data.save()  # 创建数据记录
            return Response(ser_data.data.get('loves'))
        else:
            return Response({"status": "0", "error_message": "update loves fail."})

