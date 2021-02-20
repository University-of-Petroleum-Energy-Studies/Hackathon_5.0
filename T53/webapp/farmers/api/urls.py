from django.urls import path, include
from rest_framework.routers import DefaultRouter


from farmers.api.views import ProductViewSet

router = DefaultRouter()
router.register("", ProductViewSet)

urlpatterns = [
    path("add_prod/", include(router.urls), name='product'), 
    ]