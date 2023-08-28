package ca.qc.cstj.consortium.presentation.ui.newDelivery

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import ca.qc.cstj.consortium.R
import ca.qc.cstj.consortium.core.sliderDoubleDecimalToFloat
import ca.qc.cstj.consortium.core.sliderDoubleDecimalToString
import ca.qc.cstj.consortium.databinding.ActivityNewDeliveryBinding
import ca.qc.cstj.consortium.presentation.ui.deliveries.DeliveriesActivity

class NewDeliveryActivity : AppCompatActivity() {
    private lateinit var binding : ActivityNewDeliveryBinding
    private val viewModel: NewDeliveryViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityNewDeliveryBinding.inflate(layoutInflater)
        setContentView(binding.root)

        viewModel.trader.observe(this) {
            //Initialise la vue pour l'utilisateur
            with(binding) {
                sldVethyx.valueTo = it.vethyx
                sldLukryx.valueTo = it.lukryx
                sldSmiathil.valueTo = it.smiathil
                sldBilerium.valueTo = it.bilerium
                sldGloylium.valueTo = it.gloylium
            }
        }

        //Ces fonctions font changer la valeur en texte
        binding.sldVethyx.addOnChangeListener { _, _, _ ->
            binding.txvValueVethyx.text = sliderDoubleDecimalToString(binding.sldVethyx)
        }

        binding.sldLukryx.addOnChangeListener { _, _, _ ->
            binding.txvValueLukryx.text = sliderDoubleDecimalToString(binding.sldLukryx)
        }

        binding.sldSmiathil.addOnChangeListener { _, _, _ ->
            binding.txvValueSmiathil.text = sliderDoubleDecimalToString(binding.sldSmiathil)
        }

        binding.sldBilerium.addOnChangeListener { _, _, _ ->
            binding.txvValueBilerium.text = sliderDoubleDecimalToString(binding.sldBilerium)
        }

        binding.sldGloylium.addOnChangeListener { _, _, _ ->
            binding.txvValueGloylium.text = sliderDoubleDecimalToString(binding.sldGloylium)
        }

        binding.btnSaveDelivery.setOnClickListener {
            if(isMinimumValue()) {
                //Récupère les valeurs des glissières
                val vethyx = sliderDoubleDecimalToFloat(binding.sldVethyx)
                val lukryx = sliderDoubleDecimalToFloat(binding.sldLukryx)
                val smiathil = sliderDoubleDecimalToFloat(binding.sldSmiathil)
                val bilerium = sliderDoubleDecimalToFloat(binding.sldBilerium)
                val gloylium = sliderDoubleDecimalToFloat(binding.sldGloylium)
                viewModel.save(vethyx, lukryx, smiathil, bilerium, gloylium)

                Toast.makeText(this, getString(R.string.msgToastNewDeliverySave), Toast.LENGTH_LONG).show()
                startActivity(DeliveriesActivity.newIntent(this))
            } else {
                Toast.makeText(this, getString(R.string.msgToastNewDeliveryError), Toast.LENGTH_LONG).show()
            }
        }
    }

    private fun isMinimumValue(): Boolean {
        return binding.sldVethyx.value > 0 && binding.sldLukryx.value > 0 && binding.sldSmiathil.value > 0 && binding.sldBilerium.value > 0 && binding.sldGloylium.value > 0
    }

    companion object {
        fun newIntent(context: Context) : Intent {
            return Intent(context, NewDeliveryActivity::class.java)
        }
    }
}