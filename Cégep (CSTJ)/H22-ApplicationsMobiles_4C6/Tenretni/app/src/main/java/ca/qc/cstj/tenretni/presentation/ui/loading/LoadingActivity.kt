package ca.qc.cstj.tenretni.presentation.ui.loading

import android.os.Bundle
import android.os.CountDownTimer
import androidx.appcompat.app.AppCompatActivity
import ca.qc.cstj.tenretni.MainActivity
import ca.qc.cstj.tenretni.R
import ca.qc.cstj.tenretni.databinding.ActivityLoadingBinding

class LoadingActivity : AppCompatActivity() {
    private lateinit var binding: ActivityLoadingBinding

    private var counter = 0
    private val timer = object : CountDownTimer(10000, 1000) {
        override fun onTick(millisUntilFinished: Long) {
            binding.txvLoading.text =
                String.format(getString(R.string.loading_text), (++counter).toString())
            binding.pgbLoading.setProgress(counter, true)
        }

        override fun onFinish() {
            this.cancel()
            counter = 0
            binding.pgbLoading.setProgress(counter, false)
            startApp()
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityLoadingBinding.inflate(layoutInflater)
        setContentView(binding.root)

        timer.start()
    }

    fun startApp() {
        startActivity(MainActivity.newIntent(this))
    }
}