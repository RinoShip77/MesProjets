package ca.qc.cstj.consortium.domain.models

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "deliveries")
data class Delivery(
    //Défini les colonnes pour la base de données (Room)
    @ColumnInfo(name = "vethyx") val vethyx: Float,
    @ColumnInfo(name = "lukryx") val lukryx: Float,
    @ColumnInfo(name = "smiathil") val smiathil: Float,
    @ColumnInfo(name = "bilerium") val bilerium: Float,
    @ColumnInfo(name = "gloylium") val gloylium: Float
    ) {
    @PrimaryKey(autoGenerate = true)
    var idDelivery: Int = 0
}