package com.example.kaomia.ui.screens.explorations

import androidx.compose.runtime.getValue
import android.util.Log
import android.widget.Toast
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.paint
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.RectangleShape
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
//import androidx.compose.ui.Modifier
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.compose.rememberNavController
import com.example.kaomia.R
import com.example.kaomia.Screen
import com.example.kaomia.core.Tools
import com.example.kaomia.core.Tools.getAffinity
import com.example.kaomia.core.Tools.parseDate
import com.example.kaomia.models.Exploration
import com.example.kaomia.ui.composables.LoadingSpinner
import com.example.kaomia.ui.screens.ally.AllyScreen
import com.example.kaomia.ui.theme.FirstComposeTheme


@Composable
fun ExplorationsScreen(navController: NavHostController, explorationsViewModel: ExplorationsViewModel = viewModel()){
    val explorationsUiState by explorationsViewModel.explorationsUiState.collectAsState()
    val context = LocalContext.current
    val explorerData by Tools.getExplorerData(context).collectAsState(initial = null)

    LaunchedEffect(true) {
        explorerData?.let {
            explorationsViewModel.retrieveAllExploration(it)
        }
    }

    Column(modifier = Modifier.fillMaxSize()) {
        Surface(modifier = Modifier.weight(1f)) {
            when(val state = explorationsUiState){
                is ExplorationsUiState.Error ->{
                    Log.d("ERROR",state.exception.toString())
                    Toast.makeText(context, "Impossible de récupérer les explorations",
                        Toast.LENGTH_SHORT).show()
                }
                ExplorationsUiState.Loading ->{
                    Loading()
                }
                is ExplorationsUiState.Success ->{
                    ExplorationList(state.explorations)
                }
            }
        }
        Button(
            onClick = { navController.navigate(Screen.Scan.route) },
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp)) {
            Text("Voyager")
        }
    }
}

@Composable
fun Loading() {
    Column(
        modifier = Modifier.fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        LoadingSpinner()
    }
}

@Composable
fun ExplorationList(explorations: List<Exploration>){
    LazyColumn{
        items(explorations){exploration ->
            explorationCardItem(exploration = exploration)
        }
    }
}
@Composable
fun explorationCardItem(exploration: Exploration) {
    Card(
         modifier = Modifier.padding(5.dp), shape = RectangleShape) {
        Box{
            Image(alpha = 0.6f,modifier = Modifier.fillMaxSize().background(findAffinityColor(exploration = exploration)),contentScale = ContentScale.FillBounds,painter = painterResource(id = R.drawable.card_background), contentDescription = "bgc" )
            Column (modifier = Modifier
                .padding(horizontal = 20.dp)
                .fillMaxSize()
                ){
                Text(text = "destination: "+exploration.destination, fontSize = 30.sp)
                Row (modifier = Modifier.paint(painterResource(id = getAffinity(exploration.affinity)))){
                    Text(text = parseDate(exploration.explorationDate), fontSize = 20.sp)
                    Text(text = "affinity: "+exploration.affinity, fontSize = 20.sp)
                }
            }
        }



    }
}


fun findAffinityColor(exploration: Exploration): Color {

    when(exploration.affinity){
        "air" ->  return Color(204,255,255)
        "darkness"-> return Color(153,0,153)
        "earth"-> return Color(255,229,204)
        "energy"->return Color(0,255,255)
        "fire"->return Color(255,128,0)
        "life"->return Color(204,255,204)
        "light"->return Color(255,255,102)
        "logic"->return Color(204,204,0)
        "music"->return Color(255,204,255)
        "space"->return Color(0,0,102)
        "toxic"->return Color(153,255,153)
        "water"->return Color(153,204,255)
    }
    return Color.LightGray
}
