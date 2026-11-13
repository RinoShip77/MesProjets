package ca.qc.cstj.tenretni.presentation.ui.gateways

import android.os.Bundle
import android.view.View
import android.viewbinding.library.fragment.viewBinding
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.GridLayoutManager
import ca.qc.cstj.tenretni.R
import ca.qc.cstj.tenretni.databinding.FragmentGatewaysBinding
import ca.qc.cstj.tenretni.domain.models.Gateway
import ca.qc.cstj.tenretni.helpers.LoadingResource
import ca.qc.cstj.tenretni.helpers.notifyAllItemChanged
import ca.qc.cstj.tenretni.presentation.adapters.GatewayRecyclerViewAdapter

class GatewaysFragment : Fragment(R.layout.fragment_gateways) {
    private val binding: FragmentGatewaysBinding by viewBinding()
    private val viewModel: GatewaysViewModel by viewModels()

    private lateinit var gatewayRecyclerViewAdapter: GatewayRecyclerViewAdapter

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        gatewayRecyclerViewAdapter = GatewayRecyclerViewAdapter(listOf(), ::onRecyclerViewGatewayClick)

        viewModel.gateways.observe(viewLifecycleOwner) {
            when(it) {
                is LoadingResource.Error -> {
                    Toast.makeText(requireContext(), it.message, Toast.LENGTH_LONG).show()
                }
                is LoadingResource.Success -> {
                    binding.pgbLoading.hide()
                    gatewayRecyclerViewAdapter.gateways = it.data!!
                    gatewayRecyclerViewAdapter.notifyAllItemChanged()
                    binding.rcvGateways.visibility = View.VISIBLE
                }
                is LoadingResource.Loading -> {
                    binding.pgbLoading.show()
                    binding.rcvGateways.visibility = View.INVISIBLE
                }
            }
        }

        binding.rcvGateways.apply {
            layoutManager = GridLayoutManager(requireContext(), 2)
            adapter = gatewayRecyclerViewAdapter
        }
    }

    private fun onRecyclerViewGatewayClick(gateway: Gateway) {
        findNavController().navigate(GatewaysFragmentDirections.actionNavGatewaysToNavDetailGateway(gateway.href))
    }
}