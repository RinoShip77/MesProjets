package com.example.kaomia.data.datasources

import com.example.kaomia.models.Ally
import com.example.kaomia.models.LoginResponse
import com.github.kittinunf.result.Result
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.json.responseJson
import io.ktor.http.HttpHeaders

class AllyDataSource {
    private val json = Json { ignoreUnknownKeys = true }

    fun retrieveOne(href: String, accessToken: String): Ally {
        val (_, _, result) = href.httpGet()
            .header(HttpHeaders.Authorization, "Bearer $accessToken")
            .responseJson()

        when (result) {
            is Result.Success -> return json.decodeFromString(result.value.content)
            is Result.Failure -> throw result.error.exception
        }
    }

    fun retrieveAll(explorerData: LoginResponse): List<Ally> {
        val url = "${explorerData.explorer.href}/allies"
        val (_, _, result) = url.httpGet()
            .header(HttpHeaders.Authorization, "Bearer ${explorerData.tokens.accessToken}")
            .responseJson()

        when (result) {
            is Result.Success -> return json.decodeFromString(result.value.content)
            is Result.Failure -> throw result.error.exception
        }
    }
}