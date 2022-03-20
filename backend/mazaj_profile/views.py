import profile
from django.urls import reverse_lazy
from django.views import View
from users.models import Userbase


from django.shortcuts import render

# Create your views here.

from .serializers import ProfileDisplaySerializer, ProfileSerializer, ProfilePicSerializer, UserbaseAccountTypeSerializer
from users.serializers import UserbaseSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser
from rest_framework.decorators import api_view
from django.shortcuts import get_object_or_404

class ProfileRecordDetail(APIView):

    def get(self, request, pk, format=None):
        username = Userbase.objects.get(username = pk)
        serializer_profile = ProfileSerializer(username, many=False)
        serializer_acc_type = UserbaseAccountTypeSerializer(username, many = False)
        serializer_dict = {}
        serializer_dict.update(serializer_profile.data)
        serializer_dict.update(serializer_acc_type.data)
        return Response(serializer_dict)
    
    def put(self, request, pk, format=None):
        user = Userbase.objects.get(username = pk)
        data = request.data
        serializer = ProfileSerializer(instance = user, data = data, partial = True)
        if serializer.is_valid(raise_exception = True):
            new_data = serializer.save()
        return Response(serializer.data)


class ProfileRecordPic(APIView):

    def get(self, request, pk, format=None):
        username = Userbase.objects.get(username = pk)
        serializer_profile = ProfilePicSerializer(username, many=False)
        serializer_acc_type = UserbaseAccountTypeSerializer(username, many = False)
        serializer_dict = {}
        serializer_dict.update(serializer_profile.data)
        serializer_dict.update(serializer_acc_type.data)
        return Response(serializer_dict)
    
    def put(self, request, pk, format=None):
        user = Userbase.objects.get(username = pk)
        data = request.data
        serializer = ProfilePicSerializer(instance = user, data = data, partial = True)
        if serializer.is_valid(raise_exception = True):
            new_data = serializer.save()
        return Response(serializer.data)
    


class ProfileRecordView(APIView):

    def get(self, request, format=None):
        profiles = Userbase.objects.all()
        serializer = ProfileDisplaySerializer(profiles, many=True)
        return Response(serializer.data)
    
