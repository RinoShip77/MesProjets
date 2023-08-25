package ca.qc.cstj.tenretni.presentation.ui.tickets

import androidx.lifecycle.*
import ca.qc.cstj.tenretni.data.repositories.CustomerRepository
import ca.qc.cstj.tenretni.data.repositories.GatewayRepository
import ca.qc.cstj.tenretni.data.repositories.TicketRepository
import ca.qc.cstj.tenretni.domain.models.Customer
import ca.qc.cstj.tenretni.domain.models.Gateway
import ca.qc.cstj.tenretni.domain.models.Ticket
import ca.qc.cstj.tenretni.helpers.Resource
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class DetailTicketViewModel(private val href:String) : ViewModel() {
    private val gatewayRepository = GatewayRepository()
    private val ticketRepository = TicketRepository()
    private val customerRepository = CustomerRepository()

    private val _gateways = MutableLiveData<Resource<List<Gateway>>>()
    val gateways: LiveData<Resource<List<Gateway>>> get() = _gateways

    private val _ticket = MutableLiveData<Resource<Ticket>>()
    val ticket: LiveData<Resource<Ticket>> get() = _ticket

    private val _customer = MutableLiveData<Resource<Customer>>()
    val customer: LiveData<Resource<Customer>> get() = _customer

    init {
        //Get ticket
       viewModelScope.launch {
           ticketRepository.retrieveOne(href).collect { ticket ->
               _ticket.value = ticket
               viewModelScope.launch {
                   gatewayRepository.retrieveFromTicket(_ticket.value!!.data!!.customer.href).collect {
                       _gateways.value = it
                   }
               }
               viewModelScope.launch {
                   customerRepository.retrieveOne(_ticket.value!!.data!!.customer.href).collect {
                       _customer.value = it
                   }
               }
           }
        }
    }

    fun updateTicketStatus(ticketId: String, targetStatus: String) {
        viewModelScope.launch {
            _ticket.value = ticketRepository.updateTicket(ticketId, targetStatus)
        }
    }

    class Factory(private val href:String) : ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return modelClass.getConstructor(String::class.java).newInstance(href)
        }
    }
}