package com.example.kaomia.data.datasources

import com.example.kaomia.core.Constants
import com.example.kaomia.models.CreateAccount
import com.example.kaomia.models.Explorer
import com.example.kaomia.models.Inventory
import com.example.kaomia.models.LoginRequest
import com.example.kaomia.models.LoginResponse
import com.example.kaomia.models.Tokens
import com.github.kittinunf.fuel.core.extensions.jsonBody
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.httpPost
import com.github.kittinunf.fuel.json.responseJson
import com.github.kittinunf.result.Result
import io.ktor.http.HttpHeaders
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

class ExplorerDataSource {
    private val json = Json { ignoreUnknownKeys = true }

    fun login(username: String, password: String) : LoginResponse {
        val jsonBody = json.encodeToString(LoginRequest(username, password))
        val (_, _, result) = Constants.LOGIN_URL
            .httpPost()
            .jsonBody(jsonBody)
            .responseJson()

        when(result) {
            is Result.Success -> return json.decodeFromString(result.value.content)
            is Result.Failure -> throw result.error.exception
        }
    }

    fun logout(tokens: Tokens) {
        val (_, _, result) = Constants.LOGOUT_URL.httpGet()
            .header(HttpHeaders.Authorization, "Bearer ${tokens.accessToken}")
            .responseJson()

        when(result) {
            is Result.Success -> return json.decodeFromString(result.value.content)
            is Result.Failure -> throw result.error.exception
        }
    }

    fun retrieveExplorer(tokens: Tokens, href: String) : Explorer {
        val (_, _, result) = href
            .httpGet()
            .header(HttpHeaders.Authorization, "Bearer ${tokens.accessToken}")
            .responseJson()

        when(result) {
            is Result.Success -> return json.decodeFromString(result.value.content)
            is Result.Failure -> throw result.error.exception
        }
    }

    fun createAccount(
        username: String, email: String, name: String, surname: String, password: String
    ) : LoginResponse {

        val jsonBody = json.encodeToString(
            CreateAccount(
                username,
                email,
                name,
                surname,
                password,
                inventory = Inventory(
                    inox = 0,
                    elements = emptyList()
                )
            )
        )
        val (_, _, result) = Constants.CREATE_ACCOUNT_URL
            .httpPost()
            .jsonBody(jsonBody)
            .responseJson()

        when(result) {
            is Result.Success -> return json.decodeFromString(result.value.content)
            is Result.Failure -> throw result.error.exception
        }
    }
}