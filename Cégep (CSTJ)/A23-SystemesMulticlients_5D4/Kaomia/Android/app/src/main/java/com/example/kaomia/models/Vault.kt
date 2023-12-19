package com.example.kaomia.models

import kotlinx.serialization.Serializable

@Serializable
data class Vault (
    val inox: Int? = null,
    val elements: List<Element>
)