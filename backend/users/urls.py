from django.urls import path
from .views import UserRecordView, UserRecordDetail, Stats

app_name = 'users'
urlpatterns = [
    path('', UserRecordView.as_view(), name='users'),
    path('<str:pk>/', UserRecordDetail.as_view(), name='users'),
    path('<str:pk>/update/', UserRecordDetail.as_view(), name='users'),
    path('<str:pk>/delete/', UserRecordDetail.as_view(), name='users'),
    path('user/create/', UserRecordView.as_view(), name='users'),
    path('user/stats/', Stats.as_view(), name='users')
]
