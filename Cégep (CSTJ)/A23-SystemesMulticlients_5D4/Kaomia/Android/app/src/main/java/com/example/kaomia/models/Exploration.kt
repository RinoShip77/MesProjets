package com.example.kaomia.models

import kotlinx.serialization.Serializable
import com.example.kaomia.core.serializers.DateSerializer
import java.util.Date

@Serializable
data class Exploration (
    @Serializable(with = DateSerializer::class)
    val explorationDate: Date,
    val destination: String,
    val affinity: String,
    val vault: Vault,
    val ally: Ally? = null,
    val chance: Int? = 0,
    val href: String,
    val capture_href: String? = null,
    val bonusChest: BonusChest? = null,

    // Variable necessary for the view of an Exploration
    var hasBeenSeen: Boolean? = false
)