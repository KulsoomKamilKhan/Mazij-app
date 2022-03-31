from users.models import Userbase
from users.serializers import UserbaseSerializer
from rest_framework.serializers import ModelSerializer, PrimaryKeyRelatedField
#from django.contrib.auth.models import User, Group
from rest_framework import serializers


class ProfileDisplaySerializer(serializers.ModelSerializer):

    class Meta:
        model = Userbase
        fields = ['username', 'profile_pic', 'bio', 'account_type']


class ProfileSerializer(serializers.ModelSerializer):

    def update(self, instance, validated_data):
        instance.username = validated_data.get('username', instance.username)
        instance.bio = validated_data.get('bio', instance.bio)
        instance.profile_pic = validated_data.get('profile_pic', instance.profile_pic)

        instance.save()
        return instance

    class Meta:
        model = Userbase
        fields = ['username', 'profile_pic', 'bio']

class ProfilePicSerializer(serializers.ModelSerializer):

    def update(self, instance, validated_data):
        instance.username = validated_data.get('username', instance.username)
        instance.profile_pic = validated_data.get('profile_pic', instance.profile_pic)

        instance.save()
        return instance

    class Meta:
        model = Userbase
        fields = ['username', 'profile_pic']

class UserbaseAccountTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Userbase
        fields = ['account_type']



