package ca.qc.cstj.tenretni.presentation.ui.network

import android.os.Bundle
import android.view.View
import android.viewbinding.library.fragment.viewBinding
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import ca.qc.cstj.tenretni.R
import ca.qc.cstj.tenretni.databinding.FragmentNetworksBinding
import ca.qc.cstj.tenretni.helpers.notifyAllItemChanged
import ca.qc.cstj.tenretni.presentation.adapters.NetworkRecyclerViewAdapter

class NetworksFragment : Fragment(R.layout.fragment_networks) {
    private val binding: FragmentNetworksBinding by viewBinding()
    private val viewModel: NetworksViewModel by viewModels()

    private lateinit var networkRecyclerViewAdapter: NetworkRecyclerViewAdapter

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        networkRecyclerViewAdapter = NetworkRecyclerViewAdapter(listOf())

        binding.rcvNetworks.apply {
            layoutManager = LinearLayoutManager(requireContext())
            adapter = networkRecyclerViewAdapter
        }

        viewModel.network.observe(viewLifecycleOwner) {
            networkRecyclerViewAdapter.nodes = it.data?.nodes!! //.data!!
            networkRecyclerViewAdapter.notifyAllItemChanged()

            val dateReboot = it.data.nextReboot.subSequence(0,10).toString() + " " +it.data.nextReboot.subSequence(11,19).toString()
            val dateUpdate = it.data.updateDate.subSequence(0,10).toString() + " " +it.data.updateDate.subSequence(11,19).toString()
            binding.txvNextReboot.text = String.format(binding.root.context.getString(R.string.dateNextReboot), dateReboot)
            binding.txvLastUpdate.text = String.format(binding.root.context.getString(R.string.dateLastUpdate), dateUpdate)
        }
    }
}