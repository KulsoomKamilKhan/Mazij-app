from django.urls import path
from .views import PostRecordDetail, PostRecordView, PostRecordDelete, PostRecordAccount, DraftRecordView, DraftRecordDelete

app_name = 'posts'
urlpatterns = [
    path('', PostRecordDetail.as_view(), name='posts'),
    path('<str:pk>/', PostRecordView.as_view(), name='posts'),
    path('<str:pk>/create/', PostRecordView.as_view(), name='posts'),
    path('delete-post/<str:pk>/', PostRecordDelete.as_view(), name='posts'),
    path('account-type/<str:pk>/', PostRecordAccount.as_view(), name='posts'),
    path('draft-mashup/<str:pk>/', DraftRecordView.as_view(), name='posts'),
    path('draft-delete/<int:pk>/', DraftRecordDelete.as_view(), name='posts'),
]

