package ca.qc.cstj.consortium.presentation.ui.splash

import android.annotation.SuppressLint
import android.os.Bundle
import android.widget.Toast
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import ca.qc.cstj.consortium.R
import ca.qc.cstj.consortium.core.addRandomFloatValueToText
import ca.qc.cstj.consortium.core.textToFloat
import ca.qc.cstj.consortium.core.textToString
import ca.qc.cstj.consortium.databinding.ActivitySplashBinding
import ca.qc.cstj.consortium.presentation.ui.deliveries.DeliveriesActivity
import ca.qc.cstj.consortium.presentation.ui.deliveries.DeliveriesViewModel

@SuppressLint("CustomSplashScreen")
class SplashActivity : AppCompatActivity() {
    private lateinit var binding : ActivitySplashBinding
    private val splashViewModel: SplashViewModel by viewModels()
    private val deliveriesViewModel: DeliveriesViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySplashBinding.inflate(layoutInflater)
        setContentView(binding.root)

        splashViewModel.trader.observe(this) {
            //Initialise les valeurs de la vue
            with(binding) {
                tilName.textToString = it.name
                txvValueVethyx.text = it.vethyx.toString()
                txvValueLukryx.text = it.lukryx.toString()
                txvValueSmiathil.text = it.smiathil.toString()
                txvValueBilerium.text = it.bilerium.toString()
                txvValueGloylium.text = it.gloylium.toString()
            }
        }

        binding.btnOpen.setOnClickListener {
            if(binding.tilName.textToString == "") {
                Toast.makeText(this, getString(R.string.msgSplashToastBtnOpen), Toast.LENGTH_LONG).show()
            } else {
                val name = binding.tilName.textToString
                //Transforme le text des TextView en nombre à virgule flottante
                val vethyx = textToFloat(binding.txvValueVethyx)
                val lukryx = textToFloat(binding.txvValueLukryx)
                val smiathil = textToFloat(binding.txvValueSmiathil)
                val bilerium = textToFloat(binding.txvValueBilerium)
                val gloylium = textToFloat(binding.txvValueGloylium)
                splashViewModel.save(name, vethyx, lukryx, smiathil, bilerium, gloylium)

                startActivity(DeliveriesActivity.newIntent(this))
            }
        }

        binding.btnLoad.setOnClickListener {
            val name = binding.tilName.textToString
            //Ajoute une valeur aléatoire à chaque élément de la livraison
            val vethyx = addRandomFloatValueToText(binding.txvValueVethyx)
            val lukryx = addRandomFloatValueToText(binding.txvValueLukryx)
            val smiathil = addRandomFloatValueToText(binding.txvValueSmiathil)
            val bilerium = addRandomFloatValueToText(binding.txvValueBilerium)
            val goylium = addRandomFloatValueToText(binding.txvValueGloylium)
            splashViewModel.save(name, vethyx, lukryx, smiathil, bilerium, goylium)
        }

        binding.btnUpload.setOnClickListener {
            deliveriesViewModel.deleteAll()
            Toast.makeText(this, getString(R.string.msgSplashToastBtnUpload), Toast.LENGTH_LONG).show()
        }
    }
}