package com.example.kaomia.ui.screens.profile

import com.example.kaomia.models.Explorer

sealed class ProfileUIState {
    class Success(val explorer: Explorer) : ProfileUIState()
    object Loading: ProfileUIState()
    class Error(val exception: Exception): ProfileUIState()
}