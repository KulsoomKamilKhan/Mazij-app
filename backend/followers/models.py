from django.db import models
from users.models import Userbase
from django_mysql.models import ListTextField

# Create your models here.
class Followers(models.Model):

    followers = models.CharField(max_length=140)
    follows = models.CharField(max_length=140)

    class Meta:
        db_table = "userbase"
        unique_together = (('followers', 'follows'),)
