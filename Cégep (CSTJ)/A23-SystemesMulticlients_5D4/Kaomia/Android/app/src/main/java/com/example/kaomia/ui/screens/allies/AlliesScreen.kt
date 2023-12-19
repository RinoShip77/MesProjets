package com.example.kaomia.ui.screens.allies

import android.util.Log
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.CornerSize
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.MaterialTheme
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavController
import androidx.navigation.NavHostController
import androidx.navigation.compose.rememberNavController
import com.example.kaomia.Screen
import com.example.kaomia.models.Ally
import com.example.kaomia.ui.theme.FirstComposeTheme
import com.example.kaomia.ui.theme.OffWhite
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import coil.compose.rememberAsyncImagePainter
import com.example.kaomia.R
import com.example.kaomia.core.Constants
import com.example.kaomia.core.Tools
import com.example.kaomia.core.Tools.BackgroundImage
import com.example.kaomia.core.Tools.getAffinity
import com.example.kaomia.core.Tools.getAllyBook
import com.example.kaomia.ui.composables.LoadingSpinner
import java.net.URLEncoder
import java.nio.charset.StandardCharsets

@Composable
fun AlliesScreen(navController: NavHostController, alliesViewModel: AlliesViewModel = viewModel()) {
    val alliesUIState by alliesViewModel.alliesUIState.collectAsState()
    val context = LocalContext.current
    val explorerData by Tools.getExplorerData(context).collectAsState(initial = null)

    LaunchedEffect(true) {
        explorerData?.let {
            alliesViewModel.retrieveAllAllies(it)
        }
    }

    Surface(modifier = Modifier.fillMaxSize()) {
        Box(
            modifier = Modifier.fillMaxSize()
        ) {
            BackgroundImage()
            Card(modifier = Modifier
                .fillMaxSize()
                .padding(12.dp),
                shape = RoundedCornerShape(corner = CornerSize(15.dp)),
                colors = CardDefaults.cardColors(containerColor = OffWhite.copy(alpha = 0.5f))
            ) {

                when(val state = alliesUIState) {
                    is AlliesUIState.Error -> {
                        Log.d("Error", state.exception.toString())
                    }
                    AlliesUIState.Loading -> {
                        Column(
                            modifier = Modifier.fillMaxSize(),
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.Center
                        ) {
                            LoadingSpinner()
                        }
                    }
                    is AlliesUIState.Success -> {
                        LazyVerticalGrid(
                            columns = GridCells.Fixed(2),
                            contentPadding = PaddingValues(8.dp),
                            verticalArrangement = Arrangement.Top
                        ) {
                            val sortedAllies = state.allies.sortedByDescending { it.createdAt }

                            items(sortedAllies) { ally ->
                                AllyView(ally, navController)
                            }
                        }
                    }
                }
            }
        }
    }
}

@Composable
private fun AllyView(ally: Ally, navController: NavController) {
    val encodedUrl = URLEncoder.encode(ally.href, StandardCharsets.UTF_8.toString())
    Card(
        modifier = Modifier
            .fillMaxSize()
            .clickable {
                navController.navigate(
                    Screen.Ally.route
                        .replace("{href}", encodedUrl)
                )
            }
            .padding(6.dp),
        colors = CardDefaults.cardColors(containerColor = OffWhite),
        shape = MaterialTheme.shapes.medium,
        ) {
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(Color.Transparent)
        ) {
            Image(
                painter = painterResource(id = R.drawable.card_background),
                contentDescription = null,
                modifier = Modifier.fillMaxSize(),
                contentScale = ContentScale.Inside
            )
            Column(
                verticalArrangement = Arrangement.Top,
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = Modifier
                    .fillMaxSize()
                    .padding(8.dp)
                    .background(Color.Transparent)
            ) {
                AllyPicture(ally)
                AllyName(ally)
                AllyAttributes(ally)
            }
        }
    }
}

@Composable
private fun AllyPicture(ally: Ally) {
    val painter: Painter = rememberAsyncImagePainter(model = ally.asset)
    Image(
        painter = painter,
        contentDescription = null,
        modifier = Modifier
            .size(100.dp),
        contentScale = ContentScale.Inside,
    )
}

@Composable
private fun AllyName(ally: Ally) {
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .fillMaxHeight()
            .padding(0.dp, 8.dp, 0.dp, 8.dp)
            .shadow(8.dp)
            .background(Color.DarkGray)
    ) {
        Text(
            text = ally.name,
            color = Color.White,
            textAlign = TextAlign.Center,
            fontWeight = FontWeight.Bold,
            modifier = Modifier
                .fillMaxWidth()
                .padding(0.dp, 8.dp, 0.dp, 8.dp)
        )
    }
}

@Composable
private fun AllyAttributes(ally: Ally) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .background(Color.DarkGray)
            .padding(8.dp),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        AllyAttribute(getAllyBook(ally.books.elementAt(0)))
        AllyAttribute(getAffinity(ally.affinity))
        AllyAttribute(getAllyBook(ally.books.elementAt(1)))
    }
}

@Composable
fun AllyAttribute(id: Int) {
    Image(
        painter = painterResource(id),
        contentDescription = null,
        modifier = Modifier
            .width(32.dp),
        contentScale = ContentScale.Inside,
    )
}