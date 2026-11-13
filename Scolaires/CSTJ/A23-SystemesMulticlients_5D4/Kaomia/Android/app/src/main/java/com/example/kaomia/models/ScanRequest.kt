package com.example.kaomia.models

import kotlinx.serialization.Serializable

@Serializable
data class ScanRequest(
    val key: String
)
