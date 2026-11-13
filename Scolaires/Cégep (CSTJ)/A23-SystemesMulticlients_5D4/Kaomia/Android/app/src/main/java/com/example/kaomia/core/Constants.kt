package com.example.kaomia.core

import android.content.Context
import android.util.Log
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import com.example.kaomia.models.Explorer
import com.example.kaomia.models.LoginResponse
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

object Constants {
    private const val BASE_API = "http://projetmulticlients.us-3.evennode.com"

    const val LOGIN_URL = "$BASE_API/explorers/actions/login"
    const val LOGOUT_URL = "$BASE_API/explorers/actions/logout"
    const val CREATE_ACCOUNT_URL = "$BASE_API/explorers"

    val EXPLORER_DATA_KEY = stringPreferencesKey("explorer-data")

    object RefreshDelay {
        const val ALLIES_REFRESH_DELAY = 65000L
        const val PROFILE_REFRESH_DELAY = 65000L
    }
}