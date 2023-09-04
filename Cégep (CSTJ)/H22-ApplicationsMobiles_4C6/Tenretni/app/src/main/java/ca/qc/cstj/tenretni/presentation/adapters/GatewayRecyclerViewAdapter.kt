package ca.qc.cstj.tenretni.presentation.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import ca.qc.cstj.tenretni.R
import ca.qc.cstj.tenretni.databinding.ItemGatewayBinding
import ca.qc.cstj.tenretni.domain.models.Gateway
import ca.qc.cstj.tenretni.helpers.Constants

class GatewayRecyclerViewAdapter(var gateways: List<Gateway> = listOf(), private val onGatewayClick: (Gateway) -> Unit) : RecyclerView.Adapter<GatewayRecyclerViewAdapter.ViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): GatewayRecyclerViewAdapter.ViewHolder {
        return ViewHolder(ItemGatewayBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    }

    override fun onBindViewHolder(holder: GatewayRecyclerViewAdapter.ViewHolder, position: Int) {
        val gateway = gateways[position]
        holder.bind(gateway)

        holder.itemView.setOnClickListener {
            onGatewayClick(gateway)
        }
    }

    override fun getItemCount() = gateways.size

    inner class ViewHolder(private val binding: ItemGatewayBinding): RecyclerView.ViewHolder(binding.root) {
        fun bind(gateway: Gateway)  {
            binding.chpGatewayStatus.text = gateway.connection.status
            if(gateway.connection.status == Constants.ConnectionStatus.Offline.toString())
            {
                binding.chpGatewayStatus.setChipBackgroundColorResource(R.color.ticket_priority_critical)
                binding.grpDetailGatewayStats.visibility = View.INVISIBLE
                binding.txvGatewayStats.visibility = View.VISIBLE
                binding.txvGatewaySerialNumber.text = binding.root.context.getString(R.string.statsNA)
            }
            else
            {
                binding.txvGatewayConnectionPing.text = String.format(binding.root.context.getString(R.string.gatewayConnectionPing), gateway.connection.ping.toString())
                binding.txvGatewayConnectionDownloadValue.text = String.format(binding.root.context.getString(R.string.gatewayConnectionDownload), gateway.connection.download.toString())
                binding.txvGatewayConnectionUploadValue.text = String.format(binding.root.context.getString(R.string.gatewayConnectionUpload), gateway.connection.upload.toString())
            }
            binding.txvGatewaySerialNumber.text = gateway.serialNumber
        }
    }
}