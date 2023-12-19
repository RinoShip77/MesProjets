package com.example.kaomia.ui.screens.exploration

import com.example.kaomia.models.Exploration

sealed class ExplorationUIState {
    class Success(val exploration: Exploration) : ExplorationUIState()
    object Loading: ExplorationUIState()
    class Error(val exception: Exception): ExplorationUIState()
}