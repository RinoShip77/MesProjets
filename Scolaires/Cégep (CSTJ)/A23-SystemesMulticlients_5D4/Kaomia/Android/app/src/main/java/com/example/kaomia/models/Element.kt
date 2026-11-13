package com.example.kaomia.models

import kotlinx.serialization.Serializable

@Serializable
data class Element(
    val element: String,
    val quantity: Int
)