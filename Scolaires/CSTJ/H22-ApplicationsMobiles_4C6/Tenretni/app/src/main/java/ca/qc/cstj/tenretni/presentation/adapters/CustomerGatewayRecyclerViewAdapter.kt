package ca.qc.cstj.tenretni.presentation.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import ca.qc.cstj.tenretni.databinding.ItemGatewayBinding
import ca.qc.cstj.tenretni.domain.models.Gateway

class CustomerGatewayRecyclerViewAdapter(var gateways: List<Gateway>): RecyclerView.Adapter<CustomerGatewayRecyclerViewAdapter.ViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CustomerGatewayRecyclerViewAdapter.ViewHolder {
        return ViewHolder(ItemGatewayBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    }

    override fun onBindViewHolder(holder: CustomerGatewayRecyclerViewAdapter.ViewHolder, position: Int) {
        val gateway = gateways[position]
        holder.bind(gateway)
    }

    override fun getItemCount() = gateways.size

    inner class ViewHolder(private val binding: ItemGatewayBinding): RecyclerView.ViewHolder(binding.root) {
        fun bind(gateway: Gateway)  {
            binding.chpGatewayStatus.text = gateway.connection.status
            binding.txvGatewayConnectionDownloadValue.text = gateway.connection.download.toString()
            binding.txvGatewayConnectionUploadValue.text = gateway.connection.upload.toString()
            binding.txvGatewaySerialNumber.text = gateway.serialNumber
        }
    }
}