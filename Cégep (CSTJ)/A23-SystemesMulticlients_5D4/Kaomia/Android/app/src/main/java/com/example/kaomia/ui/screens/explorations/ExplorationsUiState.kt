package com.example.kaomia.ui.screens.explorations

import com.example.kaomia.models.Exploration
import java.lang.Exception

sealed class ExplorationsUiState {
    class Success(val explorations: List<Exploration>) : ExplorationsUiState()
    object Loading : ExplorationsUiState()
    class Error(val exception: Exception): ExplorationsUiState()
}