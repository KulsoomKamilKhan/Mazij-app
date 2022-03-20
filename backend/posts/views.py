from django.urls import reverse_lazy
from django.views import View
from .models import Post, Draft
from users.models import Userbase
from django.views.generic.edit import UpdateView, DeleteView


from django.shortcuts import render

# Create your views here.

from .serializers import PostSerializer, DraftSerializer, UpvoteSerializer
from mazaj_profile.serializers import UserbaseAccountTypeSerializer
from users.serializers import UserbaseSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser
from rest_framework.decorators import api_view
from django.shortcuts import get_object_or_404

class PostRecordDetail(APIView):

    def get(self, request, format=None):
        posts = Post.objects.all()
        serializer = PostSerializer(posts, many=True)
        dict = []
        for post in serializer.data:
                y = post.get('user')
                post.update(UserbaseAccountTypeSerializer(Userbase.objects.get(username = y), many = False).data)
                temp = {}
                temp.update(post)
                dict.append(temp)
        return Response(dict)
        return Response(serializer.data)

class PostRecordView(APIView):

    def get(self, request, pk, format=None):
        posts = Post.objects.filter(user = pk)
        serializer = PostSerializer(posts, many=True)
        return Response(serializer.data)
    
    def post(self, request, pk, format=None):
        user = Userbase.objects.get(username = pk)
        request.data["user"] = user
        serializer = PostSerializer(data=request.data)
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


class PostRecordDelete(APIView):

    def get(self, request, pk, format=None):
        post = Post.objects.get(id = pk)
        serializer = PostSerializer(post, many=False)
        return Response(serializer.data)

    def delete(self, request, pk, format=None):
        post = Post.objects.get(id = pk)
        post.delete()
        return Response()  

    def put(self, request, pk, format=None):
        post = Post.objects.get(id = pk)
        data = request.data
        serializer = UpvoteSerializer(instance = post, data = data, partial = True)
        if serializer.is_valid(raise_exception = True):
            new_data = serializer.save()
        return Response(serializer.data)

class PostRecordAccount(APIView):

    def get(self, request, pk, format=None):
        account_type = Userbase.objects.filter(account_type = pk)
        dict = []
        for user in account_type:
            posts = Post.objects.filter(user = user)
            serializer = PostSerializer(posts, many=True)
            for post in serializer.data:
                y = x.get('username')
                x.update(UserbaseAccountTypeSerializer(Userbase.objects.get(username = y), many = False).data)
                temp = {}
                temp.update(post)
                dict.append(temp)
        return Response(dict)

class DraftRecordView(APIView):

    def get(self, request, pk, format=None):
        draft = Draft.objects.filter(user = pk)
        serializer = DraftSerializer(draft, many=True)
        return Response(serializer.data)

    def post(self, request, pk, format=None):
        user = Userbase.objects.get(username = pk)
        request.data["user"] = user
        serializer = DraftSerializer(data=request.data)
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

class DraftRecordDelete(APIView):

    def get(self, request, pk, format=None):
        draft = Draft.objects.get(id = pk)
        serializer = DraftSerializer(draft, many=False)
        return Response(serializer.data)
    
    def delete(self, request, pk, format=None):
        draft = Draft.objects.get(id = pk)
        draft.delete()
        return Response()
    

