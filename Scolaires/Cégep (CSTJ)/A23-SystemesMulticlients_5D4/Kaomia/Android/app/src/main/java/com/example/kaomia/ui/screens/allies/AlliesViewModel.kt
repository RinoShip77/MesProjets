package com.example.kaomia.ui.screens.allies

import android.content.Context
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.platform.LocalContext
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.kaomia.core.ApiResult
import com.example.kaomia.core.Constants
import com.example.kaomia.data.repositories.AllyRepository
import com.example.kaomia.models.LoginResponse
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class AlliesViewModel : ViewModel() {

    private val _alliesUiState = MutableStateFlow<AlliesUIState>(AlliesUIState.Loading)
    val alliesUIState : StateFlow<AlliesUIState> = _alliesUiState.asStateFlow()

    private val _allyRepository = AllyRepository()

    fun retrieveAllAllies(explorerData: LoginResponse) {
        viewModelScope.launch {
            _allyRepository.retrieveAll(explorerData).collect {
                _alliesUiState.update { _ ->
                    when (it) {
                        is ApiResult.Error -> AlliesUIState.Error(IllegalStateException(it.throwable))
                        ApiResult.Loading -> AlliesUIState.Loading
                        is ApiResult.Success -> AlliesUIState.Success(it.data)
                    }
                }
            }
        }
    }
}