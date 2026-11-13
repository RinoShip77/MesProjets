package ca.qc.cstj.consortium.presentation.ui.deliveries

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import ca.qc.cstj.consortium.data.AppDatabase
import ca.qc.cstj.consortium.data.repositories.TraderRepository
import ca.qc.cstj.consortium.domain.models.Delivery
import ca.qc.cstj.consortium.domain.models.Trader
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class DeliveriesViewModel(application: Application) : AndroidViewModel(application) {
    private val deliveryRepository = AppDatabase.getDatabase(application).deliveryRepository()
    private val _deliveries = MutableLiveData<List<Delivery>>()

    val deliveries : LiveData<List<Delivery>> get() = _deliveries

    private val traderRepository = TraderRepository(application)
    private val _trader = MutableLiveData<Trader>()

    val trader : LiveData<Trader> get() = _trader

    init {
        //On démarre la Coroutine (pour les livraisons)
        viewModelScope.launch {
            deliveryRepository.retrieveAll().collect {
                _deliveries.value = it
            }
        }

        //On démarre la Coroutine (pour l'utilisateur)
        viewModelScope.launch {
            traderRepository.trader.collect {
                _trader.value = it
            }
        }
    }

    fun deleteAll() {
        viewModelScope.launch {
            //On appelle le dépôt pour supprimer les livraisons
            deliveryRepository.deleteAll()
        }
    }
}