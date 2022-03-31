from django.db import models
from users.models import Userbase
from django.utils import timezone

# Create your models here.
class Post(models.Model):  
    def user_directory_path(instance, filename):
        # file will be uploaded to MEDIA_ROOT/user_<account_type>/username/<filename>
        return '{0}/{1}/{2}'.format(instance.user.account_type, instance.user.username, filename)
    
    #post = models.ImageField(upload_to=user_directory_path, default = None)
    post = models.TextField()
    caption = models.CharField(max_length=140)
    user = models.ForeignKey(Userbase, on_delete=models.CASCADE)
    upvotes = models.PositiveIntegerField(default=0)
    created_on = models.DateTimeField(default=timezone.now)
    collaborators = models.CharField(max_length=255)

class Draft(models.Model):
    user = models.ForeignKey(Userbase, on_delete=models.CASCADE)
    draft = models.TextField()

class Meta:
    db_table = "userbase"
