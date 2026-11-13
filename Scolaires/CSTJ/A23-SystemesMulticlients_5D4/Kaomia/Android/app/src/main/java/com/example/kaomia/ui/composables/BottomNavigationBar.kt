
package com.example.kaomia.ui.composables

import androidx.compose.foundation.layout.RowScope
import androidx.compose.material.Scaffold
import androidx.compose.material3.Icon
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.NavigationBarItemDefaults
import androidx.compose.material3.Text
import androidx.navigation.NavController
import androidx.compose.runtime.Composable
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.navigation.compose.rememberNavController
import com.example.kaomia.R
import com.example.kaomia.ui.theme.FirstComposeTheme

@Composable
fun BottomNavigationBar(navController: NavController) {
    val items = listOf(
        BottomNavItem.Profile,
        BottomNavItem.Allies,
        BottomNavItem.Explorations
    )
    NavigationBar {
        items.forEach {
            AddItem(screen = it, navController)
        }
    }
}

@Composable
fun RowScope.AddItem(screen: BottomNavItem, navController: NavController) {
    NavigationBarItem(
        label = { Text(text = screen.title)},
        selected = true,
        onClick = { navController.navigate(screen.title) },
        icon = { Icon(painter = painterResource(id = screen.icon), contentDescription = screen.title) },
        colors = NavigationBarItemDefaults.colors()
    )
}

sealed class BottomNavItem(var title: String, var icon: Int) {
    object Profile: BottomNavItem("Profile", R.drawable.baseline_person_24)
    //object Home: BottomNavItem("Home", R.drawable.baseline_home_24)
    object Allies: BottomNavItem("Allies", R.drawable.baseline_groups_24)
    object Explorations: BottomNavItem("Explorations", R.drawable.baseline_explore_24)
}

//@Preview(showBackground = true)
@Composable
fun ScreenPreview() {
    val navController = rememberNavController()
    FirstComposeTheme {
        BottomNavigationBar(navController)
    }
}
