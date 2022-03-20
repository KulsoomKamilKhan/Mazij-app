from django.contrib import admin

# Register your models here.
from .models import Post, Draft 
admin.site.register(Post)
admin.site.register(Draft)