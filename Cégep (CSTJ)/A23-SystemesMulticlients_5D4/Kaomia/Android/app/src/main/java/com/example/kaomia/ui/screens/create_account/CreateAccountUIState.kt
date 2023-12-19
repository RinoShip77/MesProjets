package com.example.kaomia.ui.screens.create_account

import com.example.kaomia.models.LoginResponse
import java.lang.Exception

sealed class CreateAccountUIState {
    class Success(val loginResponse: LoginResponse) : CreateAccountUIState()
    object Loading: CreateAccountUIState()
    class Error(val exception: Exception): CreateAccountUIState()
}
