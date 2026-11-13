package com.example.kaomia.ui.screens.profile

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.kaomia.core.ApiResult
import com.example.kaomia.data.repositories.ExplorerRepository
import com.example.kaomia.models.Tokens
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class LogoutViewModel : ViewModel() {
    private val _logoutUiState = MutableStateFlow<LogoutUIState>(LogoutUIState.Loading)
    val logoutUIState : StateFlow<LogoutUIState> = _logoutUiState.asStateFlow()
    private val _explorerRepository = ExplorerRepository()

    fun logoutExplorer(tokens: Tokens) {
        viewModelScope.launch {
            _explorerRepository.logout(tokens).collect {
                _logoutUiState.update { _ ->
                    when (it) {
                        is ApiResult.Error -> LogoutUIState.Error(IllegalStateException(it.throwable))
                        ApiResult.Loading -> LogoutUIState.Loading
                        is ApiResult.Success -> LogoutUIState.Success
                    }
                }
            }
        }
    }
}