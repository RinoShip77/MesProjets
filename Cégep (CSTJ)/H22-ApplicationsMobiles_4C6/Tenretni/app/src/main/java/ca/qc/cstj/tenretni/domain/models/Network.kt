package ca.qc.cstj.tenretni.domain.models

import kotlinx.serialization.Serializable

@Serializable
data class Network(
    val nextReboot: String,
    val updateDate: String,
    val nodes: List<NetworkNode>
)