package ca.qc.cstj.tenretni.helpers

object Constants {
    object BaseURL {
        private const val BASE_API = "https://api.andromia.science"
        const val TICKETS = "${BASE_API}/tickets"
        const val GATEWAYS = "${BASE_API}/gateways"
        const val NETWORK = "${BASE_API}/network"
    }

    const val FLAG_API_URL = "https://flagcdn.com/h40/%s.png"
    const val REFRESH_DELAY: Long = 120000L
    const val TICKETS_REFRESH_DELAY: Long = 30000L
    const val GATEWAYS_REFRESH_DELAY: Long = 60000L
    const val TICKET_ID = BaseURL.TICKETS.length + 1

    enum class TicketPriority {
        Low, Normal, High, Critical
    }

    enum class TicketStatus {
        Open, Solved
    }

    enum class ConnectionStatus {
        Online, Offline
    }
}