from django.db import models
from accounts.models import User
# Create your models here.

class Product(models.Model):

    CATEGORIES = (
        (0, "None"),
        (1, "Vegetable"), 
        (2, "Fruits"),
    )

    farmer = models.ForeignKey(User, on_delete=models.PROTECT)
    category = models.PositiveIntegerField(choices=CATEGORIES, default=0)
    #tags = TaggableManager(blank=True)
    name = models.CharField(max_length=150)
    slug = models.SlugField(max_length=200)
    description = models.TextField(max_length=500, default="Empty description.")
    picture = models.ImageField(upload_to="products/images", null=True, blank=True)
    price = models.PositiveIntegerField(default=0)
    quantity = models.IntegerField(default=10) 
    featured = models.BooleanField(default=False)

    class Meta:
        ordering = ("name",)
    
    @property
    def is_featured(self):
        return self.featured

    @property
    def is_available(self):
        return self.quantity > 0

    def __str__(self):
        return self.name