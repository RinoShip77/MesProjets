package com.example.kaomia.ui.screens.login

import android.content.Context
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.kaomia.core.ApiResult
import com.example.kaomia.core.Tools
import com.example.kaomia.data.repositories.ExplorerRepository
import com.example.kaomia.models.LoginResponse
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class LoginViewModel : ViewModel() {
    private val _loginUiState = MutableStateFlow<LoginUIState>(LoginUIState.Loading)
    val loginUIState : StateFlow<LoginUIState> = _loginUiState.asStateFlow()
    private val _explorerRepository = ExplorerRepository()

    fun loginExplorer(username: String, password: String, context: Context) {
        viewModelScope.launch {
            _explorerRepository.login(username, password).collect {
                _loginUiState.update { _ ->
                    when (it) {
                        is ApiResult.Error -> LoginUIState.Error(IllegalStateException(it.throwable))
                        ApiResult.Loading -> LoginUIState.Loading
                        is ApiResult.Success -> {
                            Tools.saveExplorerData(context, it.data)
                            LoginUIState.Success(it.data)
                        }
                    }
                }
            }
        }
    }

    suspend fun saveExplorerToDataStore(context: Context, loginResponse: LoginResponse) {
        Tools.saveExplorerData(context, loginResponse)
    }
}
