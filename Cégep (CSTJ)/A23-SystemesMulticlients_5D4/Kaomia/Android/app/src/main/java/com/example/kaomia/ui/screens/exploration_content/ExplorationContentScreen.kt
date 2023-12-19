package com.example.kaomia.ui.screens.exploration_content

import android.util.Log
import android.widget.Toast
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.foundation.layout.wrapContentSize
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
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.zIndex
import androidx.lifecycle.viewmodel.compose.viewModel
import coil.compose.rememberAsyncImagePainter
import com.example.kaomia.R
import com.example.kaomia.core.Tools
import com.example.kaomia.core.Tools.BackgroundImage
import com.example.kaomia.core.Tools.CardTitle
import com.example.kaomia.core.Tools.DisplayInoxCount
import com.example.kaomia.models.Ally
import com.example.kaomia.models.Exploration
import com.example.kaomia.ui.composables.LoadingSpinner
import com.example.kaomia.ui.screens.exploration.ElementView
import com.example.kaomia.ui.screens.exploration.ExplorationViewModel
import com.example.kaomia.ui.theme.FirstComposeTheme
import com.example.kaomia.ui.theme.OffWhite

private var _isSurfaceVisible by mutableStateOf(true)
private var _isAllyVisible by mutableStateOf(true)
private var _isBonusChestVisible by mutableStateOf(true)

@Composable
fun ExplorationContentScreen(exploration: Exploration) {
    prepareContent(exploration)

    if (_isSurfaceVisible) {
        Box(
            modifier = Modifier
                .fillMaxSize()
                .zIndex(1f)
        ) {
            BackgroundImage()
            Surface(
                color = Color.Black.copy(alpha = 0.5f),
                modifier = Modifier
                    .fillMaxSize()
            ) {
                Column(modifier = Modifier
                    .fillMaxSize()
                    .padding(16.dp),
                    verticalArrangement = Arrangement.Center) {
                    if (exploration.ally != null && _isAllyVisible) {
                        Ally(exploration)
                    }
                    if (exploration.bonusChest != null && _isBonusChestVisible) {
                        BonusChest(exploration)
                    }
                }
            }
        }
    }
}

@Composable
fun RotatingBurstLines() {
    val infiniteTransition = rememberInfiniteTransition(label = "")
    val angle by infiniteTransition.animateFloat(
        initialValue = 0f,
        targetValue = 360f,
        animationSpec = infiniteRepeatable(
            animation = tween(8000, easing = LinearEasing),
            repeatMode = RepeatMode.Restart
        ), label = ""
    )
    Box(contentAlignment = Alignment.Center) {
        Image(
            painter = painterResource(id = R.drawable.burst_lines),
            contentDescription = null,
            modifier = Modifier
                .rotate(angle)
                .size(200.dp)
        )
        Image(
            painter = painterResource(id = R.drawable.bonus_chest),
            contentDescription = null,
            modifier = Modifier
                .size(120.dp)
        )
    }
}

@Composable
fun BonusChest(exploration: Exploration) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier.wrapContentSize()
    ) {
        RotatingBurstLines()
        Card(
            modifier = Modifier
                .wrapContentSize()
                .padding(8.dp),
            shape = RoundedCornerShape(corner = CornerSize(15.dp)),
            colors = CardDefaults.cardColors(containerColor = OffWhite.copy(alpha = 0.7f))
        ) {
            Column(
                modifier = Modifier
                    .align(Alignment.CenterHorizontally)
            ) {
                CardTitle(stringResource(id = R.string.bonus_chest_found))
                Card(
                    modifier = Modifier
                        .padding(12.dp, 12.dp, 12.dp, 0.dp)
                        .fillMaxWidth()
                        .wrapContentHeight(),
                    colors = CardDefaults.cardColors(containerColor = OffWhite),
                    elevation = CardDefaults.cardElevation(defaultElevation = 6.dp)
                ) {
                    exploration.bonusChest?.let { DisplayInoxCount(it.inox) }
                }
                BonusChestElements(exploration)
                Button(
                    onClick = { closeBonusChest(exploration) },
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(4.dp)
                ) {
                    Text(text = stringResource(id = R.string.next), color = Color.White)
                }
            }
        }
    }
}

@Composable
fun BonusChestElements(exploration: Exploration) {
    LazyVerticalGrid(
        columns = GridCells.Fixed(5),
        contentPadding = PaddingValues(8.dp),
        verticalArrangement = Arrangement.Top,
        modifier = Modifier.wrapContentSize()
    ) {
        exploration.bonusChest?.let {
            items(it.elements) { element ->
                ElementView(element)
            }
        }
    }
}

@Composable
fun Ally(exploration: Exploration) {
    val captureAllyViewModel: CaptureAllyViewModel = viewModel()
    val captureAllyUIState by captureAllyViewModel.captureAllyUIState.collectAsState()

    val context = LocalContext.current
    val explorerData by Tools.getExplorerData(context).collectAsState(initial = null)

    when(val state = captureAllyUIState) {
        is CaptureAllyUIState.Error -> {
            Log.d("Error", state.exception.toString())
            Toast.makeText(context, stringResource(R.string.ally_capture_error),
                Toast.LENGTH_LONG).show()
        }
        CaptureAllyUIState.Loading -> Unit
        is CaptureAllyUIState.Success -> {
            closeAlly(exploration)
        }
    }

    Card(
        modifier = Modifier
            .wrapContentSize()
            .padding(8.dp),
        shape = RoundedCornerShape(corner = CornerSize(15.dp)),
        colors = CardDefaults.cardColors(containerColor = OffWhite.copy(alpha = 0.7f))
    ) {
        Column {
            CardTitle(stringResource(id = R.string.ally_found))
            Column(modifier = Modifier
                .padding(8.dp)
            ) {
                exploration.ally?.let { AllyName(it) }
                exploration.ally?.let { AllyContent(it) }
            }
        }
        Button(
            onClick = { explorerData?.let { exploration.capture_href?.let { href ->
                captureAllyViewModel.captureAlly(it.tokens,
                    href
                )} }
            },
            modifier = Modifier
                .fillMaxWidth()
                .padding(4.dp)
        ) {
            Text(text = stringResource(id = R.string.capture), color = Color.White)
        }
        Button(
            onClick = { closeAlly(exploration) },
            modifier = Modifier
                .fillMaxWidth()
                .padding(4.dp)
        ) {
            Text(text = stringResource(id = R.string.without_capture), color = Color.White)
        }
    }
}

@Composable
fun AllyName(ally: Ally) {
    Card(modifier = Modifier
        .fillMaxWidth()
        .padding(4.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 6.dp),
        shape = RoundedCornerShape(corner = CornerSize(8.dp)),
        colors = CardDefaults.cardColors(containerColor = OffWhite)) {
        Text(
            modifier = Modifier
                .fillMaxWidth()
                .padding(6.dp),
            text = ally.name,
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            textAlign = TextAlign.Center
        )
    }
}

@Composable
fun AllyContent(ally: Ally) {
    val painter: Painter = rememberAsyncImagePainter(model = ally.asset)

    Row {
        Box(modifier = Modifier
            .weight(1f)
            .aspectRatio(1f)
            .align(Alignment.CenterVertically)
        ) {
            Image(
                painter = painterResource(R.drawable.card_background),
                contentDescription = null,
                modifier = Modifier
                    .aspectRatio(1f),
                contentScale = ContentScale.Inside
            )
            Image(
                painter = painter,
                contentDescription = null,
                modifier = Modifier
                    .aspectRatio(1f),
                contentScale = ContentScale.Crop
            )
        }

        Column(modifier = Modifier
            .weight(2f)) {
            AllyAffinityBooks(ally)
            AllyStats(ally)
        }
    }
    AllyKernel(ally)
}

@Composable
private fun AllyAffinityBooks(ally: Ally) {
    Card(modifier = Modifier
        .wrapContentSize()
        .padding(4.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 6.dp),
        shape = RoundedCornerShape(corner = CornerSize(8.dp)),
        colors = CardDefaults.cardColors(containerColor = OffWhite)
    ) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column(
                modifier = Modifier.weight(1f),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                AllyAffinityBookDisplay(Tools.getAllyBook(ally.books.elementAt(0)))
            }
            Column(
                modifier = Modifier.weight(1f),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                AllyAffinityBookDisplay(Tools.getAffinity(ally.affinity))
            }
            Column(
                modifier = Modifier.weight(1f),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                AllyAffinityBookDisplay(Tools.getAllyBook(ally.books.elementAt(1)))
            }
        }
    }
}

@Composable
private fun AllyAffinityBookDisplay(id: Int) {
    Image(
        painter = painterResource(id = id),
        contentDescription = null,
        modifier = Modifier
            .padding(8.dp)
            .wrapContentSize()
            .size(50.dp),
        contentScale = ContentScale.Inside
    )
}

@Composable
private fun AllyStats(ally: Ally) {
    Card(modifier = Modifier
        .wrapContentSize()
        .padding(4.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 6.dp),
        shape = RoundedCornerShape(corner = CornerSize(8.dp)),
        colors = CardDefaults.cardColors(containerColor = OffWhite)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(8.dp),
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
        .padding(4.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 6.dp),
        shape = RoundedCornerShape(corner = CornerSize(8.dp)),
        colors = CardDefaults.cardColors(containerColor = OffWhite)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(4.dp),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            ally.kernel.forEach { element ->
                Column(
                    modifier = Modifier.weight(1f),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    AllyElementsDisplay(Tools.getKernelElementDrawable(element), element)
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
        modifier = Modifier.size(40.dp),
        contentScale = ContentScale.FillWidth
    )
    Text(text = name)
}

@Composable
private fun AllyStatDisplay(id: Int, stat: String) {
    Image(
        painter = painterResource(id = id),
        contentDescription = null,
        modifier = Modifier.size(30.dp),
        contentScale = ContentScale.FillWidth
    )
    androidx.compose.material3.Text(
        text = stat,
        fontSize = 16.sp,
        fontWeight = FontWeight.Bold
    )
}

fun prepareContent(exploration: Exploration) {
    _isAllyVisible = false
    _isBonusChestVisible = false

    if (!exploration.hasBeenSeen!!) {
        _isSurfaceVisible = true
        if (exploration.bonusChest != null)
            _isBonusChestVisible = true
        else
            _isAllyVisible = true
    }
}

fun closeBonusChest(exploration: Exploration) {
    if (exploration.ally != null) {
        _isBonusChestVisible = false
        exploration.hasBeenSeen = true
        _isAllyVisible = true
    }
    else {
        _isSurfaceVisible = false
        exploration.hasBeenSeen = true
    }
}

fun closeAlly(exploration: Exploration) {
    _isSurfaceVisible = false
    exploration.hasBeenSeen = true
}