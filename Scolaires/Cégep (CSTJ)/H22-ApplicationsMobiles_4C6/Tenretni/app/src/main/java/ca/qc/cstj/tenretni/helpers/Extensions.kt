package ca.qc.cstj.tenretni.helpers

import android.content.Context
import android.widget.ImageView
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.RecyclerView
import ca.qc.cstj.tenretni.R
import com.google.android.material.chip.Chip
import com.google.android.material.textfield.TextInputLayout

fun <T> MutableLiveData<T>.notify() {
    this.value = this.value
}

fun <T> LiveData<T>.observeOnce(lifecycleOwner: LifecycleOwner, observer: Observer<T>) {
    observe(lifecycleOwner, object : Observer<T> {
        override fun onChanged(t: T?) {
            observer.onChanged(t)
            removeObserver(this)
        }
    })
}

fun <VH : RecyclerView.ViewHolder> RecyclerView.Adapter<VH>.notifyAllItemChanged() {
    notifyItemRangeChanged(0, itemCount)
}

var TextInputLayout.text
    get() = editText!!.text.toString()
    set(value) = editText!!.setText(value)

fun ImageView.loadFromResource(context: Context, imageName:String) {
    val imageId = resources.getIdentifier(imageName, "drawable", context.packageName)
    this.setImageResource(imageId)
}

fun Context.getStringWithIdentifier(identifier:String) : String {
    val res = this.resources
    return res.getString(res.getIdentifier(identifier.lowercase(), "string", packageName))
}

fun alternateChipPriorityBackground(priority: String, chpTicketPriority: Chip) {
    when(priority) {
        Constants.TicketPriority.Critical.toString() -> {
            chpTicketPriority.setChipBackgroundColorResource(R.color.ticket_priority_critical)
        }
        Constants.TicketPriority.High.toString() -> {
            chpTicketPriority.setChipBackgroundColorResource(R.color.ticket_priority_high)
        }
        Constants.TicketPriority.Normal.toString() -> {
            chpTicketPriority.setChipBackgroundColorResource(R.color.ticket_priority_normal)
        }
        Constants.TicketPriority.Low.toString() -> {
            chpTicketPriority.setChipBackgroundColorResource(R.color.ticket_priority_low)
        }
    }
}

fun alternateChipStatusBackground(status: String, chpTicketStatus: Chip) {
    when(status) {
        Constants.TicketStatus.Open.toString() -> {
            chpTicketStatus.setChipBackgroundColorResource(R.color.ticket_status_open)
        }
        Constants.TicketStatus.Solved.toString() -> {
            chpTicketStatus.setChipBackgroundColorResource(R.color.ticket_status_solved)
        }
    }
}

fun completeClientName(firstName: String, lastName: String): String {
    return "$firstName $lastName"
}