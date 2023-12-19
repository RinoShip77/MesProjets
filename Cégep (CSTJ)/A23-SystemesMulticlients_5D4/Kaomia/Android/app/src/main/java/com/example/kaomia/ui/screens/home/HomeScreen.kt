package com.example.kaomia.ui.screens.home

import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.rememberNavController

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HomeScreen(navController : NavHostController = rememberNavController()) {

    /*Scaffold(
        bottomBar = { BottomNavigationBar(navController) }
    ) { innerPadding ->
        NavHost(
            navController = navController,
            startDestination = BottomNavItem.Profile.title,
            modifier = Modifier.padding(innerPadding),
            builder = {
                composable(Screen.Profile.title, content =  { ProfileScreen() })
                composable(Screen.List.title, content =  { ListScreen() })
                composable(Screen.Analytics.title, content =  { AnalyticsScreen() })
            })
    }*/
}