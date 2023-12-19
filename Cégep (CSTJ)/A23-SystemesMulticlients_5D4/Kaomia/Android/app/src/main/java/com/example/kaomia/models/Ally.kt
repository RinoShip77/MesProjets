package com.example.kaomia.models

import kotlinx.serialization.Serializable
import com.example.kaomia.core.serializers.DateSerializer
import java.util.Date

@Serializable
data class Ally (
    val stats: Stats,
    val crypto: Crypto,
    val books: Collection<String>,
    val kernel: Collection<String>,
    val archiveIndex: Int,
    val name: String,
    val uuid: String,
    val affinity: String,
    val essence: Int,
    val href: String,
    val asset: String,

    @Serializable(with = DateSerializer::class)
    val createdAt: Date,

    @Serializable(with = DateSerializer::class)
    val updatedAt: Date,

    @Serializable(with = DateSerializer::class)
    val expireAt: Date,
)