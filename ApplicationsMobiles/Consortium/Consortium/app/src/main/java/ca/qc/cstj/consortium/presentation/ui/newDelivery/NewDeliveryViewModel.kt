package ca.qc.cstj.consortium.presentation.ui.newDelivery

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import ca.qc.cstj.consortium.core.floatToDoubleDecimal
import ca.qc.cstj.consortium.data.AppDatabase
import ca.qc.cstj.consortium.data.repositories.TraderRepository
import ca.qc.cstj.consortium.domain.models.Delivery
import ca.qc.cstj.consortium.domain.models.Trader
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class NewDeliveryViewModel(application: Application) : AndroidViewModel(application) {
    private val deliveryRepository = AppDatabase.getDatabase(application).deliveryRepository()
    private val _deliveries = MutableLiveData<List<Delivery>>()

    val deliveries : LiveData<List<Delivery>> get() = _deliveries

    private val traderRepository = TraderRepository(application)
    private val _trader = MutableLiveData<Trader>()

    val trader : LiveData<Trader> get() = _trader

    init {
        //On démarre la Coroutine
        viewModelScope.launch {
            traderRepository.trader.collect {
                _trader.value = it
            }
        }
    }

    fun save(vethyx: Float, lukryx: Float, smiathil: Float, bilerium: Float, gloylium: Float) {
        val name = trader.value!!.name
        val vethyxUpdated = floatToDoubleDecimal(trader.value!!.vethyx - vethyx)
        val lukryxUpdated = floatToDoubleDecimal(trader.value!!.lukryx - lukryx)
        val smiathilUpdated = floatToDoubleDecimal(trader.value!!.smiathil - smiathil)
        val bileriumUpdated = floatToDoubleDecimal(trader.value!!.bilerium - bilerium)
        val gloyliumUpdated = floatToDoubleDecimal(trader.value!!.gloylium - gloylium)
        viewModelScope.launch {
            //On appelle le dépôt pour sauvegarder les modifications de données de l'utilisateur
            traderRepository.save(name, vethyxUpdated, lukryxUpdated, smiathilUpdated, bileriumUpdated, gloyliumUpdated)
        }

        val delivery = Delivery(vethyx, lukryx, smiathil, bilerium, gloylium)
        viewModelScope.launch {
            //On appelle le dépôt pour créer la livraison
            deliveryRepository.create(delivery)
        }
    }
}