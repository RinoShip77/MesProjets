package com.example.kaomia.ui.screens.ally

import android.util.Log
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.CornerSize
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import coil.compose.rememberAsyncImagePainter
import com.example.kaomia.R
import com.example.kaomia.core.Constants
import com.example.kaomia.core.Tools
import com.example.kaomia.core.Tools.BackgroundImage
import com.example.kaomia.core.Tools.getAffinity
import com.example.kaomia.core.Tools.getAllyBook
import com.example.kaomia.core.Tools.getKernelElementDrawable
import com.example.kaomia.models.Ally
import com.example.kaomia.ui.composables.LoadingSpinner
import com.example.kaomia.ui.theme.FirstComposeTheme
import com.example.kaomia.ui.theme.OffWhite

@Composable
fun AllyScreen(href: String) {
    val allyViewModel: AllyViewModel = viewModel()
    val allyUIState by allyViewModel.allyUIState.collectAsState()

    val context = LocalContext.current
    val explorerData by Tools.getExplorerData(context).collectAsState(initial = null)

    LaunchedEffect(true) {
        explorerData?.tokens?.let {
            allyViewModel.retrieveOneAlly(href, it.accessToken)
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
                elevation = CardDefaults.cardElevation(defaultElevation = 6.dp),
                shape = RoundedCornerShape(corner = CornerSize(15.dp)),
                colors = CardDefaults.cardColors(containerColor = OffWhite.copy(alpha = 0.5f))
            ) {

                when(val state = allyUIState) {
                    is AllyUIState.Error -> {
                        Log.d("Error", state.exception.toString())
                    }
                    AllyUIState.Loading -> {
                        Column(
                            modifier = Modifier.fillMaxSize(),
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.Center
                        ) {
                            LoadingSpinner()
                        }
                    }
                    is AllyUIState.Success -> {
                        AllyView(state.ally)
                    }
                }
            }
        }
    }
}

@Composable
private fun AllyView(ally: Ally) {
    Box(
        modifier = Modifier.fillMaxSize()
    ) {
        Image(
            painter = painterResource(id = R.drawable.card_background),
            contentDescription = null,
            modifier = Modifier.fillMaxSize(),
            contentScale = ContentScale.FillBounds
        )
        Column(
            modifier = Modifier
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(
                text = ally.name,
                fontSize = 36.sp,
                fontWeight = FontWeight.Bold
            )
            AllyPicture(ally)
            AllyAffinityBooks(ally)
            AllyStats(ally)
            AllyKernel(ally)
        }
    }
}

@Composable
private fun AllyPicture(ally: Ally) {
    val painter: Painter = rememberAsyncImagePainter(model = ally.asset)
    Box(
        modifier = Modifier.size(220.dp)
    ) {
        Image(
            painter = painter,
            contentDescription = null,
            contentScale = ContentScale.Crop,
            modifier = Modifier.fillMaxSize()
        )
    }
}

@Composable
private fun AllyAffinityBooks(ally: Ally) {
    Card(modifier = Modifier
            .wrapContentSize()
            .padding(8.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 6.dp),
        shape = RoundedCornerShape(corner = CornerSize(15.dp)),
        colors = CardDefaults.cardColors(containerColor = OffWhite)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(12.dp),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column(
                modifier = Modifier.weight(1f),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                AllyAffinityBookDisplay(getAllyBook(ally.books.elementAt(0)))
            }
            Column(
                modifier = Modifier.weight(1f),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                AllyAffinityBookDisplay(getAffinity(ally.affinity))
            }
            Column(
                modifier = Modifier.weight(1f),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                AllyAffinityBookDisplay(getAllyBook(ally.books.elementAt(1)))
            }
        }
    }
}

@Composable
private fun AllyAffinityBookDisplay(id: Int) {
    Box(modifier = Modifier
        .background(color = Color.DarkGray, shape = CircleShape)
        .width(80.dp)
    ) {
        Image(
            painter = painterResource(id = id),
            contentDescription = null,
            modifier = Modifier
                .padding(16.dp)
                .fillMaxWidth(),
            contentScale = ContentScale.FillWidth
        )
    }
}

@Composable
private fun AllyStats(ally: Ally) {
    Card(modifier = Modifier
        .wrapContentSize()
        .padding(8.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 6.dp),
        shape = RoundedCornerShape(corner = CornerSize(15.dp)),
        colors = CardDefaults.cardColors(containerColor = OffWhite)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(12.dp),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column(
                modifier = Modifier.weight(1f),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                AllyStatDisplay(R.drawable.life, ally.stats.life.toString())
            }
            Column(
                modifier = Modifier.weight(1f),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                AllyStatDisplay(R.drawable.speed, ally.stats.speed.toString())
            }
            Column(
                modifier = Modifier.weight(1f),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                AllyStatDisplay(R.drawable.power, ally.stats.power.toString())
            }
            Column(
                modifier = Modifier.weight(1f),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                AllyStatDisplay(R.drawable.shield, ally.stats.shield.toString())
            }
        }
    }
}

@Composable
private fun AllyKernel(ally: Ally) {
    Card(modifier = Modifier
        .wrapContentSize()
        .padding(8.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 6.dp),
        shape = RoundedCornerShape(corner = CornerSize(15.dp)),
        colors = CardDefaults.cardColors(containerColor = OffWhite)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(12.dp),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            ally.kernel.forEach { element ->
                Column(
                    modifier = Modifier
                        .weight(1f),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    AllyElementsDisplay(getKernelElementDrawable(element), element)
                }
            }
        }
    }
}

@Composable
private fun AllyElementsDisplay(id: Int, name: String) {
    Image(
        painter = painterResource(id = id),
        contentDescription = null,
        modifier = Modifier
            .size(50.dp),
        contentScale = ContentScale.FillWidth
    )
    Text(text = name)
}

@Composable
private fun AllyStatDisplay(id: Int, stat: String) {
    Image(
        painter = painterResource(id = id),
        contentDescription = null,
        modifier = Modifier
            .size(50.dp),
        contentScale = ContentScale.FillWidth
    )
    Text(text = stat,
        fontSize = 30.sp,
        fontWeight = FontWeight.Bold
    )
}