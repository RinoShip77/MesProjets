package com.example.kaomia.ui.screens.exploration_content

sealed class CaptureAllyUIState {
    object Success : CaptureAllyUIState()
    object Loading: CaptureAllyUIState()
    class Error(val exception: Exception): CaptureAllyUIState()
}