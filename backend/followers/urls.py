from django.urls import path
from .views import FollowersRecordView, FollowersRecordAdd, FollowersDelete

app_name = 'posts'
urlpatterns = [
    path('', FollowersRecordView.as_view(), name='followers'),
    path('user/<str:pk>', FollowersRecordAdd.as_view(), name='followers'),
    path('delete/<int:pk>', FollowersDelete.as_view(), name='followers')
]