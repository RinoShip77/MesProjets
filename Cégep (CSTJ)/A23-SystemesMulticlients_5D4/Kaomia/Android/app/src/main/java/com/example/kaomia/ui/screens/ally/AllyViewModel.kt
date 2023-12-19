package com.example.kaomia.ui.screens.ally

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.kaomia.core.ApiResult
import com.example.kaomia.data.repositories.AllyRepository
import com.example.kaomia.models.LoginResponse
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class AllyViewModel : ViewModel() {

    private val _allyUiState = MutableStateFlow<AllyUIState>(AllyUIState.Loading)
    val allyUIState : StateFlow<AllyUIState> = _allyUiState.asStateFlow()

    private val _allyRepository = AllyRepository()

    fun retrieveOneAlly(href: String, accessToken: String) {
        viewModelScope.launch {
            _allyRepository.retrieveOne(href, accessToken).collect {
                _allyUiState.update { _ ->
                    when (it) {
                        is ApiResult.Error -> AllyUIState.Error(IllegalStateException(it.throwable))
                        ApiResult.Loading -> AllyUIState.Loading
                        is ApiResult.Success -> AllyUIState.Success(it.data)
                    }
                }
            }
        }
    }
}