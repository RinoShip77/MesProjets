package com.example.kaomia.models

import kotlinx.serialization.Serializable

@Serializable
data class Stats (
    val life: Int,
    val speed: Int,
    val power: Int,
    val shield: Int
)