package ca.qc.cstj.consortium.presentation.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import ca.qc.cstj.consortium.R
import ca.qc.cstj.consortium.databinding.ItemDeliveryBinding
import ca.qc.cstj.consortium.domain.models.Delivery

class DeliveryRecyclerViewAdapter(var deliveries: List<Delivery>) : RecyclerView.Adapter<DeliveryRecyclerViewAdapter.ViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        //On crée la vue
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_delivery, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        //On crée la vue pour une livraison
        val delivery = deliveries[position]
        holder.bind(delivery)
    }

    //On récupère le nombre de livraisons
    override fun getItemCount(): Int = deliveries.size

    inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        private val binding = ItemDeliveryBinding.bind(view)

        fun bind(delivery: Delivery) {
            //On récupère les valeurs de la livraison
            binding.txvValueVethyx.text = delivery.vethyx.toString()
            binding.txvValueLukryx.text = delivery.lukryx.toString()
            binding.txvValueSmiathil.text = delivery.smiathil.toString()
            binding.txvValueBilerium.text = delivery.bilerium.toString()
            binding.txvValueGloylium.text = delivery.gloylium.toString()
        }
    }
}