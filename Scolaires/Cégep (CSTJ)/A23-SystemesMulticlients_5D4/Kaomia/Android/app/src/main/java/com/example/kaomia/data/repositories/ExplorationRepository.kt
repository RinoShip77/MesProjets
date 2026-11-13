package com.example.kaomia.data.repositories

import com.example.kaomia.core.ApiResult
import com.example.kaomia.core.Constants
import com.example.kaomia.data.datasources.ExplorationDataSource
import com.example.kaomia.models.Exploration
import com.example.kaomia.models.LoginResponse
import com.example.kaomia.models.Tokens
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn

class ExplorationRepository {
    private val explorationDataSource = ExplorationDataSource()

    fun retrieveAll(explorerData: LoginResponse) : Flow<ApiResult<List<Exploration>>> {
        return flow {
            while(true) {
                emit(ApiResult.Loading)
                try {
                    val explorations = explorationDataSource.retrieveAll(explorerData)
                    emit(ApiResult.Success(explorations))
                } catch (ex:Exception) {
                    emit(ApiResult.Error(ex))
                }
                delay(Constants.RefreshDelay.ALLIES_REFRESH_DELAY)
            }
        }.flowOn(Dispatchers.IO)
    }

    fun makeExploration(explorerData: LoginResponse, key: String): Flow<ApiResult<Exploration>> {
        return flow {
            try{
                emit(ApiResult.Loading)
                emit(ApiResult.Success(explorationDataSource.makeExploration(explorerData, key)))
            } catch (ex: Exception) {
                emit(ApiResult.Error(ex))
            }
        }.flowOn(Dispatchers.IO)
    }

    fun captureAlly(tokens: Tokens, href: String): Flow<ApiResult<Unit>> {
        return flow {
            try{
                emit(ApiResult.Loading)
                val ally = explorationDataSource.captureAlly(tokens, href)
                emit(ApiResult.Success(ally))
            } catch (ex: Exception) {
                emit(ApiResult.Error(ex))
            }
        }.flowOn(Dispatchers.IO)
    }
}