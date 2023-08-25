package ca.qc.cstj.tenretni.presentation.ui.gateways

import androidx.lifecycle.*
import ca.qc.cstj.tenretni.data.repositories.GatewayRepository
import ca.qc.cstj.tenretni.domain.models.Gateway
import ca.qc.cstj.tenretni.helpers.Resource
import kotlinx.coroutines.launch

class DetailGatewayViewModel(private val href:String) : ViewModel() {
    private val gatewayRepository = GatewayRepository()

    private val _gateway = MutableLiveData<Resource<Gateway>>()
    val gateway: LiveData<Resource<Gateway>> get() = _gateway

    init {
        refreshGateway()
    }

    fun refreshGateway() {
        viewModelScope.launch {
            _gateway.value = gatewayRepository.retrieveOne(href)
        }
    }

    fun updateGateway()
    {
        viewModelScope.launch {
            _gateway.value = gatewayRepository.update(gateway.value!!.data!!.serialNumber)
        }
    }

    fun rebootGateway()
    {
        viewModelScope.launch {
            _gateway.value = gatewayRepository.reboot(gateway.value!!.data!!.serialNumber)
        }
    }

    class Factory(private val href: String) : ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return modelClass.getConstructor(String::class.java).newInstance(href)
        }
    }
}