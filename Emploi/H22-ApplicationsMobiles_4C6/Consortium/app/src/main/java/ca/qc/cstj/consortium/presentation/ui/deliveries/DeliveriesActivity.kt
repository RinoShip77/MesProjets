package ca.qc.cstj.consortium.presentation.ui.deliveries

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.activity.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import ca.qc.cstj.consortium.R
import ca.qc.cstj.consortium.databinding.ActivityDeliveriesBinding
import ca.qc.cstj.consortium.presentation.adapters.DeliveryRecyclerViewAdapter
import ca.qc.cstj.consortium.presentation.ui.newDelivery.NewDeliveryActivity

class DeliveriesActivity : AppCompatActivity() {
    private lateinit var binding : ActivityDeliveriesBinding
    private val viewModel: DeliveriesViewModel by viewModels()

    private lateinit var deliveryRecyclerViewAdapter: DeliveryRecyclerViewAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityDeliveriesBinding.inflate(layoutInflater)
        setContentView(binding.root)

        viewModel.trader.observe(this) {
            //Initialise le message d'accueil
            binding.txvWelcomeUser.text = "${getString(R.string.msgWelcome)} ${it.name}"
        }

        //Configure le RecyclerView
        deliveryRecyclerViewAdapter = DeliveryRecyclerViewAdapter(listOf())
        binding.rcvDeliveries.layoutManager = LinearLayoutManager(this)
        binding.rcvDeliveries.adapter = deliveryRecyclerViewAdapter

        viewModel.deliveries.observe(this) {
            //Initialise la liste de livraisons
            deliveryRecyclerViewAdapter.deliveries = it
            deliveryRecyclerViewAdapter.notifyDataSetChanged()
        }

        binding.btnAddDelivery.setOnClickListener {
            startActivity(NewDeliveryActivity.newIntent(this))
        }
    }

    companion object {
        fun newIntent(context: Context) : Intent {
            return Intent(context, DeliveriesActivity::class.java)
        }
    }
}