# from django.contrib.auth.models import User,Group
from rest_framework.serializers import ModelSerializer
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator
from .models import Userbase


class UserbaseSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        user = Userbase.objects.create(**validated_data)
        return user

    def update(self, instance, validated_data):
        instance.username = validated_data.get('username', instance.username)
        instance.first_name = validated_data.get('first_name', instance.first_name)
        instance.last_name = validated_data.get('last_name', instance.last_name)
        instance.email = validated_data.get('email', instance.email)
        instance.account_type = validated_data.get('account_type', instance.account_type)
        instance.date_of_birth = validated_data.get('date_of_birth', instance.date_of_birth)
        instance.passwords = validated_data.get('passwords', instance.passwords)

        instance.save()
        return instance

    class Meta:
        model = Userbase
        fields = ['username', 'first_name', 'last_name', 'email', 'account_type', 'date_of_birth', 'passwords']
        validators = [
            UniqueTogetherValidator(
                queryset=Userbase.objects.all(),
                fields=['username', 'email']
            )
        ]
