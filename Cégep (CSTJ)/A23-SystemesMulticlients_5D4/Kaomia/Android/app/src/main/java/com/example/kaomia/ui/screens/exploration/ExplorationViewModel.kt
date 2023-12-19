package com.example.kaomia.ui.screens.exploration

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.kaomia.core.ApiResult
import com.example.kaomia.data.repositories.ExplorationRepository
import com.example.kaomia.models.LoginResponse
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class ExplorationViewModel : ViewModel() {

    private val _explorationUIState = MutableStateFlow<ExplorationUIState>(ExplorationUIState.Loading)
    val explorationUIState : StateFlow<ExplorationUIState> = _explorationUIState.asStateFlow()
    private val _explorationRepository = ExplorationRepository()

    fun makeExploration(loginResponse: LoginResponse, key: String) {
        viewModelScope.launch {
            _explorationRepository.makeExploration(loginResponse, key).collect {
                _explorationUIState.update { _ ->
                    when (it) {
                        is ApiResult.Error -> ExplorationUIState.Error(IllegalStateException(it.throwable))
                        ApiResult.Loading -> ExplorationUIState.Loading
                        is ApiResult.Success -> ExplorationUIState.Success(it.data)
                    }
                }
            }
        }
    }
}