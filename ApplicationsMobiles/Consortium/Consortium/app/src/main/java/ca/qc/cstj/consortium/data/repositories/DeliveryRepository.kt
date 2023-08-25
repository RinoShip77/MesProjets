package ca.qc.cstj.consortium.data.repositories

import androidx.room.*
import ca.qc.cstj.consortium.domain.models.Delivery
import kotlinx.coroutines.flow.Flow

@Dao
interface DeliveryRepository {
    //Défini les méthodes à utiliser avec la base de données de livraisons
    @Query("SELECT * FROM deliveries")
    fun retrieveAll(): Flow<List<Delivery>>

    @Insert
    fun insert(deliveries: List<Delivery>)

    @Insert
    suspend fun create(delivery: Delivery)

    @Query("DELETE FROM deliveries")
    suspend fun deleteAll()
}