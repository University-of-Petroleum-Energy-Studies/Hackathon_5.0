from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.contrib.auth.models import Group

from accounts.forms import UserAdminChangeForm, UserAdminCreationForm
from accounts.models import PhoneOTP, User, UserLoginActivity


class UserAdmin(BaseUserAdmin):
    """
        UerAdmin
    """

    add_form = UserAdminCreationForm
    form = UserAdminChangeForm
    list_display = ("phone_number",)
    list_filter = ("is_active",)
    fieldsets = (
        (None, {"fields": ("phone_number", "password")}),
        (
            "Permissions",
            {"fields": ("is_superuser", "is_active", "is_staff", "groups",)},
        ),
    )

    add_fieldsets = (
        (
            None,
            {
                "classes": ("wide",),
                "fields": ("phone_number", "password1", "password2"),
            },
        ),
    )
    search_fields = ["phone_number"]
    ordering = ("phone_number",)
    filter_horizontal = ()


# admin.site.unregister(User)
admin.site.register(User, UserAdmin)
admin.site.register(PhoneOTP)
# admin.site.register(CarOwnerProfile)
admin.site.register(UserLoginActivity)


# Remove Group Model from admin. We're not using it.
# admin.site.unregister(Group)
