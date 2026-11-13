package com.example.kaomia

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navigation
import com.example.kaomia.ui.composables.BottomNavigationBar
import com.example.kaomia.ui.screens.explorations.ExplorationsScreen
import com.example.kaomia.ui.screens.allies.AlliesScreen
import com.example.kaomia.ui.screens.ally.AllyScreen
import com.example.kaomia.ui.screens.create_account.CreateAccountScreen
import com.example.kaomia.ui.screens.exploration.ExplorationScreen
import com.example.kaomia.ui.screens.login.LoginScreen
import com.example.kaomia.ui.screens.profile.ProfileScreen
import com.example.kaomia.R
import com.example.kaomia.ui.screens.scan.ScanScreen

//https://nameisjayant.medium.com/nested-navigation-in-jetpack-compose-597ecdc6eebb

@Composable
fun NavigationApp(
    navController: NavHostController = rememberNavController()) {

    NavHost(
        navController = navController,
        startDestination = Screen.Login.route
    ) {
        composable(Screen.Login.route, content = { LoginScreen(navController) })
        composable(Screen.CreateAccount.route,content = { CreateAccountScreen(navController = navController) })
        composable(Screen.Ally.route, content = {
            val href = it.arguments?.getString("href")!!
            BottomNavScreen(navController) {
                AllyScreen(href)
            }
        })
        composable(Screen.Exploration.route,content = {
            val key = it.arguments?.getString("key")!!
            BottomNavScreen(navController) {
                ExplorationScreen(navController, key)
            }
        })
        composable(Screen.Scan.route, content = {
            ScanScreen(navController)
        })

        navigation(route = Screen.Home.route, startDestination = Screen.Profile.route) {
            composable(Screen.Profile.route) {
                BottomNavScreen(navController) {
                    ProfileScreen(navController)
                }
            }
            composable(Screen.Explorations.route)  {
                BottomNavScreen(navController) {
                    ExplorationsScreen(navController)
                }
            }
            composable(Screen.Allies.route)  {
                BottomNavScreen(navController) {
                    AlliesScreen(navController)
                }
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BottomNavScreen(navController:NavHostController, content: @Composable () -> Unit) {
    Scaffold(
        bottomBar = { BottomNavigationBar(navController) }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(bottom = paddingValues.calculateBottomPadding())
        ) {
            content()
        }
    }
}

//sealed class Screens(@StringRes val title: Int) {
sealed class Screen(val title: Int, val route: String) {

    object Login : Screen(R.string.login_title, route = "login")
    object CreateAccount : Screen(R.string.create_account_title, route = "create-account")
    object Home : Screen(R.string.home_title, route = "home")
    object Allies : Screen(R.string.allies_title, route = "allies")
    object Profile: Screen(R.string.profile_title, route = "profile")
    object Ally: Screen(R.string.ally_title, route = "ally/{href}")

    object Explorations: Screen(R.string.explorations_title, route = "Explorations")
    object Exploration: Screen(R.string.exploration_title, route = "Exploration/{key}")

    object Scan:Screen(R.string.scan_title,route = "scan")

}