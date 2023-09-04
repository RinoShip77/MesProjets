package ca.qc.cstj.tenretni.data.repositories

import ca.qc.cstj.tenretni.data.datasources.CustomerDataSource
import ca.qc.cstj.tenretni.domain.models.Customer
import ca.qc.cstj.tenretni.domain.models.Gateway
import ca.qc.cstj.tenretni.helpers.Constants
import ca.qc.cstj.tenretni.helpers.Resource
import com.github.kittinunf.fuel.core.extensions.jsonBody
import com.github.kittinunf.fuel.httpPost
import com.github.kittinunf.fuel.json.responseJson
import com.github.kittinunf.result.Result
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.withContext
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json

class CustomerRepository {
    private val customerDataSource = CustomerDataSource()

    suspend fun retrieveOne(href: String): Flow<Resource<Customer>> {
        return flow {
            while (true) {
                try {
                    //delay(1500)
                    emit(Resource.Success(customerDataSource.retrieveOne(href)))
                } catch (ex: Exception) {
                    emit(Resource.Error(ex, ex.message))
                }
                delay(Constants.TICKETS_REFRESH_DELAY)
            }
        }
    }

    suspend fun postGateway(codeValue: String, customerId: String): Resource<Gateway> {
        return withContext(Dispatchers.IO) {
            //Faire appel
            val string = "$customerId/gateways"
            val (_, _, result) = string.httpPost().jsonBody(codeValue).responseJson()

            //Gérer la réponse
            when (result) {
                is Result.Success -> {
                    return@withContext Resource.Success(Json.decodeFromString<Gateway>(result.value.content))
                }
                is Result.Failure -> {
                    return@withContext Resource.Error(result.error.exception)
                }
            }
        }
    }
}