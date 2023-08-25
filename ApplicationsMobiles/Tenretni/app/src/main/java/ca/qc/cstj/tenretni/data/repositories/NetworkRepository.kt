package ca.qc.cstj.tenretni.data.repositories

import ca.qc.cstj.tenretni.data.datasources.NetworkDataSource
import ca.qc.cstj.tenretni.domain.models.Network
import ca.qc.cstj.tenretni.helpers.Resource

class NetworkRepository {
    private val networkDataSource = NetworkDataSource()

    suspend fun retrieve() : Resource<Network> {
        return try {
            Resource.Success(networkDataSource.retrieve())
        } catch (ex:Exception) {
            Resource.Error(ex, ex.message)
        }
    }
}