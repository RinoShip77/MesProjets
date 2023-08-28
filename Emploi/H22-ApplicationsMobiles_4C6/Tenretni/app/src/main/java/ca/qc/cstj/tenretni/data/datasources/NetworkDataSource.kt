package ca.qc.cstj.tenretni.data.datasources

import ca.qc.cstj.tenretni.domain.models.Network
import ca.qc.cstj.tenretni.helpers.Constants
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.json.responseJson
import com.github.kittinunf.result.Result
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json

class NetworkDataSource {
    private val json = Json { ignoreUnknownKeys = true }

    suspend fun retrieve() : Network {
        return withContext(Dispatchers.IO) {
            val (_, _, result) = Constants.BaseURL.NETWORK.httpGet().responseJson()
            when(result) {
                is Result.Success -> {
                    return@withContext json.decodeFromString<Network>(result.value.content)
                }
                is Result.Failure -> {
                    throw result.error.exception
                }
            }
        }
    }
}