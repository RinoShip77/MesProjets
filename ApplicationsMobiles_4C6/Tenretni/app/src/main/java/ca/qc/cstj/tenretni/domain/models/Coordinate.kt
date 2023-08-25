package ca.qc.cstj.tenretni.domain.models

import kotlinx.serialization.Serializable

@Serializable
data class Coordinate(
    val latitude: Float,
    val longitude: Float
)