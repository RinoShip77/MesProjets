package ca.qc.cstj.tenretni.presentation.ui.network

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import ca.qc.cstj.tenretni.data.repositories.NetworkRepository
import ca.qc.cstj.tenretni.domain.models.Network
import ca.qc.cstj.tenretni.helpers.Resource
import kotlinx.coroutines.launch

class NetworksViewModel : ViewModel() {
    private val networkRepository = NetworkRepository()

    private val _network = MutableLiveData<Resource<Network>>()
    val network : LiveData<Resource<Network>> get() = _network

    init {
        viewModelScope.launch {
            _network.value = networkRepository.retrieve()
        }
    }
}