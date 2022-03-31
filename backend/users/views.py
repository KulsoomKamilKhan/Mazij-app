from django.shortcuts import render

# Create your views here.
from django.db.models import Count
from django.db.models import Sum
from django.db.models import Max
import datetime
from .serializers import UserbaseSerializer
from .models import Userbase
from posts.models import Post
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser
from django.contrib.auth.models import User
from rest_framework.decorators import api_view
from django.shortcuts import get_object_or_404


class UserRecordView(APIView):
    """ 
    API View to create or get a list of all the registered
    users. GET request returns the registered users whereas
    a POST request allows to create a new user.
    """

    #GET METHOD
    def get(self, format=None):
        users = Userbase.objects.all()
        serializer = UserbaseSerializer(users, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = UserbaseSerializer(data=request.data)
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

class UserRecordDetail(APIView):

    def get(self, request, pk, format=None):
        user = Userbase.objects.get(username = pk)
        serializer = UserbaseSerializer(user, many=False)
        return Response(serializer.data)
    
    def put(self, request, pk, format=None):
        user = Userbase.objects.get(username = pk)
        data = request.data
        serializer = UserbaseSerializer(instance = user, data = data, partial = True)
        if serializer.is_valid(raise_exception = True):
            new_data = serializer.save()
        return Response(serializer.data)
    
    def delete(self, request, pk, format=None):
        user = Userbase.objects.get(username = pk)
        user.delete()
        return Response()

class Stats(APIView):
    
    def get(self, format=None):
        dict = {}

        user = Userbase.objects.filter(created_on__gt=datetime.datetime.today()-datetime.timedelta(days=30)).values('created_on').annotate(users=Count('username'))
        dict["users"] = len(user)

        post = Post.objects.filter(created_on__gt=datetime.datetime.today()-datetime.timedelta(days=30)).values('created_on').annotate(posts=Count('post'))
        dict["posts"] = len(post)

        upvotes = Post.objects.all().aggregate(Sum('upvotes'))
        dict["total upvotes"] = upvotes.get('upvotes__sum')

        upvotes = Post.objects.all().aggregate(Max('upvotes'))
        dict["max upvotes"] = upvotes.get('upvotes__max')

        return Response(dict)