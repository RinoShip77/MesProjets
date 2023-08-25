package ca.qc.cstj.tenretni.domain.models

import kotlinx.serialization.Serializable

@Serializable
data class Connection(
    val status: String = "",
    val ip: String = "",
    val download: Float = 0F,
    val upload: Float = 0F,
    val signal: Int = 0,
    val ping: Int = 0
)