package ca.qc.cstj.consortium.presentation.ui.splash

import android.app.Application
import androidx.lifecycle.*
import ca.qc.cstj.consortium.data.repositories.TraderRepository
import ca.qc.cstj.consortium.domain.models.Trader
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class SplashViewModel(application: Application) : AndroidViewModel(application) {
    private val _trader = MutableLiveData<Trader>()
    val trader : LiveData<Trader> get() = _trader

    private val traderRepository = TraderRepository(application)

    init {
        //On démarre la Coroutine
        viewModelScope.launch {
            traderRepository.trader.collect {
                _trader.value = it
            }
        }
    }

    fun save(name: String, vethyx: Float, lukryx: Float, smiathil: Float, bilerium: Float, gloylium: Float) {
        viewModelScope.launch {
            //On appelle le dépôt pour sauvegarder les données de l'utilisateur
            traderRepository.save(name, vethyx, lukryx, smiathil, bilerium, gloylium)
        }
    }
}