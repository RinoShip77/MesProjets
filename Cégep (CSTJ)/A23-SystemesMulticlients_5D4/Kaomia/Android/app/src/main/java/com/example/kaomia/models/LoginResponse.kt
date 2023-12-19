package com.example.kaomia.models

import androidx.room.Entity
import kotlinx.serialization.Serializable

@Serializable
data class LoginResponse (
    val explorer: Explorer,
    val tokens: Tokens
)