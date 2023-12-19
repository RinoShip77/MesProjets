package com.example.kaomia.models

import kotlinx.serialization.Serializable

@Serializable
data class BonusChest (
    val inox: Int,
    val elements: List<Element>
)