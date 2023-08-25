package ca.qc.cstj.consortium.data.repositories

import android.content.Context
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.floatPreferencesKey
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import ca.qc.cstj.consortium.domain.models.Trader
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

val Context.dataStore by preferencesDataStore("consortium.trader")

class TraderRepository(private val context: Context) {
    //On configure la sauvegarde de données sur le téléphone (DataStore)
    object PreferencesKey {
        //Comment vont s'appeler les données de l'utilisateur
        val NAME = stringPreferencesKey("name")
        val VETHYX = floatPreferencesKey("vethyx")
        val LUKRYX = floatPreferencesKey("lukryx")
        val SMIATHIL = floatPreferencesKey("smiathil")
        val BILERIUM = floatPreferencesKey("bilerium")
        val GLOYLIUM = floatPreferencesKey("gloylium")
    }

    val trader: Flow<Trader> = context.dataStore.data.map {
        //On déclare des valeurs par défaut
        val name = it[PreferencesKey.NAME] ?: ""
        val vethyx = it[PreferencesKey.VETHYX] ?: 323.00f
        val lukryx = it[PreferencesKey.LUKRYX] ?: 353.00f
        val smiathil = it[PreferencesKey.SMIATHIL] ?: 379.00f
        val bilerium = it[PreferencesKey.BILERIUM] ?: 386.00f
        val gloylium = it[PreferencesKey.GLOYLIUM] ?: 357.00f

        Trader(name, vethyx, lukryx, smiathil, bilerium, gloylium)
    }

    suspend fun save(name: String, vethyx: Float, lukryx: Float, smiathil: Float, bilerium: Float, gloylium: Float) {
        //On écrit dans le fichier de configurations pour sauvegarder les données de l'utilisateur
        context.dataStore.edit { preferences ->
            preferences[PreferencesKey.NAME] = name
            preferences[PreferencesKey.VETHYX] = vethyx
            preferences[PreferencesKey.LUKRYX] = lukryx
            preferences[PreferencesKey.SMIATHIL] = smiathil
            preferences[PreferencesKey.BILERIUM] = bilerium
            preferences[PreferencesKey.GLOYLIUM] = gloylium
        }
    }
}