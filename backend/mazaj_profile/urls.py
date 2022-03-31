from django.urls import path
from .views import ProfileRecordDetail, ProfileRecordPic, ProfileRecordView

app_name = 'mazaj_profile'
urlpatterns = [
    path('', ProfileRecordView.as_view(), name='profiles'),
    path('profile-pic/<str:pk>/', ProfileRecordPic.as_view(), name='profiles'),
    path('<str:pk>/', ProfileRecordDetail.as_view(), name='profiles'),
]