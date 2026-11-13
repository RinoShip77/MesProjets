package com.example.kaomia.models

import kotlinx.serialization.Serializable

@Serializable
data class CreateAccount(
    val username: String,
    val email: String,
    val name: String,
    val surname: String,
    val password: String,
    val inventory: Inventory
)
