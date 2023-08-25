package ca.qc.cstj.tenretni.presentation.ui.tickets

import android.os.Bundle
import android.view.View
import android.viewbinding.library.fragment.viewBinding
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.fragment.findNavController
import androidx.navigation.fragment.navArgs
import androidx.recyclerview.widget.GridLayoutManager
import ca.qc.cstj.tenretni.R
import ca.qc.cstj.tenretni.databinding.FragmentDetailTicketBinding
import ca.qc.cstj.tenretni.helpers.*
import ca.qc.cstj.tenretni.presentation.adapters.CustomerGatewayRecyclerViewAdapter
import com.bumptech.glide.Glide
import com.google.android.gms.maps.model.LatLng

class DetailTicketFragment : Fragment(R.layout.fragment_detail_ticket) {
    private val binding: FragmentDetailTicketBinding by viewBinding()
    private val viewModel: DetailTicketViewModel by viewModels {
        DetailTicketViewModel.Factory(args.href)
    }
    private val args: DetailTicketFragmentArgs by navArgs()
    private var position: LatLng? = null
    private var customerName: String? = null

    private lateinit var customerGatewayRecyclerViewAdapter: CustomerGatewayRecyclerViewAdapter

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel.ticket.observe(viewLifecycleOwner) {
            when (it) {
                is Resource.Error -> {
                    Toast.makeText(requireContext(), it.message, Toast.LENGTH_LONG).show()
                }
                is Resource.Success -> {
                    val ticket = it.data!!

                    (activity as AppCompatActivity).supportActionBar?.title =
                        String.format(getString(R.string.ticketNumber), ticket.ticketNumber)
                    binding.iclTicketItem.txvTicketNumber.text =
                        String.format(getString(R.string.ticketNumber), ticket.ticketNumber)
                    binding.iclTicketItem.txvPurchaseDate.text =
                        DateHelper.formatISODate(ticket.createdDate)

                    binding.iclTicketItem.chpTicketPriority.text = ticket.priority
                    alternateChipPriorityBackground(
                        ticket.priority,
                        binding.iclTicketItem.chpTicketPriority
                    )

                    binding.iclTicketItem.chpTicketStatus.text = ticket.status
                    alternateChipStatusBackground(
                        ticket.status,
                        binding.iclTicketItem.chpTicketStatus
                    )

                    binding.btnSolveTicket.setOnClickListener {
                        with(binding) {
                            iclTicketItem.chpTicketStatus.text =
                                Constants.TicketStatus.Solved.toString()
                            iclTicketItem.chpTicketStatus.setChipBackgroundColorResource(R.color.ticket_status_solved)
                            btnInstallTicket.visibility = View.INVISIBLE
                            btnSolveTicket.visibility = View.INVISIBLE
                            btnOpenTicket.visibility = View.VISIBLE
                        }
                        viewModel.updateTicketStatus(
                            ticket.href.substring(Constants.TICKET_ID),
                            Constants.TicketStatus.Solved.toString()
                                .substring(0, Constants.TicketStatus.Solved.toString().length - 1)
                                .lowercase()
                        )
                    }

                    binding.btnOpenTicket.setOnClickListener {
                        with(binding) {
                            iclTicketItem.chpTicketStatus.text =
                                Constants.TicketStatus.Open.toString()
                            iclTicketItem.chpTicketStatus.setChipBackgroundColorResource(R.color.ticket_status_open)
                            btnInstallTicket.visibility = View.VISIBLE
                            btnSolveTicket.visibility = View.VISIBLE
                            btnOpenTicket.visibility = View.INVISIBLE
                        }
                        viewModel.updateTicketStatus(
                            ticket.href.substring(Constants.TICKET_ID),
                            Constants.TicketStatus.Open.toString().lowercase()
                        )
                    }
                }
            }
        }

        viewModel.customer.observe(viewLifecycleOwner) {
            when (it) {
                is Resource.Error -> {
                    Toast.makeText(requireContext(), it.message, Toast.LENGTH_LONG).show()
                }
                is Resource.Success -> {
                    val customer = it.data!!

                    customerName = completeClientName(customer.firstName, customer.lastName)
                    position = LatLng(
                        customer.coord?.latitude!!.toDouble(),
                        customer.coord.longitude.toDouble()
                    )

                    binding.txvTicketClientName.text = customerName
                    binding.txvTicketClientTown.text = customer.city
                    binding.txvTicketClientAdress.text = customer.address

                    Glide.with(requireContext())
                        .load(Constants.FLAG_API_URL.format(customer.country.lowercase()))
                        .into(binding.imvTicketClientFlag)
                }
            }
        }

        viewModel.gateways.observe(viewLifecycleOwner) {
            when (it) {
                is Resource.Error -> {
                    Toast.makeText(requireContext(), it.message, Toast.LENGTH_LONG).show()
                }
                is Resource.Success -> {
                    if (it.data!!.isEmpty()) {
                        binding.rcvTicketClientGateways.visibility = View.INVISIBLE
                        binding.txvTicketClientGatewaysStats.visibility = View.VISIBLE
                    } else {
                        binding.txvTicketClientGatewaysStats.visibility = View.INVISIBLE
                        customerGatewayRecyclerViewAdapter.gateways = it.data!!
                        customerGatewayRecyclerViewAdapter.notifyAllItemChanged()
                        binding.rcvTicketClientGateways.visibility = View.VISIBLE
                    }
                }
            }
        }

        customerGatewayRecyclerViewAdapter = CustomerGatewayRecyclerViewAdapter(listOf())
        binding.rcvTicketClientGateways.layoutManager = GridLayoutManager(requireContext(), 2)
        binding.rcvTicketClientGateways.adapter = customerGatewayRecyclerViewAdapter

        binding.fabTicketClientLocation.setOnClickListener {
            findNavController().navigate(
                DetailTicketFragmentDirections.actionNavDetailTicketToMapsActivity(
                    position!!,
                    customerName!!
                )
            )
        }

        binding.btnInstallTicket.setOnClickListener {
            findNavController().navigate(
                DetailTicketFragmentDirections.actionNavDetailTicketToQRFragment(
                    viewModel.customer.value!!.data!!.href, args.href
                )
            )
        }
    }
}