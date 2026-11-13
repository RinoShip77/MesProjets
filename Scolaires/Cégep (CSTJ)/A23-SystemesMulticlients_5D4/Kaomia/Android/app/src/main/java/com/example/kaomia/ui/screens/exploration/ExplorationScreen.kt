package com.example.kaomia.ui.screens.exploration

import android.util.Log
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.foundation.layout.wrapContentWidth
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.CornerSize
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Text
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Alignment.Companion.CenterHorizontally
import androidx.compose.ui.Alignment.Companion.CenterVertically
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavController
import androidx.navigation.compose.rememberNavController
import com.example.kaomia.R
import com.example.kaomia.Screen
import com.example.kaomia.core.Tools
import com.example.kaomia.core.Tools.BackgroundImage
import com.example.kaomia.core.Tools.CardTitle
import com.example.kaomia.core.Tools.DisplayInoxCount
import com.example.kaomia.core.Tools.getAffinity
import com.example.kaomia.core.Tools.parseDateWithTime
import com.example.kaomia.models.Element
import com.example.kaomia.models.Exploration
import com.example.kaomia.ui.composables.LoadingSpinner
import com.example.kaomia.ui.screens.exploration_content.ExplorationContentScreen
import com.example.kaomia.ui.theme.FirstComposeTheme
import com.example.kaomia.ui.theme.OffWhite

@Composable
fun ExplorationScreen(navController: NavController, key: String) {
    val explorationViewModel: ExplorationViewModel = viewModel()
    val explorationUIState by explorationViewModel.explorationUIState.collectAsState()

    val context = LocalContext.current
    val explorerData by Tools.getExplorerData(context).collectAsState(initial = null)

    LaunchedEffect(Unit) {
        explorerData?.let { explorationViewModel.makeExploration(it, key) }
    }


    when(val state = explorationUIState) {
        is ExplorationUIState.Error -> {
            Log.d("Error", state.exception.toString())
        }
        ExplorationUIState.Loading -> {
            Column(
                modifier = Modifier.fillMaxSize(),
                horizontalAlignment = CenterHorizontally,
                verticalArrangement = Arrangement.Center
            ) {
                LoadingSpinner()
            }
        }
        is ExplorationUIState.Success -> {
            ExplorationView(state.exploration, navController)
        }
    }
}

@Composable
fun ExplorationView(exploration: Exploration, navController: NavController) {
    Box(
        modifier = Modifier.fillMaxSize()
    ) {
        BackgroundImage()

        if ((exploration.ally != null || exploration.bonusChest != null) && !exploration.hasBeenSeen!!) {
            ExplorationContentScreen(exploration)
        }

        Column(modifier = Modifier
            .fillMaxSize().padding(12.dp),
        ) {
            Column(modifier = Modifier.weight(1f),
                verticalArrangement = Arrangement.Center) {
                DestinationCard(exploration)
                if (exploration.vault.elements.isNotEmpty()) {
                    Vault(exploration)
                }
            }
            Card(elevation = CardDefaults.cardElevation(defaultElevation = 6.dp),
                shape = RoundedCornerShape(corner = CornerSize(15.dp)),
                colors = CardDefaults.cardColors(containerColor = OffWhite)
            ) {
                Button(
                    onClick = { navController.navigate(Screen.Scan.route) },
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp)) {
                    Text(stringResource(id = R.string.travel), color = Color.White)
                }
            }
        }
    }
}

@Composable
fun DestinationCard(exploration: Exploration) {
    Card(
        modifier = Modifier
            .wrapContentHeight()
            .fillMaxWidth()
            .padding(12.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 6.dp),
        shape = RoundedCornerShape(corner = CornerSize(15.dp)),
        colors = CardDefaults.cardColors(containerColor = OffWhite)
    ) {
        Column(modifier = Modifier.align(CenterHorizontally)
        ) {
            CardTitle(stringResource(id = R.string.destination))
            Row(modifier = Modifier,
                verticalAlignment = CenterVertically
            ) {
                Image(
                    painter = painterResource(id = getAffinity(exploration.affinity)),
                    contentDescription = null,
                    modifier = Modifier
                        .size(80.dp)
                        .padding(16.dp),
                    alignment = Alignment.Center
                )
                Column(modifier = Modifier.padding(8.dp)) {
                    Text(
                        modifier = Modifier.fillMaxWidth(),
                        text = exploration.destination,
                        fontSize = 20.sp,
                        fontWeight = FontWeight.Bold,
                        textAlign = TextAlign.Center
                    )
                    Text(
                        modifier = Modifier.align(CenterHorizontally),
                        text = parseDateWithTime(exploration.explorationDate)
                    )
                }
            }
        }
    }
}

@Composable
fun Vault(exploration: Exploration) {
    Card(
        modifier = Modifier
            .wrapContentHeight()
            .fillMaxWidth()
            .padding(12.dp),
        shape = RoundedCornerShape(corner = CornerSize(15.dp)),
        colors = CardDefaults.cardColors(containerColor = OffWhite.copy(alpha = 0.5f))
    ) {
        Column(
            modifier = Modifier.align(CenterHorizontally)
        ) {
            CardTitle(stringResource(id = R.string.vault_content))
            Card(modifier = Modifier
                .padding(12.dp, 12.dp, 12.dp, 0.dp)
                .fillMaxWidth()
                .wrapContentHeight(),
                colors = CardDefaults.cardColors(containerColor = OffWhite),
                elevation = CardDefaults.cardElevation(defaultElevation = 6.dp)
            ) {
                exploration.vault.inox?.let { DisplayInoxCount(it) }
            }
            LazyVerticalGrid(
                columns = GridCells.Fixed(4),
                contentPadding = PaddingValues(8.dp)
            ) {
                items(exploration.vault.elements) { element ->
                    ElementView(element)
                }
            }
        }
    }
}

@Composable
fun ElementView(element: Element) {
    Card(
        modifier = Modifier
            .wrapContentSize()
            .padding(4.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 6.dp),
        shape = RoundedCornerShape(corner = CornerSize(8.dp)),
        colors = CardDefaults.cardColors(containerColor = OffWhite)
    ) {
        ElementName(element)
        ElementDrawable(element)
        ElementQuantity(element)
    }
}

@Composable
fun ElementName(element: Element) {
    Box(modifier = Modifier
        .fillMaxWidth()
        .background(Color.DarkGray)
    ) {
        Text(
            text = element.element,
            textAlign = TextAlign.Center,
            fontWeight = FontWeight.Bold,
            color = Color.White,
            fontSize = 15.sp,
            modifier = Modifier
                .padding(0.dp, 8.dp, 0.dp, 8.dp)
                .fillMaxWidth()
        )
    }
}

@Composable
fun ElementDrawable(element: Element) {
    Image(
        painter = painterResource(Tools.getKernelElementDrawable(element.element)),
        contentDescription = null,
        modifier = Modifier
            .fillMaxWidth()
            .padding(8.dp, 0.dp, 8.dp, 0.dp),
        contentScale = ContentScale.FillWidth
    )
}

@Composable
fun ElementQuantity(element: Element) {
    Text(
        text = "× ${element.quantity}",
        textAlign = TextAlign.Center,
        modifier = Modifier
            .padding(8.dp, 0.dp, 8.dp, 8.dp)
            .fillMaxWidth()
    )
}