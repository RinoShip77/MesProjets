package com.example.kaomia.ui.screens.login

import com.example.kaomia.models.Explorer
import com.example.kaomia.models.LoginResponse
import java.lang.Exception

sealed class LoginUIState {
    class Success(val loginResponse: LoginResponse) : LoginUIState()
    object Loading: LoginUIState()
    class Error(val exception: Exception): LoginUIState()
}