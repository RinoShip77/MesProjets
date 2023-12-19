package com.example.kaomia.ui.screens.allies

import com.example.kaomia.models.Ally

sealed class AlliesUIState {
    class Success(val allies: List<Ally>) : AlliesUIState()
    object Loading: AlliesUIState()
    class Error(val exception: Exception): AlliesUIState()
}