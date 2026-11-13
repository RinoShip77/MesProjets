package ca.qc.cstj.tenretni.domain.models

import kotlinx.serialization.Serializable

@Serializable
data class Config(
    val mac: String,
    val SSID: String,
    val version: String,
    val kernel: List<String>,
    val kernelRevision: Int,
    val installDate: String = ""
)