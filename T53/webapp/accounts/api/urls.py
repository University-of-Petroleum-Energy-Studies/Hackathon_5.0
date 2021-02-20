from django.urls import include, path
from .views import (
    TraderRegisterView,
    FarmerRegisterView,
    UserLoginView,
    UserLogoutView,
    ValidateOTP,
    ValidatePhoneNumberSendOTP,
)

urlpatterns = [
    path("send/otp/", ValidatePhoneNumberSendOTP.as_view(), name="send_otp"),
    path("verify/otp/", ValidateOTP.as_view(), name="verify_otp"),
    path(
        "register/users/traders/",
        TraderRegisterView.as_view(),
        name="register_traders",
    ),
    path(
        "register/users/farmers/", FarmerRegisterView.as_view(), name="register_farmers"
    ),
    path("login/", UserLoginView.as_view(), name="user_login"),
    path("logout/", UserLogoutView.as_view(), name="user_logout"),
]



