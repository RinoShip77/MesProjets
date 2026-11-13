package com.example.kaomia

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.example.kaomia.ui.theme.FirstComposeTheme


//https://bootcamp.uxdesign.cc/navigation-bar-with-jetpack-compose-32b052824b7d
//https://developer.android.com/jetpack/compose/navigation?hl=fr#kts
//https://developer.android.com/codelabs/basic-android-kotlin-compose-navigation?hl=fr#2

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            FirstComposeTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    NavigationApp()

                }
                // A surface container using the 'background' color from the theme
            }
        }
    }
}

