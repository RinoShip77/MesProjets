package com.example.kaomia.ui.screens.create_account

import android.content.Context
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.kaomia.core.ApiResult
import com.example.kaomia.core.Constants
import com.example.kaomia.core.Tools
import com.example.kaomia.data.repositories.ExplorerRepository
import com.example.kaomia.models.LoginResponse
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class CreateAccountViewModel : ViewModel() {
    private val _createAccountUiState = MutableStateFlow<CreateAccountUIState>(
        CreateAccountUIState.Loading
    )
    val createAccountUIState: StateFlow<CreateAccountUIState> = _createAccountUiState.asStateFlow()
    private val _explorerRepository = ExplorerRepository()

    fun createAccount(username: String, email: String, name: String, surname: String, password: String, context: Context) {
        viewModelScope.launch {
            _explorerRepository.createAccount(username, email, name, surname, password).collect {
                _createAccountUiState.update { _ ->
                    when (it) {
                        is ApiResult.Error -> CreateAccountUIState.Error(
                            IllegalStateException(it.throwable)
                        )
                        ApiResult.Loading -> CreateAccountUIState.Loading
                        is ApiResult.Success -> {
                            Tools.saveExplorerData(context, it.data)
                            CreateAccountUIState.Success(it.data)
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