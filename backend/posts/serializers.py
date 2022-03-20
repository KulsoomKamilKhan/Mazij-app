from .models import Post, Draft
from users.models import Userbase
from users.serializers import UserbaseSerializer
from rest_framework.serializers import ModelSerializer
from rest_framework import serializers
from drf_extra_fields.fields import Base64ImageField
    
class PostSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(read_only=True)

    def create(self, validated_data):
        post = Post.objects.create(**validated_data)
        return post

    class Meta:
            model= Post
            fields= '__all__'

class DraftSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(read_only=True)

    def create(self, validated_data):
        draft = Draft.objects.create(**validated_data)
        return draft

    class Meta:
            model= Draft
            fields= '__all__'

class UpvoteSerializer(serializers.ModelSerializer):

    def update(self, instance, validated_data):
        instance.id = validated_data.get('id', instance.id)
        instance.upvotes = validated_data.get('upvotes', instance.upvotes)

        instance.save()
        return instance

    class Meta:
            model= Post
            fields= '__all__'
    

