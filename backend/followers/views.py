from django.urls import reverse_lazy
from django.views import View
from .models import Followers
from users.models import Userbase
from django.views.generic.edit import UpdateView, DeleteView


from django.shortcuts import render

# Create your views here.

from .serializers import FollowerSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser
from rest_framework.decorators import api_view
from django.shortcuts import get_object_or_404



class FollowersRecordView(APIView):
    def get(self, request, format=None):
        list = Followers.objects.all()
        serializer = FollowerSerializer(list, many=True)
        return Response(serializer.data)
    
class FollowersRecordAdd(APIView):
    def get(self, request, pk, format=None):
        list = Followers.objects.filter(followers = pk)
        serializer = FollowerSerializer(list, many=True)
        return Response(serializer.data)    
    
    def post(self, request, pk, format=None):
        serializer = FollowerSerializer(data=request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )

    def put(self, request, pk, format=None):
        follows = Followers.objects.get(followers = pk)
        data = request.data
        serializer = FollowerSerializer(instance = follows, data = data, partial = True)
        if serializer.is_valid(raise_exception = True):
            new_data = serializer.save()
        return Response(serializer.data)


class FollowersDelete(APIView):
    def get(self, request, pk, format=None):
        list = Followers.objects.filter(id = pk)
        serializer = FollowerSerializer(list, many=True)
        return Response(serializer.data) 

    def delete(self, request, pk, format=None):
        follows = Followers.objects.get(id = pk)
        follows.delete()
        return Response() 
    
