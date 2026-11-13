package ca.qc.cstj.tenretni.domain.models

import kotlinx.serialization.Serializable

@Serializable
data class Gateway(
    val href: String = "",
    val serialNumber: String = "",
    val revision: String = "",
    val pin: String = "",
    val hash: String = "",
    val customer: Customer = Customer("", "", "", "", "", "", "", "", "", Coordinate(1F,2F)),
    val connection: Connection = Connection("", "", 1F, 1F, 1, 1),
    val config: Config = Config("", "", "", emptyList(), 0)
)