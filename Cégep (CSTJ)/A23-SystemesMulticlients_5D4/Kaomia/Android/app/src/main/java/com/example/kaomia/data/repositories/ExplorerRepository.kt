package com.example.kaomia.data.repositories

import com.example.kaomia.core.ApiResult
import com.example.kaomia.core.Constants
import com.example.kaomia.data.datasources.ExplorerDataSource
import com.example.kaomia.models.Explorer
import com.example.kaomia.models.LoginResponse
import com.example.kaomia.models.Tokens
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn

class ExplorerRepository {
    private val explorerDataSource = ExplorerDataSource()

    fun login(username: String, password: String): Flow<ApiResult<LoginResponse>> {
        return flow {
            try{
                emit(ApiResult.Loading)
                emit(ApiResult.Success(explorerDataSource.login(username, password)))
            } catch (ex: Exception) {
                emit(ApiResult.Error(ex))
            }
        }.flowOn(Dispatchers.IO)
    }

    fun logout(tokens: Tokens): Flow<ApiResult<Unit>> {
        return flow {
            try{
                emit(ApiResult.Loading)
                emit(ApiResult.Success(explorerDataSource.logout(tokens)))
            } catch (ex: Exception) {
                emit(ApiResult.Error(ex))
            }
        }.flowOn(Dispatchers.IO)
    }

    fun retrieveExplorer(tokens: Tokens, href: String): Flow<ApiResult<Explorer>> {
        return flow {
            while (true) {
                try{
                    emit(ApiResult.Loading)
                    emit(ApiResult.Success(explorerDataSource.retrieveExplorer(tokens, href)))
                } catch (ex: Exception) {
                    emit(ApiResult.Error(ex))
                }
                delay(Constants.RefreshDelay.PROFILE_REFRESH_DELAY)
            }
        }.flowOn(Dispatchers.IO)
    }

    fun createAccount(
        username: String, email: String, name: String, surname: String, password: String
    ): Flow<ApiResult<LoginResponse>> {
        return flow {
            try{
                emit(ApiResult.Loading)
                emit(ApiResult.Success(explorerDataSource.createAccount(
                    username, email, name, surname, password
                )))
            } catch (ex: Exception) {
                emit(ApiResult.Error(ex))
            }
        }.flowOn(Dispatchers.IO)
    }
}