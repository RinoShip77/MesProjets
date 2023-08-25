package ca.qc.cstj.tenretni.presentation.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import ca.qc.cstj.tenretni.databinding.ItemTicketBinding
import ca.qc.cstj.tenretni.domain.models.Ticket
import ca.qc.cstj.tenretni.helpers.DateHelper
import ca.qc.cstj.tenretni.helpers.alternateChipPriorityBackground
import ca.qc.cstj.tenretni.helpers.alternateChipStatusBackground

class TicketRecyclerViewAdapter(var tickets: List<Ticket> = listOf(),private val onTicketClick: (Ticket) -> Unit) : RecyclerView.Adapter<TicketRecyclerViewAdapter.ViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TicketRecyclerViewAdapter.ViewHolder {
        return ViewHolder(ItemTicketBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    }

    override fun onBindViewHolder(holder: TicketRecyclerViewAdapter.ViewHolder, position: Int) {
        val ticket = tickets[position]
        holder.bind(ticket)

        holder.itemView.setOnClickListener {
            onTicketClick(ticket)
        }
    }

    override fun getItemCount() = tickets.size

    inner class ViewHolder(private val binding: ItemTicketBinding): RecyclerView.ViewHolder(binding.root) {
        fun bind(ticket: Ticket)  {
            displayTicket(ticket)
        }

        private fun displayTicket(ticket: Ticket) {
            binding.txvTicketNumber.text = "Ticket ${ticket.ticketNumber}"
            binding.txvPurchaseDate.text = DateHelper.formatISODate(ticket.createdDate)

            binding.chpTicketPriority.text = ticket.priority
            alternateChipPriorityBackground(ticket.priority, binding.chpTicketPriority)

            binding.chpTicketStatus.text = ticket.status
            alternateChipStatusBackground(ticket.status, binding.chpTicketStatus)
        }
    }
}