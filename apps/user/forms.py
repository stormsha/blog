from django import forms
from .models import Ouser


class UserForm(forms.Form):
    username = forms.CharField(min_length=2, max_length=30)
    password = forms.CharField(min_length=6, max_length=50)
    password2 = forms.CharField(min_length=6, max_length=50)
    email = forms.CharField(max_length=50)


class loginForm(forms.Form):
    username = forms.CharField(max_length=30)
    password = forms.CharField(max_length=50)


class ProfileForm(forms.ModelForm):
    class Meta:
        model = Ouser
        fields = ['link', 'avatar']
