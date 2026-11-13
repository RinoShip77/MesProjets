package ca.qc.cstj.tenretni.presentation.ui.gateways

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import ca.qc.cstj.tenretni.data.repositories.GatewayRepository
import ca.qc.cstj.tenretni.domain.models.Gateway
import ca.qc.cstj.tenretni.helpers.LoadingResource
import kotlinx.coroutines.launch
import kotlinx.coroutines.flow.collect

class GatewaysViewModel : ViewModel() {
    private val gatewayRepository = GatewayRepository()

    private val _gateways = MutableLiveData<LoadingResource<List<Gateway>>>()
    val gateways: LiveData<LoadingResource<List<Gateway>>> get() = _gateways

    init {
        refreshGateways()
    }

    fun refreshGateways() {
        viewModelScope.launch {
            gatewayRepository.retrieveAll().collect {
                _gateways.value = it
            }
        }
    }
}