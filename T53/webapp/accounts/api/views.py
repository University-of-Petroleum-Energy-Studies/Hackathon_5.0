from django.contrib.auth import authenticate, login
from django.http import JsonResponse
from django.shortcuts import get_list_or_404
from django.utils import timezone
from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema

from accounts.api.serializers import (
    FarmerSerializer,
    TraderSerializer,
    PhoneNumberSerializer,
    PhoneOTPSerializer,
    UserLoginSerializer,
)
from accounts.models import PhoneOTP, User

#from .signals import create_user_profile
#from .utils import send_otp

# DRF YASG Parameters settings
phone_number = openapi.Parameter(
    "phone_number",
    in_=openapi.IN_QUERY,
    description="Enter phone_number",
    type=openapi.TYPE_STRING,
)

otp = openapi.Parameter(
    "otp", in_=openapi.IN_QUERY, description="Enter otp", type=openapi.TYPE_STRING
)

password = openapi.Parameter(
    "password",
    in_=openapi.IN_QUERY,
    description="Enter password",
    type=openapi.TYPE_STRING,
)


class ValidatePhoneNumberSendOTP(APIView):
    permission_classes = [AllowAny]
    serializer_class = PhoneOTPSerializer

    @swagger_auto_schema(manual_parameters=[phone_number],)
    def post(self, request, *args, **kwargs):
        phone_number = request.data.get("phone_number")
        data = {"phone_number": phone_number}
        serializer = PhoneNumberSerializer(data=data)

        if serializer.is_valid():
            try:
                user = User.objects.get(phone_number=phone_number)
                if user:
                    errors = {"message": ["User already exists"]}
                    return Response(errors, status=status.HTTP_409_CONFLICT)
            except User.DoesNotExist:
                # send otp function is defined
                otp_key = send_otp(phone_number)
                data = {"phone_number": phone_number, "otp": otp_key}
                serializer = PhoneOTPSerializer(data=data)
                # print(serializer)
                if serializer.is_valid():
                    serializer.save()
                    success = {
                        "success_message": [
                            "OTP has been sent, please check your phone number"
                        ]
                    }
                    return Response(success, status=status.HTTP_200_OK)
                else:
                    return Response(
                        serializer.errors, status=status.HTTP_500_INTERNAL_SERVER_ERROR
                    )
        else:
            return Response(serializer.errors, status=status.HTTP_406_NOT_ACCEPTABLE)


class ValidateOTP(APIView):
    permission_classes = [AllowAny]

    @swagger_auto_schema(manual_parameters=[phone_number, otp])
    def post(self, request, *args, **kwargs):
        phone_number = request.data.get("phone_number")
        otp = request.data.get("otp")

        data = {"phone_number": phone_number, "otp": otp}
        serializer = PhoneOTPSerializer(data=data)
        if serializer.is_valid():
            db_otp = PhoneOTP.objects.filter(
                phone_number__iexact=phone_number
            ).order_by("-timestamp")
            if not db_otp:
                errors = {"message": ["Please send the otp first"]}
                return Response(errors, status=status.HTTP_404_NOT_FOUND)
            else:
                # print(db_otp)
                db_otp = db_otp[0]
                if str(otp) == str(db_otp.otp):
                    db_otp.validated = True
                    db_otp.save()
                    success = {"success_message": ["OTP has been verified"]}
                    return Response(success, status=status.HTTP_200_OK)
                else:
                    errors = {"message": ["OTP did not match, please check your OTP"]}
                    return Response(errors, status=status.HTTP_401_UNAUTHORIZED)
        else:
            return Response(serializer.errors, status=status.HTTP_406_NOT_ACCEPTABLE)


class TraderRegisterView(APIView):

    permission_classes = [AllowAny]
    serializer_class = TraderSerializer

    @swagger_auto_schema(manual_parameters=[phone_number, password])
    def post(self, request, *args, **kwargs):
        phone_number = request.data.get("phone_number")
        password = request.data.get("password")
        data = {"phone_number": phone_number, "password": password}

        serializer = TraderSerializer(data=data)
        print(serializer)

        if serializer.is_valid():
            phone_reference = PhoneOTP.objects.filter(
                phone_number__iexact=str(phone_number)
            ).order_by("-timestamp")
            if not phone_reference:
                errors = {"message": "You must verify your phone number first"}
                return Response(errors, status=status.HTTP_403_FORBIDDEN)
            else:
                phone_reference = phone_reference[0]
                if phone_reference.validated == True:
                    try:
                        user = User.objects.get(phone_number=phone_number)
                        return Response(
                            {"message": ["User already exists"]},
                            status=status.HTTP_409_CONFLICT,
                        )
                    except User.DoesNotExist:
                        serializer.save()
                        phone_reference.delete()
                        success = {"success_message": ["User has been created"]}
                        return Response(success, status=status.HTTP_201_CREATED)
                else:
                    errors = {"message": ["Verify your phone number first"]}
                    return Response(errors, status=status.HTTP_403_FORBIDDEN)
        else:
            return Response(serializer.errors, status=status.HTTP_406_NOT_ACCEPTABLE)


class FarmerRegisterView(APIView):
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(manual_parameters=[phone_number, password])
    def post(self, request, *args, **kwargs):
        phone_number = request.data.get("phone_number")
        password = request.data.get("password")
        data = {"phone_number": phone_number, "password": password}

        serializer = FarmerSerializer(data=data)
        print(serializer)

        if serializer.is_valid():
            phone_reference = PhoneOTP.objects.filter(
                phone_number__iexact=str(phone_number)
            ).order_by("-timestamp")
            if not phone_reference:
                errors = {"message": "You must verify your phone number first"}
                return Response(errors, status=status.HTTP_403_FORBIDDEN)
            else:
                phone_reference = phone_reference[0]
                if phone_reference.validated == True:
                    try:
                        user = User.objects.get(phone_number=phone_number)
                        return Response(
                            {"message": ["User already exists"]},
                            status=status.HTTP_409_CONFLICT,
                        )
                    except User.DoesNotExist:
                        serializer.save()
                        phone_reference.delete()
                        success = {"success_message": ["User has been created"]}
                        return Response(success, status=status.HTTP_201_CREATED)
                else:
                    errors = {"message": ["Verify your phone number first"]}
                    return Response(errors, status=status.HTTP_403_FORBIDDEN)
        else:
            return Response(serializer.errors, status=status.HTTP_406_NOT_ACCEPTABLE)


class UserLoginView(APIView):
    serializer_class = UserLoginSerializer
    permission_classes = [
        AllowAny,
    ]

    @swagger_auto_schema(manual_parameters=[phone_number, password])
    def post(self, request):
        phone_number = request.data.get("phone_number")
        password = request.data.get("password")
        data = {"phone_number": phone_number, "password": password}

        serializer = UserLoginSerializer(data=data)
        if not serializer.is_valid():
            token = serializer.validate(attrs=data)
            if not token:
                return Response(
                    {"message": ["Please check your password"]},
                    status=status.HTTP_401_UNAUTHORIZED,
                )
            else:
                return Response({"token": token}, status=status.HTTP_200_OK)
        else:
            return Response(
                {"message": ["Register first"]}, status=status.HTTP_404_NOT_FOUND
            )


class UserLogoutView(APIView):
    permission_classes = [
        IsAuthenticated,
    ]

    def post(self, request, format=None):
        if request.user.auth_token.delete():
            return Response({"message": ["User logged out"]}, status=status.HTTP_200_OK)
        else:
            return Response(
                {"message": ["Auth credentials not found"]},
                status=status.HTTP_404_NOT_FOUND,
            )

