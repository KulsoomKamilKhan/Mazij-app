from django.contrib import admin
from django.urls import path, include
from rest_framework.authtoken import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('users/', include('users.urls', namespace='users')),                                           # Get information on all users
    path('users/<str:pk>/', include('users.urls', namespace='users')),                                  # Get information on a specific users
    path('<str:pk>/update/', include('users.urls', namespace='users')),                                 # Update user details
    path('<str:pk>/delete/', include('users.urls', namespace='users')),                                 # Delete a user
    path('users/user/create/', include('users.urls', namespace='users')),                               # Create a new user
    path('users/user/stats/', include('users.urls', namespace='users')),
    path('users-token-auth/', views.obtain_auth_token, name='users-token-auth'),                        #
    path('profiles/', include('mazaj_profile.urls', namespace='profiles')),                             # for all profiles (get)
    path('profiles/profile-pic/<str:pk>/', include('mazaj_profile.urls', namespace='profiles')),        # for profile pic(get, put)                   
    path('profiles/<str:pk>/', include('mazaj_profile.urls', namespace='profiles')),                    # for username's profile (get, put(update))
    path('posts/', include('posts.urls', namespace='posts')),                                           # all posts (get)
    path('posts/<str:pk>/', include('posts.urls', namespace='posts')),                                  # posts by username (get)
    path('posts/<str:pk>/create/', include('posts.urls', namespace='posts')),                           # creating post by username (use post method)
    path('posts/delete-post/<str:pk>/', include('posts.urls', namespace='posts')),                      # delete post by id
    path('posts/account-type/<str:pk>/', include('posts.urls', namespace='posts')),                     # getting all posts by account type (get)
    path('posts/draft-mashup/<str:pk>/', include('posts.urls', namespace='posts')),
    path('posts/draft-delete/<int:pk>/', include('posts.urls', namespace='posts')),
    path('followers/', include('followers.urls', namespace='followers')),                               # to show all users with followers/follows (get)
    path('followers/user/<str:pk>', include('followers.urls', namespace='followers')),                  # to add a user into the table (post) and update followers/follows (put)
    path('followers/delete/<int:pk>', include('followers.urls', namespace='followers')),
]