package ca.qc.cstj.tenretni.presentation.ui.gateways

import android.graphics.Color
import android.os.Bundle
import android.view.View
import android.viewbinding.library.fragment.viewBinding
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.fragment.navArgs
import ca.qc.cstj.tenretni.R
import ca.qc.cstj.tenretni.databinding.FragmentDetailGatewayBinding
import ca.qc.cstj.tenretni.helpers.*

class DetailGatewayFragment : Fragment(R.layout.fragment_detail_gateway) {
    private val binding: FragmentDetailGatewayBinding by viewBinding()
    private val viewModel: DetailGatewayViewModel by viewModels {
        DetailGatewayViewModel.Factory(args.href)
    }
    private val args: DetailGatewayFragmentArgs by navArgs()

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel.gateway.observe(viewLifecycleOwner) {
            when (it) {
                is Resource.Error -> {
                    Toast.makeText(requireContext(), it.message, Toast.LENGTH_LONG).show()
                }
                is Resource.Success -> {
                    val gateway = it.data!!

                    binding.chpGatewayStatus.text = gateway.connection.status
                    alternateChipStatusBackground(
                        gateway.connection.status,
                        binding.chpGatewayStatus
                    )

                    (activity as AppCompatActivity).supportActionBar?.title =
                        String.format(
                            getString(R.string.detailGatewaySerialNumber),
                            gateway.serialNumber
                        )

                    binding.txvGatewaySerialNumber.text = gateway.serialNumber
                    binding.txvGatewayMAC.text = gateway.config.mac
                    binding.txvGatewaySSID.text =
                        String.format(getString(R.string.gatewaySSID), gateway.config.SSID)
                    binding.txvGatewayPIN.text =
                        String.format(getString(R.string.gatewayPIN), gateway.pin)

                    displayHash(gateway.hash)
                    setKernelImage(gateway.config.kernel)

                    binding.txvGatewayKernelRevision.text = String.format(
                        getString(R.string.gatewayKernelRevision),
                        gateway.config.kernelRevision.toString()
                    )
                    binding.txvGatewayVersion.text =
                        String.format(
                            getString(R.string.gatewayVersion),
                            gateway.config.version
                        )

                    if (gateway.connection.status == Constants.ConnectionStatus.Online.toString()) {
                        binding.txvGatewayConnectionIP.text = gateway.connection.ip
                        binding.txvGatewayConnectionPing?.text = String.format(
                            getString(R.string.gatewayConnectionPing),
                            gateway.connection.ping.toString()
                        )
                        binding.txvGatewayConnectionDownloadValue?.text = String.format(
                            getString(R.string.gatewayConnectionDownload),
                            gateway.connection.download.toString()
                        )
                        binding.txvGatewayConnectionUploadValue?.text = String.format(
                            getString(R.string.gatewayConnectionUpload),
                            gateway.connection.upload.toString()
                        )
                        binding.txvGatewayConnectionSignal?.text = String.format(
                            getString(R.string.gatewayConnectionSignal),
                            gateway.connection.signal.toString()
                        )
                    } else {
                        binding.chpGatewayStatus.setChipBackgroundColorResource(R.color.gateway_status_offline)
                        binding.grpGatewayStats.visibility = View.INVISIBLE
                        binding.btnGatewayUpdate.visibility = View.INVISIBLE
                        binding.btnGatewayReboot.visibility = View.INVISIBLE
                        binding.txvGatewayStats.visibility = View.VISIBLE
                        binding.txvGatewaySerialNumber.text = getString(R.string.statsNA)
                    }
                }
            }
        }

        binding.btnGatewayUpdate.setOnClickListener {
            viewModel.updateGateway()
        }

        binding.btnGatewayReboot.setOnClickListener {
            viewModel.rebootGateway()
        }
    }

    private fun displayHash(hash: String) {
        //Attribuer les valeurs (ou les couleurs) aux rectangles
        val beginAt = 2
        val hashStart = hash.substring(0, beginAt)
        val hash1 = "#${hash.substring(2, 8)}"
        val hash2 = "#${hash.substring(8, 14)}"
        val hash3 = "#${hash.substring(14, 20)}"
        val hash4 = "#${hash.substring(20, 26)}"
        val hash5 = "#${hash.substring(26, 32)}"
        val hash6 = "#${hash.substring(32, 38)}"
        val hash7 = "#${hash.substring(38, 44)}"
        val hash8 = "#${hash.substring(44, 50)}"
        val hash9 = "#${hash.substring(50, 56)}"
        val hash10 = "#${hash.substring(56, 62)}"
        val hashEnd = hash.substring(hash.length - beginAt)

        with(binding) {
            txvGatewayHashStart.text = hashStart
            rctGatewayHash1.setBackgroundColor(Color.parseColor(hash1))
            rctGatewayHash2.setBackgroundColor(Color.parseColor(hash2))
            rctGatewayHash3.setBackgroundColor(Color.parseColor(hash3))
            rctGatewayHash4.setBackgroundColor(Color.parseColor(hash4))
            rctGatewayHash5.setBackgroundColor(Color.parseColor(hash5))
            rctGatewayHash6.setBackgroundColor(Color.parseColor(hash6))
            rctGatewayHash7.setBackgroundColor(Color.parseColor(hash7))
            rctGatewayHash8.setBackgroundColor(Color.parseColor(hash8))
            rctGatewayHash9.setBackgroundColor(Color.parseColor(hash9))
            rctGatewayHash10.setBackgroundColor(Color.parseColor(hash10))
            txvGatewayHashEnd.text = hashEnd
        }
    }

    private fun setKernelImage(kernel: List<String>) {
        //Définir la source des iages pour chaque élément du noyau
        val element1Drawable = "element_${kernel[0]}"
        val element2Drawable = "element_${kernel[1]}"
        val element3Drawable = "element_${kernel[2]}"
        val element4Drawable = "element_${kernel[3]}"
        val element5Drawable = "element_${kernel[4]}"

        with(binding) {
            imvGatewayKernel1.loadFromResource(
                imvGatewayKernel1.context,
                element1Drawable.lowercase()
            )
            imvGatewayKernel2.loadFromResource(
                imvGatewayKernel2.context,
                element2Drawable.lowercase()
            )
            imvGatewayKernel3.loadFromResource(
                imvGatewayKernel3.context,
                element3Drawable.lowercase()
            )
            imvGatewayKernel4.loadFromResource(
                imvGatewayKernel4.context,
                element4Drawable.lowercase()
            )
            imvGatewayKernel5.loadFromResource(
                imvGatewayKernel5.context,
                element5Drawable.lowercase()
            )
        }
    }
}