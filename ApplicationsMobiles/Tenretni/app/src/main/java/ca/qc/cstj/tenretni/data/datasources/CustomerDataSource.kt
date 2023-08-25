package ca.qc.cstj.tenretni.data.datasources

import ca.qc.cstj.tenretni.domain.models.Customer
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.json.responseJson
import com.github.kittinunf.result.Result
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json

class CustomerDataSource {
    private val json = Json { ignoreUnknownKeys = true }

    suspend fun retrieveOne(href :String) : Customer {
        return withContext(Dispatchers.IO) {
            val (_, _, result) = href.httpGet().responseJson()

            when(result) {
                // Code dans la famille 200
                is Result.Success -> {
                    return@withContext json.decodeFromString(result.value.content)
                }
                // Code dans les familles 400 ou 500
                is Result.Failure -> {
                    throw result.error.exception
                }
            }
        }
    }
}