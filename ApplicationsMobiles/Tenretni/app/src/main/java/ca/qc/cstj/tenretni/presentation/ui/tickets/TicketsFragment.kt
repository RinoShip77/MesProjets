package ca.qc.cstj.tenretni.presentation.ui.tickets

import android.os.Bundle
import android.view.View
import android.viewbinding.library.fragment.viewBinding
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import ca.qc.cstj.tenretni.R
import ca.qc.cstj.tenretni.databinding.FragmentTicketsBinding
import ca.qc.cstj.tenretni.domain.models.Ticket
import ca.qc.cstj.tenretni.helpers.LoadingResource
import ca.qc.cstj.tenretni.helpers.notifyAllItemChanged
import ca.qc.cstj.tenretni.presentation.adapters.TicketRecyclerViewAdapter

class TicketsFragment : Fragment(R.layout.fragment_tickets) {
    private val binding: FragmentTicketsBinding by viewBinding()
    private val viewModel: TicketsViewModel by viewModels()

    private lateinit var ticketRecyclerViewAdapter: TicketRecyclerViewAdapter

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        ticketRecyclerViewAdapter = TicketRecyclerViewAdapter(listOf(), ::onRecyclerViewTicketClick)

        binding.rcvTickets.apply {
            layoutManager = LinearLayoutManager(requireContext())
            adapter = ticketRecyclerViewAdapter
        }

        viewModel.tickets.observe(viewLifecycleOwner) {
            when (it) {
                is LoadingResource.Error -> {
                    Toast.makeText(requireContext(), it.message, Toast.LENGTH_LONG).show()
                }
                is LoadingResource.Success -> {
                    //binding.pgbLoading.hide()
                    ticketRecyclerViewAdapter.tickets = it.data!!
                    ticketRecyclerViewAdapter.notifyAllItemChanged()
                    binding.rcvTickets.visibility = View.VISIBLE
                }
                is LoadingResource.Loading -> {
                    //binding.pgbLoading.show()
                    binding.rcvTickets.visibility = View.INVISIBLE
                }
            }
        }
    }

    private fun onRecyclerViewTicketClick(ticket: Ticket) {
        findNavController().navigate(TicketsFragmentDirections.actionNavTicketsToNavDetailTicket(ticket.href))
    }
}