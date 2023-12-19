package com.example.kaomia.ui.screens.create_account

import android.content.Context
import android.util.Log
import android.widget.Toast
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.MaterialTheme
import androidx.compose.material.OutlinedTextField
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import com.example.kaomia.Screen
import androidx.compose.runtime.*
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.toLowerCase
import androidx.compose.ui.tooling.preview.Preview
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.compose.rememberNavController
import com.example.kaomia.ui.theme.FirstComposeTheme
import com.example.kaomia.R
import java.util.Locale

var isPasswordValid by mutableStateOf(true)

@Composable
fun CreateAccountScreen(
    navController: NavHostController,
    createAccountViewModel: CreateAccountViewModel = viewModel()
) {
    val context = LocalContext.current
    var email by remember { mutableStateOf("") }
    var username by remember { mutableStateOf("") }
    var name by remember { mutableStateOf("") }
    var surname by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }
    var passwordConfirmation by remember { mutableStateOf("") }

    val createAccountUIState by createAccountViewModel.createAccountUIState.collectAsState()
    var isConnected by remember { mutableStateOf(false) }

    when (val state = createAccountUIState) {
        is CreateAccountUIState.Error -> {
            Log.d("Error", state.exception.toString())
            Toast.makeText(context, stringResource(R.string.account_create_error),
                Toast.LENGTH_LONG).show()
        }
        CreateAccountUIState.Loading -> Unit
        is CreateAccountUIState.Success -> {
            LaunchedEffect(Unit) {
                createAccountViewModel.saveExplorerToDataStore(context, state.loginResponse)
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
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {

        Text(stringResource(Screen.CreateAccount.title), style = MaterialTheme.typography.h4)

        Spacer(modifier = Modifier.height(16.dp))

        OutlinedTextField(
            value = email,
            onValueChange = { email = it },
            label = { Text(stringResource(id = R.string.email)) },
            singleLine = true,
            keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Email)
        )

        Spacer(modifier = Modifier.height(16.dp))

        OutlinedTextField(
            value = username,
            onValueChange = { username = it },
            label = { Text(stringResource(id = R.string.username)) },
            singleLine = true
        )

        Spacer(modifier = Modifier.height(16.dp))

        OutlinedTextField(
            value = name,
            onValueChange = { name = it },
            label = { Text(stringResource(id = R.string.name)) },
            singleLine = true
        )

        Spacer(modifier = Modifier.height(16.dp))

        OutlinedTextField(
            value = surname,
            onValueChange = { surname = it },
            label = { Text(stringResource(id = R.string.surname)) },
            singleLine = true
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

        OutlinedTextField(
            value = passwordConfirmation,
            onValueChange = { passwordConfirmation = it },
            label = { Text(stringResource(id = R.string.password_confirm)) },
            singleLine = true,
            visualTransformation = PasswordVisualTransformation(),
            keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Password)
        )

        Spacer(modifier = Modifier.height(16.dp))

        Button(
            onClick = {
                if (isAccountValid(
                        username,
                        email,
                        name,
                        surname,
                        password,
                        passwordConfirmation,
                        context)
                )
                {
                    createAccountViewModel.createAccount(
                        username,
                        email,
                        name,
                        surname,
                        password,
                        context
                    )
                }
            }
        ) {
            Text(stringResource(id = R.string.create_account))
        }

        Button(
            onClick = { navController.navigate(Screen.Login.route )}
        ) {
            Text(stringResource(id = R.string.cancel))
        }
    }
}

fun isAccountValid(
    username: String,
    email: String,
    name: String,
    surname: String,
    password: String,
    passwordConfirmation: String,
    context: Context
) : Boolean {

    if (username.isEmpty() || email.isEmpty() || name.isEmpty() ||
        surname.isEmpty() || password.isEmpty()) {
        Toast.makeText(context, R.string.empty_field_error, Toast.LENGTH_LONG).show()
        return false
    }

    if (!isEmailValid(email, context) ||
        !isFieldValid(username, context, context.getString(R.string.username).lowercase()) ||
        !isFieldValid(name, context, context.getString(R.string.name).lowercase()) ||
        !isFieldValid(surname, context, context.getString(R.string.surname).lowercase())
    ) {
        return false
    }

    isPasswordValid = password == passwordConfirmation
    if (!isPasswordValid) {
        Toast.makeText(context, R.string.passwords_error, Toast.LENGTH_LONG).show()
        return false
    }
    return true
}

fun isFieldValid(value: String, context: Context, fieldName: String): Boolean {
    if (value.length < 3) {
        Toast.makeText(context, context.getString(R.string.minimum_length_error, fieldName), Toast.LENGTH_LONG).show()
        return false
    }
    return true
}

fun isEmailValid(value: String, context: Context):Boolean {
    val emailRegex = Regex("^\\S+@\\S+\\.\\S+\$")
    if (!emailRegex.matches(value)) {
        Toast.makeText(context, R.string.email_error, Toast.LENGTH_LONG).show()
        return false
    }
    return true
}