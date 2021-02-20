from rest_framework import serializers

from farmers.models import Product

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = (
            "id",
            "name",
            "price",
            "quantity",
            "featured",
            "description",
            "picture",
            "slug",
        )
        lookup_field = "slug"