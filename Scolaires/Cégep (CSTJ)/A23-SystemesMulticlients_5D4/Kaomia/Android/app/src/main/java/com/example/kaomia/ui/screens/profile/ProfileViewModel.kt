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

class ProfileViewModel : ViewModel() {
    private val _profileUiState = MutableStateFlow<ProfileUIState>(ProfileUIState.Loading)
    val profileUIState : StateFlow<ProfileUIState> = _profileUiState.asStateFlow()
    private val _explorerRepository = ExplorerRepository()

    fun retrieveExplorer(tokens: Tokens, href: String) {
        viewModelScope.launch {
            _explorerRepository.retrieveExplorer(tokens, href).collect {
                _profileUiState.update { _ ->
                    when (it) {
                        is ApiResult.Error -> ProfileUIState.Error(IllegalStateException(it.throwable))
                        ApiResult.Loading -> ProfileUIState.Loading
                        is ApiResult.Success -> ProfileUIState.Success(it.data)
                    }
                }
            }
        }
    }
}