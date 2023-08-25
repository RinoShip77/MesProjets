package ca.qc.cstj.tenretni.presentation.ui.map

import android.Manifest
import android.annotation.SuppressLint
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.navigation.navArgs
import ca.qc.cstj.tenretni.R
import ca.qc.cstj.tenretni.databinding.ActivityMapsBinding
import com.fondesa.kpermissions.allDenied
import com.fondesa.kpermissions.allGranted
import com.fondesa.kpermissions.extension.permissionsBuilder
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.*

class MapsActivity : AppCompatActivity(), OnMapReadyCallback {

    private lateinit var mMap: GoogleMap
    private lateinit var binding: ActivityMapsBinding

    private val args: MapsActivityArgs by navArgs()

    //Tant qu'on accède pas à cette variable, elle n'est pas créé
    private val locationRequestPermission by lazy {
        permissionsBuilder(
            Manifest.permission.ACCESS_COARSE_LOCATION,
            Manifest.permission.ACCESS_FINE_LOCATION,
        ).build()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMapsBinding.inflate(layoutInflater)
        setContentView(binding.root)

        locationRequestPermission.send()
        if(locationRequestPermission.checkStatus().allDenied()) {
            Toast.makeText(this, "Permission non accordée", Toast.LENGTH_LONG).show()
            finish()
        }

        val mapFragment = supportFragmentManager
            .findFragmentById(R.id.map) as SupportMapFragment
        mapFragment.getMapAsync(this)
    }

    override fun onMapReady(googleMap: GoogleMap) {
        val customerMakerOptions = MarkerOptions()
            .position(args.position)
            .title(args.customerName)
            .icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_BLUE))
        val customerCameraOptions = CameraUpdateFactory
            .newLatLngZoom(args.position, 0.15F)

        mMap = googleMap
        mMap.addMarker(customerMakerOptions)
        mMap.moveCamera(customerCameraOptions)

        if(locationRequestPermission.checkStatus().allGranted()) {
            @SuppressLint("MissingPermission")
            mMap.isMyLocationEnabled = true
        }
    }
}