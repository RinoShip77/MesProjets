 package com.example.kaomia.ui.screens.login

import android.util.Log
import android.widget.Toast
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.MaterialTheme
import androidx.compose.material.OutlinedTextField
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.compose.rememberNavController
import com.example.kaomia.R
import com.example.kaomia.Screen
import com.example.kaomia.ui.screens.explorations.Loading
import com.example.kaomia.ui.screens.explorations.explorationCardItem
import com.example.kaomia.ui.theme.FirstComposeTheme

@Composable
fun LoginScreen(navController: NavHostController, loginViewModel: LoginViewModel = viewModel()) {
    val context = LocalContext.current
    var username by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }
    var isConnected by remember { mutableStateOf(false) }
    var isError by remember { mutableStateOf(false) }
    val loginUIState by loginViewModel.loginUIState.collectAsState()

    when (val state = loginUIState) {
        is LoginUIState.Error -> {
            Log.d("Error", state.exception.toString())

            if (!isError) {
                isError = true
                Toast.makeText(context, stringResource(R.string.login_error), Toast.LENGTH_LONG).show()
            }
        }
        LoginUIState.Loading -> Unit
        is LoginUIState.Success -> {
            LaunchedEffect(Unit) {
                loginViewModel.saveExplorerToDataStore(context, state.loginResponse)
            }
            navController.navigate(Screen.Profile.route)
            if (!isConnected)
                Toast.makeText(context,
                    stringResource(R.string.welcome_message, state.loginResponse.explorer.name),
                    Toast.LENGTH_LONG).show()
            isConnected = true
        }
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.Top,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {

        Column(modifier = Modifier.padding(0.dp, 32.dp, 0.dp, 32.dp)) {
            Image(
                painter = painterResource(id = R.drawable.astronaut),
                contentDescription = null,
                contentScale = ContentScale.Crop,
                modifier = Modifier
                    .size(180.dp)
            )
            Text(
                "Kaomia",
                style = MaterialTheme.typography.h2,
                fontFamily = FontFamily.SansSerif,
                fontWeight = FontWeight.Bold
            )
        }

        Text(stringResource(Screen.Login.title), style = MaterialTheme.typography.h4)

        Spacer(modifier = Modifier.height(16.dp))

        OutlinedTextField(
            value = username,
            onValueChange = { username = it },
            label = { Text(stringResource(id = R.string.username)) },
            singleLine = true,
            keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Text)
        )

        Spacer(modifier = Modifier.height(16.dp))

        OutlinedTextField(
            value = password,
            onValueChange = { password = it },
            label = { Text(stringResource(id = R.string.password)) },
            singleLine = true,
            visualTransformation = PasswordVisualTransformation(),
            keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Password)
        )

        Spacer(modifier = Modifier.height(16.dp))

        Button(onClick = { isError = false; loginViewModel.loginExplorer(username, password, context) }
        ) {
            Text(stringResource(id = R.string.connect))
        }

        Button(onClick = { navController.navigate(Screen.CreateAccount.route) }) {
            Text(stringResource(id = R.string.create_an_account))
        }
    }
}
