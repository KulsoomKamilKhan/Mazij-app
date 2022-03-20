from django.utils import timezone
from django.db import models

# Create your models here.

class Userbase(models.Model):
    ACCOUNT_TYPES = (
        ('S','Student'),
        ('A','Artist'),
        ('CC','Content Creators'),
        ('BM','Brand Marketers'),
        ('G', 'General'),
    )

    username = models.CharField(max_length=20,primary_key=True)
    profile_pic = models.TextField()
    bio = models.CharField(max_length=255, blank=True)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    email = models.EmailField(unique=True)
    account_type = models.CharField(max_length=2,choices = ACCOUNT_TYPES,null=True)
    date_of_birth = models.DateField(null=True)
    passwords = models.CharField(max_length=160)
    created_on = models.DateTimeField(default=timezone.now)

class Meta:
    db_table = "userbase"