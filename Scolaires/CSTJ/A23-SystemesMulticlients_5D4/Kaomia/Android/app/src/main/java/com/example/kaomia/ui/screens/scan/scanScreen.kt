package com.example.kaomia.ui.screens.scan

import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Toast
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.kaomia.Screen
import com.example.kaomia.ui.screens.explorations.ExplorationList
import com.example.kaomia.ui.screens.explorations.ExplorationsUiState
import com.example.kaomia.ui.screens.explorations.ExplorationsViewModel
import com.example.kaomia.ui.screens.explorations.Loading
import io.github.g00fy2.quickie.QRResult
import io.github.g00fy2.quickie.ScanQRCode
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onEach

@Composable
fun ScanScreen(navController: NavHostController) {
    val scanQrCodeLauncher = rememberLauncherForActivityResult(ScanQRCode()) { result ->
        when(result) {
            is QRResult.QRError -> Toast.makeText(navController.context, "echec du scan", Toast.LENGTH_LONG).show()
            QRResult.QRMissingPermission -> Toast.makeText(navController.context, "Kaomia n'a pas les permissions pour utilisé votre caméra", Toast.LENGTH_LONG).show()
            is QRResult.QRSuccess -> {
                navController.navigate(Screen.Exploration.route.replace("{key}",result.content.rawValue!!))
            }
            QRResult.QRUserCanceled -> TODO()
        }
    }
    LaunchedEffect("camera", block = {
        scanQrCodeLauncher.launch(null)
    })
}