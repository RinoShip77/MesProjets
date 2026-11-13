package ca.qc.cstj.tenretni.presentation.ui.qr

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.View
import android.widget.Toast
import androidx.fragment.app.viewModels
import androidx.navigation.fragment.navArgs
import ca.qc.cstj.tenretni.R
import ca.qc.cstj.tenretni.helpers.Resource
import io.github.g00fy2.quickie.QRResult
import io.github.g00fy2.quickie.ScanQRCode

class QRFragment : Fragment(R.layout.fragment_q_r) {
    private val viewModel: QRViewModel by viewModels{
        QRViewModel.Factory(args.customerId)
    }
    private val args: QRFragmentArgs by navArgs()
    private val quickieActivityLauncher = registerForActivityResult(ScanQRCode(), ::handleQuickieResult)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        quickieActivityLauncher.launch(null)

        viewModel.gateway.observe(viewLifecycleOwner) {
            when(it) {
                is Resource.Error -> {
                    Toast.makeText(requireContext(), it.throwable.message, Toast.LENGTH_LONG).show()
                }
                is Resource.Success -> {
                }
            }
        }
    }

    private fun handleQuickieResult(qrResult: QRResult) {
        when(qrResult) {
            is QRResult.QRSuccess -> {
                viewModel.addGateway(qrResult.content.rawValue)
                Toast.makeText(requireContext(), getString(R.string.gatewaySuccess), Toast.LENGTH_LONG).show()
            }
            is QRResult.QRUserCanceled -> {
            }
            is QRResult.QRMissingPermission -> {
            }
            is QRResult.QRError -> {
                Toast.makeText(requireContext(), getString(R.string.errorQR), Toast.LENGTH_LONG).show()
            }
        }
    }
}