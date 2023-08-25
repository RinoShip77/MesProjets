package ca.qc.cstj.tenretni.presentation.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import ca.qc.cstj.tenretni.R
import ca.qc.cstj.tenretni.databinding.ItemNetworkBinding
import ca.qc.cstj.tenretni.domain.models.NetworkNode

class NetworkRecyclerViewAdapter(var nodes: List<NetworkNode>): RecyclerView.Adapter<NetworkRecyclerViewAdapter.ViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): NetworkRecyclerViewAdapter.ViewHolder {
        return ViewHolder(ItemNetworkBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    }

    override fun onBindViewHolder(holder: NetworkRecyclerViewAdapter.ViewHolder, position: Int) {
        val nodes = nodes[position]
        holder.bind(nodes)
    }

    override fun getItemCount() = nodes.size

    inner class ViewHolder(private val binding: ItemNetworkBinding): RecyclerView.ViewHolder(binding.root) {
        fun bind(networkNode: NetworkNode)  {
            binding.txvNetworkName.text = networkNode.name
            binding.txvNetworkPing.text = String.format(binding.root.context.getString(R.string.networkPing), networkNode.connection.download.toString())
            binding.txvNetworkIP.text = String.format(binding.root.context.getString(R.string.networkIP), networkNode.connection.ip)
            binding.txvNetworkDownload.text = String.format(binding.root.context.getString(R.string.networkDownload), networkNode.connection.download.toString())
            binding.txvNetworkUpload.text = String.format(binding.root.context.getString(R.string.networkUpload), networkNode.connection.upload.toString())
            binding.txvNetworkSignal.text = String.format(binding.root.context.getString(R.string.networkSignal), networkNode.connection.signal.toString())
        }
    }
}