package com.example.kaomia.ui.screens.profile

sealed class LogoutUIState {
    object Success : LogoutUIState()
    object Loading: LogoutUIState()
    class Error(val exception: Exception): LogoutUIState()
}