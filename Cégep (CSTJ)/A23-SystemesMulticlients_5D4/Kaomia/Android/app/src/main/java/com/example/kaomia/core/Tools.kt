package com.example.kaomia.core

import android.annotation.SuppressLint
import android.content.Context
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.Text
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.preferencesDataStore
import com.example.kaomia.R
import com.example.kaomia.models.Ally
import com.example.kaomia.models.BonusChest
import com.example.kaomia.models.Crypto
import com.example.kaomia.models.Element
import com.example.kaomia.models.Exploration
import com.example.kaomia.models.LoginResponse
import com.example.kaomia.models.Stats
import com.example.kaomia.models.Vault
import com.example.kaomia.ui.theme.OffWhite
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import java.text.SimpleDateFormat
import java.util.Date
import kotlin.random.Random

object Tools {
    private val Context.dataStore : DataStore<Preferences> by preferencesDataStore(name = "explorer-data")

    suspend fun saveExplorerData(context: Context, loginResponse: LoginResponse?) {
        val serializedLoginResponse = loginResponse?.let { Json.encodeToString(it) }
        context.dataStore.edit { preferences ->
            preferences[Constants.EXPLORER_DATA_KEY] = serializedLoginResponse ?: "" }
    }

    fun getExplorerData(context: Context): Flow<LoginResponse?> {
        return context.dataStore.data.map { preferences ->
            val serializedLoginResponse = preferences[Constants.EXPLORER_DATA_KEY]
            if (!serializedLoginResponse.isNullOrBlank()) {
                Json.decodeFromString(serializedLoginResponse)
            } else {
                null
            }
        }
    }

    @SuppressLint("SimpleDateFormat")
    fun parseDate(originalDate: Date): String {
        val targetDateFormat = SimpleDateFormat("yyyy-MM-dd")
        return targetDateFormat.format(originalDate)
    }

    @SuppressLint("SimpleDateFormat")
    fun parseDateWithTime(originalDate: Date): String {
        val targetDateFormat = SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        return targetDateFormat.format(originalDate)
    }

    @Composable
    fun CardTitle(title: String) {
        Text(
            modifier = Modifier
                .background(Color.DarkGray)
                .fillMaxWidth()
                .padding(8.dp),
            text = title,
            fontSize = 28.sp,
            fontWeight = FontWeight.Bold,
            textAlign = TextAlign.Center,
            color = Color.White
        )
    }

    @Composable
    fun BackgroundImage() {
        Image(
            painter = painterResource(id = R.drawable.wallpaper),
            contentDescription = null,
            contentScale = ContentScale.FillBounds,
            modifier = Modifier
                .fillMaxSize()
                .size(160.dp)
                .background(
                    color = Color.White,
                    shape = CircleShape
                )
        )
    }

    @Composable
    fun DisplayInoxCount(inox: Int) {

        Row(modifier = Modifier,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Image(
                painter = painterResource(id = R.drawable.inox),
                contentDescription = null,
                modifier = Modifier
                    .size(60.dp),
                alignment = Alignment.Center
            )
            Text(text = "Inox: $inox",
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold)
        }
    }

    fun getKernelElementDrawable(element: String): Int {
        return when (element.lowercase()) {
            "a" ->  R.drawable.element_a
            "b" ->  R.drawable.element_b
            "e" ->  R.drawable.element_e
            "ex" ->  R.drawable.element_ex
            "fr" ->  R.drawable.element_fr
            "g" ->  R.drawable.element_g
            "i" ->  R.drawable.element_i
            "ja" ->  R.drawable.element_ja
            "k" ->  R.drawable.element_k
            "l" ->  R.drawable.element_l
            "no" ->  R.drawable.element_no
            "q" ->  R.drawable.element_q
            "sm" ->  R.drawable.element_sm
            "ve" ->  R.drawable.element_ve
            "wu" ->  R.drawable.element_wu
            "xu" ->  R.drawable.element_xu
            "ye" ->  R.drawable.element_ye
            else ->  R.drawable.element_z
        }
    }

    fun getAllyBook(book: String): Int {
        return when (book.lowercase()) {
            "black" -> R.drawable.book_black
            "blue" -> R.drawable.book_blue
            "green" -> R.drawable.book_green
            "pink" -> R.drawable.book_pink
            "purple" -> R.drawable.book_purple
            "red" -> R.drawable.book_red
            "white" -> R.drawable.book_white
            else -> R.drawable.book_yellow
        }
    }

    fun getAffinity(element: String): Int {
        return when (element.lowercase()) {
            "air" -> R.drawable.affinity_air
            "darkness" -> R.drawable.affinity_darkness
            "earth" -> R.drawable.affinity_earth
            "energy" -> R.drawable.affinity_energy
            "fire" -> R.drawable.affinity_fire
            "life" -> R.drawable.affinity_life
            "light" -> R.drawable.affinity_light
            "logic" -> R.drawable.affinity_logic
            "music" -> R.drawable.affinity_music
            "space" -> R.drawable.affinity_space
            "toxic" -> R.drawable.affinity_toxic
            else -> R.drawable.affinity_water
        }
    }
}