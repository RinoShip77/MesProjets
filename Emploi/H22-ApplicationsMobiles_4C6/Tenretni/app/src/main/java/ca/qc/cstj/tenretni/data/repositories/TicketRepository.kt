package ca.qc.cstj.tenretni.data.repositories

import ca.qc.cstj.tenretni.data.datasources.TicketDataSource
import ca.qc.cstj.tenretni.domain.models.Ticket
import ca.qc.cstj.tenretni.helpers.Constants
import ca.qc.cstj.tenretni.helpers.LoadingResource
import ca.qc.cstj.tenretni.helpers.Resource
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

class TicketRepository {
    private val ticketDataSource = TicketDataSource()

    suspend fun retrieveAll(): Flow<LoadingResource<List<Ticket>>> {
        return flow {
            while (true) {
                try {
                    emit(LoadingResource.Loading())
                    emit(LoadingResource.Success(ticketDataSource.retrieveAll()))
                } catch (ex: Exception) {
                    emit(LoadingResource.Error(ex, ex.message))
                }
                delay(Constants.TICKETS_REFRESH_DELAY)
            }
        }
    }

    suspend fun retrieveOne(href: String) : Flow<Resource<Ticket>> {
        return flow {
            while (true) {
                try {
                    emit(Resource.Success(ticketDataSource.retrieveOne(href)))
                } catch (ex: Exception) {
                    emit(Resource.Error(ex, ex.message))
                }
                delay(Constants.TICKETS_REFRESH_DELAY)
            }
        }
    }

    suspend fun updateTicket(ticketId: String, targetStatus: String): Resource<Ticket> {
        return try {
            Resource.Success(ticketDataSource.update(ticketId, targetStatus))
        } catch (ex:Exception) {
            Resource.Error(ex, ex.message)
        }
    }
}