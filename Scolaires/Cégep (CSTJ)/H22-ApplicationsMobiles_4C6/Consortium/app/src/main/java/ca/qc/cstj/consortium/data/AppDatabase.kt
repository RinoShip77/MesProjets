package ca.qc.cstj.consortium.data

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.sqlite.db.SupportSQLiteDatabase
import ca.qc.cstj.consortium.data.repositories.DeliveryRepository
import ca.qc.cstj.consortium.domain.models.Delivery
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch

@Database(entities = [Delivery::class], version = 1, exportSchema = false)
abstract class AppDatabase : RoomDatabase() {
    abstract fun deliveryRepository(): DeliveryRepository

    companion object {
        @Volatile
        private var Instance: AppDatabase? = null

        fun getDatabase(context: Context) :
                AppDatabase = Instance ?: synchronized(this) {
            val instance = Room.databaseBuilder(
                context,
                AppDatabase::class.java,
                //On donne un nom à la base de données
                "deliveries_database"
            ).addCallback(object: RoomDatabase.Callback() {
                override fun onCreate(db: SupportSQLiteDatabase) {
                    super.onCreate(db)
                    val ioScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
                    ioScope.launch {
                    }
                }
            }).build()

            Instance = instance
            return instance
        }
    }
}