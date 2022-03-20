from .models import Followers
from users.models import Userbase
from users.serializers import UserbaseSerializer
from rest_framework.serializers import ModelSerializer
from rest_framework import serializers
from drf_extra_fields.fields import Base64ImageField
 
class FollowerSerializer(serializers.ModelSerializer):
    def create(self, validated_data):
        follower = Followers.objects.create(**validated_data)
        return follower
    
    def update(self, instance, validated_data):
        instance.followers = validated_data.get('followers', instance.followers)
        instance.follows = validated_data.get('follows', instance.follows)

        instance.save()
        return instance

    class Meta:
            model= Followers
            fields= '__all__'
 
 
 
 
    
# class FollowerSerializer(serializers.ModelSerializer):
#     user = serializers.PrimaryKeyRelatedField(read_only=True)
#     def create(self, validated_data):
#         followers = Followers.objects.create(**validated_data)
#         return followers
    
#     def update(self, instance, validated_data):
#         instance.user = validated_data.get('user', instance.user)
#         instance.followers = validated_data.get('followers', instance.followers)
#         instance.follows = validated_data.get('follows', instance.follows)

#         instance.save()
#         return instance


#     class Meta:
#             model= Followers
#             fields= ['user', 'followers', 'follows']

# class FollowSerializer(serializers.ModelSerializer):

#     def update(self, instance, validated_data):
#         instance.user = validated_data.get('user', instance.user)
#         instance.follows = validated_data.get('follows', instance.follows)

#         instance.save()
#         return instance

#     class Meta:
#             model= Followers
#             fields= ['user', 'followers', 'follows']

# class FollowingSerializer(serializers.ModelSerializer):

#     def update(self, instance, validated_data):
#         instance.user = validated_data.get('user', instance.user)
#         instance.followers = validated_data.get('followers', instance.follows)

#         instance.save()
#         return instance

#     class Meta:
#             model= Followers
#             fields= ['user', 'followers', 'follows']
