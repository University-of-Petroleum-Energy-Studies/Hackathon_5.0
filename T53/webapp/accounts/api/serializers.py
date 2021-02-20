from django.contrib.auth import authenticate, user_logged_in, user_login_failed
from django.contrib.auth.hashers import make_password
from django.core.validators import RegexValidator
from django.contrib.auth.models import Group
from django.utils import timezone
from rest_framework import serializers
from rest_framework.authtoken.models import Token

from accounts.models import PhoneOTP, User

#from .signals import create_user_profile


class PhoneNumberSerializer(serializers.Serializer):
    phone_regex = RegexValidator(
        regex=r"^\+?1?\d{9,15}$",
        message="Phone number must be entered in the format: '+919939799264'. Up to 13 digits allowed.",
    )
    phone_number = serializers.CharField(
        validators=[phone_regex], min_length=13, max_length=13
    )


class UserLoginSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ("phone_number", "password")

    def validate(self, attrs):
        # print(attrs)
        user = authenticate(
            phone_number=attrs["phone_number"], password=attrs["password"]
        )
        if user:
            token, _ = Token.objects.get_or_create(user=user)
            print(token.key)
            return token.key
        else:
            token = ""
            return token



class FarmerSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ("phone_number", "password")
        extra_kwargs = {"password": {"write_only": True}}

    def create(self, validated_data):
        user = User.objects.create_user(
            phone_number=validated_data["phone_number"],
            password=validated_data["password"],
        )
        user.save()
        farmer_group = Group.objects.get(name="farmers")
        farmer_group.user_set.add(user)
        """create_user_profile.send(
            sender=User, phone_number=validated_data["phone_number"], group="farmers"
        )"""
        return user


class TraderSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ("phone_number", "password")
        extra_kwargs = {"password": {"write_only": True}}

    def create(self, validated_data):
        user = User.objects.create_user(
            phone_number=validated_data["phone_number"],
            password=validated_data["password"],
        )
        user.save()
        trader_group = Group.objects.get(name="traders")
        trader_group.user_set.add(user)
        """create_user_profile.send(
            sender=User, phone_number=validated_data["phone_number"], group="traders"
        )"""
        return user


class PhoneOTPSerializer(serializers.ModelSerializer):
    class Meta:
        model = PhoneOTP
        fields = ("phone_number", "otp")

    def create(self, validated_data):
        otp = PhoneOTP.objects.create(
            phone_number=validated_data["phone_number"],
            otp=validated_data["otp"],
            timestamp=timezone.now(),
        )
        otp.save()
        return otp
