package com.example.kaomia.models

import kotlinx.serialization.Serializable

@Serializable
data class Tokens (
    val accessToken: String,
    val refreshToken: String
)