package ca.qc.cstj.tenretni.data.datasources

import ca.qc.cstj.tenretni.domain.models.*
import ca.qc.cstj.tenretni.helpers.Constants
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.httpPost
import com.github.kittinunf.fuel.json.responseJson
import com.github.kittinunf.result.Result
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json

class GatewayDataSource {
    private val json = Json { ignoreUnknownKeys = true }

    suspend fun retrieveAll(): List<Gateway> {
        return withContext(Dispatchers.IO) {
            val (req, res, result) = Constants.BaseURL.GATEWAYS.httpGet().responseJson()

            when (result) {
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

    suspend fun retrieveFromTicket(ticket: String): List<Gateway> {
        return withContext(Dispatchers.IO) {
            var searchURL = "$ticket/gateways"
            val (_, _, result) = searchURL.httpGet().responseJson()

            when (result) {
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

    suspend fun retrieveOne(href: String): Gateway {
        return withContext(Dispatchers.IO) {
            val (_, _, result) = href.httpGet().responseJson()

            when (result) {
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

    suspend fun gatewayUpdate(gatewaySerialNumber: String): Gateway {
        return withContext(Dispatchers.IO) {
            val string = Constants.BaseURL.GATEWAYS + "/$gatewaySerialNumber/actions?type=update"
            val (_, _, result) = string.httpPost().responseJson()

            //Gérer la réponse
            when (result) {
                is Result.Success -> {
                    return@withContext Json.decodeFromString<Gateway>(result.value.content)
                }
                is Result.Failure -> {
                    throw result.error.exception
                }
            }
        }
    }

    suspend fun gatewayReboot(gatewaySerialNumber: String): Gateway {
        return withContext(Dispatchers.IO) {
            val string = Constants.BaseURL.GATEWAYS + "/$gatewaySerialNumber/actions?type=reboot"
            val (_, _, result) = string.httpPost().responseJson()

            //Gérer la réponse
            when (result) {
                is Result.Success -> {
                    return@withContext Json.decodeFromString<Gateway>(result.value.content)
                }
                is Result.Failure -> {
                    throw result.error.exception
                }
            }
        }
    }
}