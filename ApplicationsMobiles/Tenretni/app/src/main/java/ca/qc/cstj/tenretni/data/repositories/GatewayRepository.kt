package ca.qc.cstj.tenretni.data.repositories

import ca.qc.cstj.tenretni.data.datasources.GatewayDataSource
import ca.qc.cstj.tenretni.domain.models.Gateway
import ca.qc.cstj.tenretni.helpers.Constants
import ca.qc.cstj.tenretni.helpers.LoadingResource
import ca.qc.cstj.tenretni.helpers.Resource
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

class GatewayRepository {
    private val gatewayDataSource = GatewayDataSource()

    suspend fun retrieveAll(): Flow<LoadingResource<List<Gateway>>> {
        return flow {
            while (true) {
                try {
                    emit(LoadingResource.Loading())
                    emit(LoadingResource.Success(gatewayDataSource.retrieveAll()))
                } catch (ex: Exception) {
                    emit(LoadingResource.Error(ex, ex.message))
                }
                delay(Constants.GATEWAYS_REFRESH_DELAY)
            }
        }
    }

    suspend fun retrieveFromTicket(ticket: String): Flow<Resource<List<Gateway>>> {
        return flow {
            while (true) {
                try {
                    emit(Resource.Success(gatewayDataSource.retrieveFromTicket(ticket)))
                } catch (ex: Exception) {
                    emit(Resource.Error(ex, ex.message))
                }
                delay(Constants.TICKETS_REFRESH_DELAY)
            }
        }
    }

    suspend fun retrieveOne(href: String): Resource<Gateway> {
        return try {
            Resource.Success(gatewayDataSource.retrieveOne(href))
        } catch (ex: Exception) {
            Resource.Error(ex, ex.message)
        }
    }

    suspend fun update(SerialNumber: String): Resource<Gateway> {
        return try {
            Resource.Success(gatewayDataSource.gatewayUpdate(SerialNumber))
        } catch (ex: Exception) {
            Resource.Error(ex, ex.message)
        }
    }

    suspend fun reboot(SerialNumber: String): Resource<Gateway> {
        return try {
            Resource.Success(gatewayDataSource.gatewayReboot(SerialNumber))
        } catch (ex: Exception) {
            Resource.Error(ex, ex.message)
        }
    }
}