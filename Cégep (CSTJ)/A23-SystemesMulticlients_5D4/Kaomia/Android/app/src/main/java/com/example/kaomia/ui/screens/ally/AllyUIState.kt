package com.example.kaomia.ui.screens.ally

import com.example.kaomia.models.Ally

sealed class AllyUIState {
    class Success(val ally: Ally) : AllyUIState()
    object Loading: AllyUIState()
    class Error(val exception: Exception): AllyUIState()
}