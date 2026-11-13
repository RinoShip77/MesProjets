package com.example.kaomia.models

import kotlinx.serialization.Serializable

@Serializable
data class Explorer (
    val email: String,
    val username: String,
    val name: String,
    val surname: String,
    val inventory: Inventory,
    val location: String,
    val href: String
)