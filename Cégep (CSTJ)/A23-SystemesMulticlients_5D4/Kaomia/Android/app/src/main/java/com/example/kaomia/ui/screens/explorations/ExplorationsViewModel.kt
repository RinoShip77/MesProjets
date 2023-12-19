package com.example.kaomia.ui.screens.explorations

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

class ExplorationsViewModel : ViewModel(){
private val _explorationRepository = ExplorationRepository()
private val _explorationUiState = MutableStateFlow<ExplorationsUiState>(ExplorationsUiState.Loading)
    val explorationsUiState: StateFlow<ExplorationsUiState> = _explorationUiState.asStateFlow()

    fun retrieveAllExploration(explorerData: LoginResponse) {
      viewModelScope.launch {
          _explorationRepository.retrieveAll(explorerData).collect{apiResult->
              _explorationUiState.update {
                  when(apiResult){
                      is ApiResult.Error-> ExplorationsUiState.Error(IllegalStateException(apiResult.throwable))
                      ApiResult.Loading-> ExplorationsUiState.Loading
                      is ApiResult.Success-> ExplorationsUiState.Success(apiResult.data)
                  }
              }
          }
      }
    }



}