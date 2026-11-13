package com.example.kaomia.ui.screens.exploration_content

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.kaomia.core.ApiResult
import com.example.kaomia.data.repositories.ExplorationRepository
import com.example.kaomia.models.LoginResponse
import com.example.kaomia.models.Tokens
import com.example.kaomia.ui.screens.exploration.ExplorationUIState
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class CaptureAllyViewModel : ViewModel() {

    private val _captureAllyUIState =
        MutableStateFlow<CaptureAllyUIState>(CaptureAllyUIState.Loading)
    val captureAllyUIState: StateFlow<CaptureAllyUIState> = _captureAllyUIState.asStateFlow()
    private val _explorationRepository = ExplorationRepository()

    fun captureAlly(tokens: Tokens, href: String) {
        viewModelScope.launch {
            _explorationRepository.captureAlly(tokens, href).collect {
                _captureAllyUIState.update { _ ->
                    when (it) {
                        is ApiResult.Error -> CaptureAllyUIState.Error(IllegalStateException(it.throwable))
                        ApiResult.Loading -> CaptureAllyUIState.Loading
                        is ApiResult.Success -> CaptureAllyUIState.Success
                    }
                }
            }
        }
    }
}