package com.example.kaomia.models

import kotlinx.serialization.Serializable

@Serializable
data class Crypto (
    val hash: String,
    val signature: String
)