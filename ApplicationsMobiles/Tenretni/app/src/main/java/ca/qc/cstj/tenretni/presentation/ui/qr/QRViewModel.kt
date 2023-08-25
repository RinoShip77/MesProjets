package ca.qc.cstj.tenretni.presentation.ui.qr

import androidx.lifecycle.*
import ca.qc.cstj.tenretni.data.repositories.CustomerRepository
import ca.qc.cstj.tenretni.domain.models.Gateway
import ca.qc.cstj.tenretni.helpers.Resource
import kotlinx.coroutines.launch

class QRViewModel(private val customerId : String) : ViewModel() {
    private val customerRepository = CustomerRepository()
    private val _gateway = MutableLiveData<Resource<Gateway>>()
    val gateway: LiveData<Resource<Gateway>> get() = _gateway

    fun addGateway(codeValue: String) {
        viewModelScope.launch {
            customerRepository.postGateway(codeValue, customerId)
        }
    }

    class Factory(private val customerId:String) : ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return modelClass.getConstructor(String::class.java).newInstance(customerId)
        }
    }
}