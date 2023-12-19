package com.example.kaomia.data.datasources

import com.github.kittinunf.result.Result
import com.example.kaomia.models.Exploration
import com.example.kaomia.models.LoginResponse
import com.example.kaomia.models.ScanRequest
import com.example.kaomia.models.Tokens
import com.github.kittinunf.fuel.core.extensions.jsonBody
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.httpPost
import com.github.kittinunf.fuel.json.responseJson
import io.ktor.http.HttpHeaders
import kotlinx.serialization.encodeToString

class ExplorationDataSource {
    private val json = Json { ignoreUnknownKeys = true }
    fun retrieveAll(explorerData: LoginResponse): List<Exploration> {
        val url = "${explorerData.explorer.href}/explorations"
        val (_, _, result) = url.httpGet().header(HttpHeaders.Authorization, "Bearer ${explorerData.tokens.accessToken}").responseJson()

        return when (result) {
            is Result.Success -> json.decodeFromString(result.value.content)
            is Result.Failure -> throw result.error.exception
        }
    }

    fun makeExploration(explorerData: LoginResponse, key: String): Exploration {
        val url = "${explorerData.explorer.href}/explorations"
        val jsonBody = json.encodeToString(ScanRequest(key))
        val (_, _, result) = url
            .httpPost()
            .header(HttpHeaders.Authorization, "Bearer ${explorerData.tokens.accessToken}")
            .jsonBody(jsonBody)
            .responseJson()

        when(result) {
            is Result.Success -> return json.decodeFromString(result.value.content)
            is Result.Failure -> throw result.error.exception
        }
    }

    fun captureAlly(tokens: Tokens, href: String) {
        if (href.isNotEmpty()) {
            val (_, _, result) = href
                .httpPost()
                .header(HttpHeaders.Authorization, "Bearer ${tokens.accessToken}")
                .responseJson()

            when (result) {
                is Result.Success -> return json.decodeFromString(result.value.content)
                is Result.Failure -> throw result.error.exception
            }
        }
    }
}