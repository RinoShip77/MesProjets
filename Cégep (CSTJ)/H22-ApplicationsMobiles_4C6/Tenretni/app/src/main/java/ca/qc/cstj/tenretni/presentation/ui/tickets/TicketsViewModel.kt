package ca.qc.cstj.tenretni.presentation.ui.tickets

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import ca.qc.cstj.tenretni.data.repositories.TicketRepository
import ca.qc.cstj.tenretni.domain.models.Ticket
import ca.qc.cstj.tenretni.helpers.LoadingResource
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class TicketsViewModel : ViewModel() {
    private val ticketRepository = TicketRepository()

    private val _tickets = MutableLiveData<LoadingResource<List<Ticket>>>()
    val tickets: LiveData<LoadingResource<List<Ticket>>> get() = _tickets

    init {
        refreshTickets()
    }

    fun refreshTickets() {
        viewModelScope.launch {
            ticketRepository.retrieveAll().collect {
                _tickets.value = it
            }
        }
    }
}