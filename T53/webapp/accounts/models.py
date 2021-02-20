from django.db import models

# Create your models here.
from django.contrib.auth.models import (
    AbstractBaseUser,
    BaseUserManager,
    PermissionsMixin,
)
from django.core.validators import RegexValidator
from django.db import models


class UserManager(BaseUserManager):


    def create_user(self, phone_number, password):

        if not phone_number:
            raise ValueError("Phone number must be set")

        if not password:
            raise ValueError("Password must be set")
        # pass fields as arguments which are REQUIRED_FIELDS to user = self.model()
        user = self.model(phone_number=phone_number)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, phone_number, password):

        # for super user admin role is fixed to 1
        user = self.create_user(phone_number, password=password,)
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)
        return user


class User(AbstractBaseUser, PermissionsMixin):


    phone_regex = RegexValidator(
        regex=r"^\+?1?\d{9,15}$",
        message="Phone number must be entered in the format: '+919939799264'. Up to 15 digits allowed.",
    )
    phone_number = models.CharField(
        validators=[phone_regex], max_length=15, unique=True, null=False, blank=False
    )
    is_active = models.BooleanField(default=True, null=False, blank=False)
    is_staff = models.BooleanField(default=False, null=False, blank=False)
    is_superuser = models.BooleanField(default=False, null=False, blank=False)
    created_at = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(auto_now_add=True)

    # set USERNAME_FIELD to phone_number
    USERNAME_FIELD = "phone_number"
    # username AND password by default are included in REQUIRED_FIELDS
    REQUIRED_FIELDS = []
    objects = UserManager()

    def __str__(self):
        return self.phone_number

    def get_full_name(self):
        return self.phone_number


class PhoneOTP(models.Model):

    phone_regex = RegexValidator(
        regex=r"^\+?1?\d{9,15}$",
        message="Phone number must be entered in the format: '+919939799264'. Up to 15 digits allowed.",
    )
    phone_number = models.CharField(
        validators=[phone_regex], max_length=15, null=False, blank=False
    )
    otp = models.CharField(max_length=9, blank=False, null=False)
    timestamp = models.DateTimeField(auto_now_add=True)
    validated = models.BooleanField(default=False)

    def __str__(self):
        return str(self.phone_number) + " otp is " + str(self.otp)


class UserLoginActivity(models.Model):

    SUCCESS = "S"
    FAILED = "F"

    LOGIN_STATUS = ((SUCCESS, "Success"), (FAILED, "Failed"))
    phone_regex = RegexValidator(
        regex=r"^\+?1?\d{9,15}$",
        message="Phone number must be entered in the format: '+919939799264'. Up to 15 digits allowed.",
    )  # phone_number max length 15 including country code
    login_phone_number = models.CharField(
        validators=[phone_regex], max_length=15, null=False, blank=False
    )
    login_ip = models.GenericIPAddressField(null=True, blank=True)
    login_datetime = models.DateTimeField(auto_now=True)
    status = models.CharField(
        max_length=1, choices=LOGIN_STATUS, default=SUCCESS, null=True, blank=True
    )

    class Meta:
        verbose_name = "user_login_activity"
        verbose_name_plural = "user_login_activities"

    def __str__(self):
        return str(self.login_phone_number)
