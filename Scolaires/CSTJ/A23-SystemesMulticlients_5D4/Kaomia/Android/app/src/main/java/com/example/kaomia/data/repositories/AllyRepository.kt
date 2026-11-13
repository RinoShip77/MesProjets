package com.example.kaomia.data.repositories

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import com.example.kaomia.core.ApiResult
import com.example.kaomia.core.Constants
import com.example.kaomia.data.datasources.AllyDataSource
import com.example.kaomia.models.Ally
import com.example.kaomia.models.LoginResponse
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.flowOn

class AllyRepository {
    private val allyDataSource = AllyDataSource()

    fun retrieveAll(explorerData: LoginResponse) : Flow<ApiResult<List<Ally>>> {
        return flow {
            while(true) {
                try {
                    emit(ApiResult.Loading)
                    val allies = allyDataSource.retrieveAll(explorerData)
                    emit(ApiResult.Success(allies))
                } catch (ex: Exception) {
                    emit(ApiResult.Error(ex))
                }
                delay(Constants.RefreshDelay.ALLIES_REFRESH_DELAY)
            }
        }.flowOn(Dispatchers.IO)
    }

    fun retrieveOne(href: String, accessToken: String): Flow<ApiResult<Ally>> {
        return flow {
            try{
                emit(ApiResult.Loading)
                //TODO: Add the url parameter to get one
                val ally = allyDataSource.retrieveOne(href, accessToken)
                emit(ApiResult.Success(ally))
            } catch (ex: Exception) {
                emit(ApiResult.Error(ex))
            }
        }.flowOn(Dispatchers.IO)
    }
}